#!/bin/sh

	cp -r ./vim  ~/.vim  &&  echo "copy vim config "	
	#curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

	cp  git-completion.bash ~/.git-completion.bash  &&  echo "copy git bash " 

	echo "
	if [ -f ~/.git-completion.bash ]; then
    		. ~/.git-completion.bash
	fi
	"  >>  ~/.bash_profile  &&  echo "source git cmd"
