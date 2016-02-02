#!/bin/sh

	cp  bash_profile ~/.bash_profile  &&  echo "copy .bash_profile success"

	mkdir  -p $HOME/.vim
	cp -r ./vim/*  ~/.vim  &&  echo "copy vim config "	
	#curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

	cp  git-completion.bash ~/.git-completion.bash  &&  echo "copy git bash " 

        [ -f ~/.bash_profile ] || touch   ~/.bash_profile
        [ -f ~/.profile ] || touch  ~/.profile

	grep  -q 'git-completion.bash'  ~/.bash_profile || echo "
	if [ -f ~/.git-completion.bash ]; then
    		. ~/.git-completion.bash
	fi
	"  >>  ~/.bash_profile  &&  echo "source git cmd .bash_profile"

	grep  -q 'git-completion.bash'  ~/.profile || echo "
	if [ -f ~/.git-completion.bash ]; then
    		. ~/.git-completion.bash
	fi
	"  >>  ~/.profile  &&  echo "source git cmd .profile"


	cp  info.sh    ~/.info.sh

	grep  -q '.info.sh' ~/.bash_profile ||	echo "
	if [ -f ~/.info.sh ]; then
    		. ~/.info.sh
	fi
	"  >>  ~/.bash_profile  &&  echo "source info cmd"

