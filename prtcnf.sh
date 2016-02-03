#!/bin/ksh
# IBM_PROLOG_BEGIN_TAG 
# This is an automatically generated prolog. 
#  
# bos53L src/bos/usr/sbin/prtconf/prtconf.sh 1.14.2.1 
#  
# Licensed Materials - Property of IBM 
#  
# Restricted Materials of IBM 
#  
# COPYRIGHT International Business Machines Corp. 2001,2007 
# All Rights Reserved 
#  
# US Government Users Restricted Rights - Use, duplication or 
# disclosure restricted by GSA ADP Schedule Contract with IBM Corp. 
#  
# IBM_PROLOG_END_TAG 
# ************************************************************************ 
# *  Program: prtconf                                                    *
# *  Purpose: To list the system configuration.                          * 
# ************************************************************************ 

usage(){                                                 
        msg=`/usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 47 "Usage: prtconf [-c] [-k] [-L] [-m] [-s] [-v]"`
        echo "${msg}"
        exit 2                                           
}

# Check for command line flags
while getopts :ckLmsv args
do
    isopts=1 # If there are no command line switches, isopts undefined.
    case $args in
        c) cflag=1;;
        k) kflag=1;;
        L) Lflag=1;;
        m) mflag=1;;
        s) sflag=1;;
        v) vflag=1;;
        \?)usage;;
    esac
done    

#Add /usr/sbin to the PATH variable
export PATH=/usr/sbin:/usr/bin:$PATH

#Change LANG to C when capturing command output
oldLANG=$LANG
export LANG=C

# System information

msize=0
for i in `lscfg | grep -i mem | awk '{print $2}'`
do
        ((msize=msize + `lsattr -El mem0 | awk '/^size/ {print $2}'`))
done

procstr=`lsdev -Sa -Cc processor`

procspeed=`lsattr -El ${procstr%% *} -a frequency -F value`
cputype=`getsystype -y`
kerntype=`getsystype -K`
lparinfo=`uname -L`

# Pre-5.2, `uname -L` returns a leading "AIX"
# Check for a leading AIX and remove it
if [[ $lparinfo = AIX* ]]
then
lparinfo=${lparinfo#* }
fi


# Ensure that procspeed is not null, since the conversion to MHz below will
# cause the script to exit with an error if null.
if [[ ! -z $procspeed ]]
then
    # Convert procspeed to MHz, and round up or down
    if (( ($procspeed%1000000) >= 500000 ))
    then
    (( procspeedMHz=($procspeed/1000000) + 1 ))
    else
    (( procspeedMHz=($procspeed/1000000) ))
    fi
fi

export LANG=$oldLANG

#Handle flags
# -c
if [[ ! -z $cflag ]] then
    /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 49 "CPU Type:"
    echo " ${cputype}-bit"
fi

# -k
if [[ ! -z $kflag ]] then
    /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 50 "Kernel Type:"
    echo " ${kerntype}-bit"
fi

# -L
if [[ ! -z $Lflag ]] then
    /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 51 "LPAR Info:"
    echo " ${lparinfo}"
fi

# -m
if [[ ! -z $mflag ]] then
    /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 2 "Memory Size:"
    echo " ${msize} MB"
fi

# -s
if [[ ! -z $sflag ]] then
    /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 48 "Processor Clock Speed:"
    echo " ${procspeedMHz} MHz"
fi

# -v
if [[ ! -z $vflag ]] then
    # Switch back to orignal language before lscfg -v
    lscfg -v
fi


#If there are not command line options, do the default output
if [[ -z $isopts ]] then

# Back to C
export LANG=C

model=`lsattr -El sys0 -a modelname -F value`
# Get Serial number
serial=`lscfg -vpl sysplanar0 |grep -p "System:" |grep "Machine/Cabinet"`
if [[ $? -eq 0 ]]; then
    serial=${serial##*.}
else
    serial=`lscfg -vpl sysplanar0 |grep -p "System VPD:" |grep "Machine/Cabinet"`
    if [[ $? -eq 0 ]]; then
        serial=${serial##*.}
    else
        noserial=1
    fi
fi
gsize=`lsattr -El mem0 | awk '/^goodsize/ {print $2}'`
proc_no=`lsdev -Cc processor | head -1 | cut -d' ' -f1`
proctype=`lsattr -El $proc_no | awk '/^type/ {print $2}'`
numproc=`lsdev -Cc processor | grep Available | wc -l`
numproc=${numproc##* }

# Find the platform firmware level. The command line interface for obtaining
# the platform firmware level is different for Regatta and Squadron hardware.
# Let us first find whether the system is Squadron or not, using dmpdt_chrp.

/usr/lib/boot/bin/dmpdt_chrp 2>&1 | grep "ibm,manage-flash-image" > /dev/null 2>&1
rc=$?
if [ rc -eq 0 ]
then
        # Squadron systems
        # "lscfg -vp | grep Product Specific.(MI)" command by default will give 
        # three firmware levels : current temporary level, current permanent 
        # level & current level using which the system is booted. Since it is 
        # more appropriate to display the currently booted firmware level, lsconf 
        # will display only this value, which is the last field value.
        pfwversion=`lscfg -vp | egrep "Product Specific.\(MI\)|Microcode Image" | awk '{print $NF}'`
elif [ rc -eq 1 ]
then
        # Regatta or older systems
        pfwversion=`lscfg -vp | grep -p Platform | grep "ROM Level" | sed 's/\./ /g' | awk '{print $4}'`
fi

fwversion=`lsattr -El sys0 -a fwversion -F value`
conslogin=`lsattr -El sys0 -a conslogin -F value`
autorestart=`lsattr -El sys0 -a autorestart -F value`
fullcore=`lsattr -El sys0 -a fullcore -F value`

# Back to $oldLANG
export LANG=$oldLANG

/usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 1 "System Model:"
echo " ${model}"

#Print out serial if found, otherwise "Not available"
if [[ -z $noserial ]] then
    /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 52 "Machine Serial Number:"
    echo " ${serial}"
else
    /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 52 "Machine Serial Number:"
    print " \c"
    /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 53 "Not Available"
fi

/usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 5 "Processor Type:"
echo " ${proctype}"

/usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 4 "Number Of Processors:"
echo " ${numproc}"

/usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 48 "Processor Clock Speed:"
echo " ${procspeedMHz} MHz"

/usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 49 "CPU Type:"
echo " ${cputype}-bit"

/usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 50 "Kernel Type:"
echo " ${kerntype}-bit"

/usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 51 "LPAR Info:"
echo " ${lparinfo}"

/usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 2 "Memory Size:"
echo " ${msize} MB"

/usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 3 "Good Memory Size:"
echo " ${gsize} MB"

#Print out Platform Firmware level if found, otherwise "Not available"
if [[ -n $pfwversion ]]; then
    /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 54 "Platform Firmware level:"
    echo " ${pfwversion}"
else
    /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 54 "Platform Firmware level:"
    print " \c"
    /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 53 "Not Available"
    echo
fi

/usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 6 "Firmware Version:"
echo " ${fwversion}"

/usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 7 "Console Login:"
echo " ${conslogin}"

/usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 8 "Auto Restart:"
echo " ${autorestart}"

/usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 9 "Full Core:"
echo " ${fullcore}"                                               

echo " "
#Back to C
export LANG=C
# Network Information
     VimDATA="/tmp/$$"
     #  Discover the interfaces. loopback (lo0) and Tunnel (cti*) are not
     #  configurable interfaces. Serial optical is not support for this
     #  release.
     INTERFACES=`lsdev -Cc if -F name | grep -v "^lo" | grep -v "^cti" | grep -v "^so" | grep -v "^ca" | grep -v "^es" | awk '{printf "%s,",$1}'`
     INTERFACES=${INTERFACES%,}
     addr6=""
     prefixlen=""
     OUTPUT=""
     lssrc -s dhcpcd | grep active >/dev/null
     RC=$?
     if [[ $RC -eq 0 ]] ; then
         # this is a dhcp client machine
         dhcp_ipaddr=`lssrc -ls dhcpcd | grep -v "^Log" | grep -v "^Tracing" | grep -v "^ " | grep -v "^Subsystem" | grep -v dhcpcd | grep -v "^Interface" | awk '{printf "%s",$2}'`
         IF=`lssrc -ls dhcpcd | grep -v "^Log" | grep -v "^Tracing" | grep -v "^ " | grep -v "^Subsystem" | grep -v dhcpcd | grep -v "^Interface" | awk '{printf "%s,",$1}'`
         IF=${IF%%,*}
         echo $IF
         CONFIG_MODE=DHCP
     #  Discover the first configured (i.e. state is available) interface
     else
        IF=`netstat -rn | grep default | grep -v "link" | awk '{printf "%s,",$6}'`
        IF=${IF%%,*}
        if [ -z "$IF" ]; then
          IF=`lsdev -Cc if -S a -F name | grep -v "^lo0" | awk '{printf "%s,",$1}'`
          IF=${IF%%,*}
        fi
        #echo $IF
        #  if there is no configured interface and there are interfaces, get
        #  the first one.
        if [ -z "$IF" -a  -n "$INTERFACES" ]; then
           IF=${INTERFACES%%,*}
        fi
        #  After all this, there is no interface, i.e. no LAN device is available
        #  If TCPIP client package is installed, we will have loop back configured,
        #  so use it.
        if [ -z "$IF" ]; then
           IF="lo0"
        fi
        #echo $IF
        CONFIG_MODE=Basic
        if [ "$IF" != "lo0" ]; then
          # get IPv6 address and prefixlen if available
          addr6=`odmget -q "name=$IF and attribute=netaddr6" CuAt | grep value | awk '{print $3}' | sed 's/"//g'`
          if [ -n "${addr6}" ]; then
            addr6=`echo $addr6 | sed 's/:/\\\\\\\\\\\\\\\\\\:/g'`
          fi
          prefixlen=`odmget -q "name=$IF and attribute=prefixlen" CuAt | grep value | awk '{print $3}' | sed 's/"//g'`
        fi
     fi
     #  Discover the existing configuration data for the interface.
     case $IF in
         at[0-7] ) /usr/sbin/mktcpip.atm -S $IF 2>${VimDATA}.mktcpip
                   ;;
         * ) /usr/sbin/mktcpip -S $IF 2>&1 | grep -v "^lsattr" | grep -v "device configuration" >${VimDATA}.mktcpip
                   ;;
     esac 
     #  Generate the header for wsmoutput
     HEADER=`grep "^#" ${VimDATA}.mktcpip | sed 's/#//'`
     HEADER="interface:Config_mode:addr6:prefixlen:$HEADER"
     #echo $HEADER
     #  Generate the output string to wsmoutput
     OUTPUT=`cat ${VimDATA}.mktcpip | grep -v "^#"`
     # OUTPUT="$addr6:$prefixlen:$OUTPUT"
     # OUTPUT="$IF:$CONFIG_MODE:$OUTPUT"
     IFS=':'
     set -A LineBuf $OUTPUT
     hostname=${LineBuf[0]}
     ipaddr=${LineBuf[1]}
     subnet=${LineBuf[2]}
     nameserv=${LineBuf[4]}
     domainname=${LineBuf[5]}
     gw=${LineBuf[6]}
     IFS=" "
     if [ -z "${addr6}" ]
            then IPaddress=${ipaddr}
            else IPaddress=${addr6}
     fi
     #Back to oldLANG
     export LANG=$oldLANG
     /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 20 "Network Information"
     echo ""
     /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 21 "\tHost Name:"
     echo " ${hostname}"
     if [ ${CONFIG_MODE} = "DHCP" ]
       then 
            /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 22 "\tIP Address:"
            echo " ${dhcp_ipaddr}"
       else  
            /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 22 "\tIP Address:"
            echo " ${IPaddress}"
     fi
     /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 23 "\tSub Netmask:"
     echo " ${subnet}"

     /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 24 "\tGateway:"
     echo " ${gw}"

     /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 25 "\tName Server:"
     echo " ${nameserv}"

     /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 26 "\tDomain Name:"
     echo " ${domainname}"

     rm -f ${VimDATA}.mktcpip

# Paging Space information
     echo " "
     /usr/bin/dspmsg -s 1 cmdsolsysmgt 10 "Paging Space Information"
     echo ""
     lsps -s | grep MB | while read pagingspace percentused
        do
          /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 11 "\tTotal Paging Space:"
          echo " ${pagingspace}"

          /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 12 "\tPercent Used:"
          echo " ${percentused}"
        done
# Volume Group information
     echo " "
     /usr/bin/dspmsg -s 1 cmdsolsysmgt.cat 30 "Volume Groups Information"
     echo ""
     echo "============================================================================== "
     lsvg | while read vg
        do
          lsvg -p ${vg}
          echo "============================================================================== "
          echo " "
        done      
#devices information
lscfg                                                                     
fi

