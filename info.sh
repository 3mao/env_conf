#!/bin/sh

#2015年10月13日 11:16:27
#功能：用于获得系统信息以及硬件信息的脚本

export LC_ALL=C

aix_info(){
echo 

}

linux_info(){

	
	echo "[CPU信息]"
	lscpu
	[ 1 == 2 ] && perl -pe '
	#processor　系统中逻辑处理核的编号。对于单核处理器，则课认为是其CPU编号，对于多核处理器则可以是物理核、或者使用超线程技术虚拟的逻辑核
	s/(processor)/系统中逻辑处理核的编号/;
	#vendor_id  CPU制造商
	s/vendor_id/CPU制造商/;
	s/cpu family/CPU产品系列代号/;
	s/(model\s*name)/CPU名字、编号、标称主频/;
	s/(model)/CPU产品系列中的那一代代号/;
	s/(stepping)/CPU制作更新版本/;
	s/(cpu MHz)/CPU实际使用主频/;
	s/(cache size)/CPU二级缓存大小/;
	s/(physical id)/单个CPU的标号/;
	#siblings  单个CPU逻辑物理核数,与cpu cores不等则启用超线程
	s/(siblings)/单个CPU逻辑物理核数/;
	s/(core id)/当前物理核在其所处CPU中的编号/;
	s/(cpu cores)/该逻辑核所处CPU的物理核数/;
	#apicid  用来区分不同逻辑核的编号，系统中每个逻辑核的此编号必然不同，此编号不一定连续
	s/(apicid)/逻辑核的编号/;
	s/(fpu_exception)/是否支持浮点计算异常/;
	#执行cpuid指令前，eax寄存器中的值，根据不同的值cpuid指令会返回不同的内容
	s/(cpuid level)/行cpuid指令前,eax寄存器中的值/;
	#wp   表明当前CPU是否在内核态支持对用户空间的写保护Write Protection
	s/(wp)/内核态支持对用户空间的写保护/;

	s/(flags\s*:)/当前CPU支持的功能/;
	s/(fpu)/\n\t\t\t浮点运算单元/;
	s/(vme)/\n\t\t\t虚拟模式扩展Virtual Mode Extension/;
	s/(de)/\n\t\t\t调试扩展 Debugging Extensions/;
	s/(pse)/\n\t\t\t页面大小扩展 Page Size Extensions/;
#	tsc： Time Stamp Counter: support for RDTSC and WRTSC instructions
#	msr： Model-Specific Registers
#	pae： Physical Address Extensions: ability to access 64GB of memory; only 4GB can be accessed at a time though
#	mce： Machine Check Architecture
#	cx8： CMPXCHG8 instruction
#	apic： Onboard Advanced Programmable Interrupt Controller
#	sep： Sysenter/Sysexit Instructions; SYSENTER is used for jumps to kernel memory during system calls, and SYSEXIT is used for jumps： back to the user code
#	mtrr： Memory Type Range Registers
#	pge： Page Global Enable
#	mca： Machine Check Architecture
#	cmov： CMOV instruction
#        pat： Page Attribute Table
#        pse36： 36-bit Page Size Extensions: allows to map 4 MB pages into the first 64GB RAM, used with PSE.
#        pn： Processor Serial-Number; only available on Pentium 3
#        clflush： CLFLUSH instruction
#        dtes： Debug Trace Store
#        acpi： ACPI via MSR
#	mmx： MultiMedia Extension
#	fxsr： FXSAVE and FXSTOR instructions
#        sse：Streaming SIMD Extensions. Single instruction multiple data. Lets you do a bunch of the same operation on different pieces of input： in a single clo.
#	sse2： Streaming SIMD Extensions-2. More of the same.
#        selfsnoop： CPU self snoop
#        acc： Automatic Clock Control
#        IA64： IA-64 processor Itanium.
#        ht： HyperThreading. Introduces an imaginary second processor that doesn’t do much but lets you run threads in the same process a  bit quicker.
#	nx： No Execute bit. Prevents arbitrary code running via buffer overflows.
#	pni： Prescott New Instructions aka. SSE3
#	vmx： Intel Vanderpool hardware virtualization technology
#	svm： AMD “Pacifica” hardware virtualization technology
#	lm： “Long Mode,” which means the chip supports the AMD64 instruction set
#	tm： “Thermal Monitor” Thermal throttling with IDLE instructions. Usually hardware controlled in response to CPU temperature.
#	tm2： “Thermal Monitor 2″ Decrease speed by reducing multipler and vcore.
#	est： “Enhanced SpeedStep”
	
	#bogomips 在系统内核启动时粗略测算的CPU速度Million Instructions Per Second
	s/(bogomips)/系统内核启动时的CPU速度/;
	s/(clflush size)/每次刷新缓存的大小单位/;
	s/(cache_alignment)/缓存地址对齐单位/;
	s/(address sizes)/可访问地址空间位数/;
	s/(power management)/对能源管理的支持/;'  /proc/cpuinfo



#	free -m ：查看内存情况，单位为MB。
#	total 内存总数
#	used 已经使用的内存数（我的程序使用内存数量+系统缓存使用的内数量）
#	free 空闲的物理内存数（是真正的空闲，未被任何程序占用）
#	shared 多个进程共享的内存总额
#	buffers 磁盘缓存（Buffer Cache）的大小（可提高系统I/O调用的性能）
#	cached  磁盘缓存（Page Cache）的大小（可提高系统I/O调用的性能）
#	-buffers/cache 表示已被我们的程序使用的内存数，计算方法：used - buffers - cached
#	+buffers/cache 表示还可已被我使用的内存数，计算方法：free + buffers + cached
#
#	操作系统目前可用内存总量=free + buffers + cached，上图是1155M
#
#	buffers是用来给块设备做的缓冲大小、buffers是用来存储目录里面有什么内容，权限等等
#	cached用来给文件做缓冲，用来记忆我们打开的文件.

	echo
	echo "[内存信息]"
	free   -ht
	#free  -m|awk  'NR==2{print "物理内存使用率:"$3*100/$2"%","物理内存空闲率:"$4*100/$2"%\n"}' 
	#free  -m|awk  'NR==3{print "swap内存使用率:"$3*100/$2"%","    swap内存空闲率:"$4*100/$2"%\n"}' 
	#free  -mt|awk  'NR==4{print "系统内存使用率:"$3*100/$2"%","系统内存空闲率:"$4*100/$2"%\n"}' 
	free -mt | awk  -e 'NR==2{print "物理内存使用率:"$3*100/$2"%","物理内存空闲率:"$4*100/$2"%"}'       \
			-e  'NR==3{print "swap内存使用率:"$3*100/$2"%","    swap内存空闲率:"$4*100/$2"%"}'  \
			-e  'NR==4{print "系统内存使用率:"$3*100/$2"%","系统内存空闲率:"$4*100/$2"%"}'
	echo

	echo 
	echo "[文件系统信息]"
	df -h
	df -kT 2>&1|grep  -v 'Permission'|awk  'NR>1{all+=$3;use+=$4}END{print "总文件系统使用率:"use*100/all"%"}'
	echo

	echo 
	echo "[硬盘信息]"
	lsblk

	[ 1 == 2 ] && lsblk |	awk        '{s/NAME/块设备名/}'  \
			-e '{s/MAJ:MIN/主次设备号/}' \
			-e '{s/RM/是否可移动/}'      \
			-e '{s/SIZE/容量大小/}'      \
			-e '{s/RO/是否为只读/}'      \
			-e '{s/TYPE/块设备是否是磁盘或磁盘上的一个分区/}' \
			-e '{s/MOUNTPOINT/设备挂载点/}'
	echo
}

sunos_info(){
echo
}

sys_info(){


	case `uname` in
		"Linux")
			linux_info
			;;
		*)
			echo "not expect system"
	esac
}

sys_info
