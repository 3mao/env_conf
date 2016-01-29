#!/bin/sh

	cp  bash_profile ~/.bash_profile  &&  echo "copy .bash_profile success"

	cp -r ./vim/*  ~/.vim  &&  echo "copy vim config "	
	#curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

	cp  git-completion.bash ~/.git-completion.bash  &&  echo "copy git bash " 

	grep  -q 'git-completion.bash'  ~/.bash_profile || echo "
	if [ -f ~/.git-completion.bash ]; then
    		. ~/.git-completion.bash
	fi
	"  >>  ~/.bash_profile  &&  echo "source git cmd"


	cp  info.sh    ~/.info.sh

	grep  -q '.info.sh' ~/.bash_profile ||	echo "
	if [ -f ~/.info.sh ]; then
    		. ~/.info.sh
	fi
	"  >>  ~/.bash_profile  &&  echo "source info cmd"

                                                                                                                                                                      
       cd  pkg
	cscope  --version 2>&1  > /dev/null || {
        tar  -zxvf       cscope-15.8b.tar.gz
	su  - root <<eof
	sh ./configure
	make
	make install
eof
	rm -rf  cscope-15.8b
	}



