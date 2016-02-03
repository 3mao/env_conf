# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

 	export ORACLE_HOME=/home/lmg/instantclient_12_1
        export ORACLE_ADMIN=/home/lmg/instantclient_12_1;
        export PATH=$ORACLE_HOME:$PATH
        export TNS_ADMIN=$ORACLE_HOME
        export LD_LIBRARY_PATH=$ORACLE_HOME:$LD_LIBRARY_PATH

	if [ -f ~/.git-completion.bash ]; then
    		. ~/.git-completion.bash
	fi
	

	if [ -f ~/.info.sh ]; then
    		. ~/.info.sh
	fi
	
