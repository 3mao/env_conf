#!/bin/sh


cd  pkg
	cscope  --version 2  > /dev/null || {
	yum install  -y ncurses*   curses*  
        tar  -zxvf       cscope-15.8b.tar.gz
        cd  cscope-15.8b
	sh ./configure
	make
	make install
        cd ../
	rm -rf  cscope-15.8b
	}

	ctags  --version 2  > /dev/null || {	
        tar  -zxvf  ctags-5.8.tar.gz
        cd  ctags-5.8
        sh  ./configure
        make
        make install
        cd ../
        rm -rf   ctags-5.8
	}
