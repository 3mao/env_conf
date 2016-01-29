#!/bin/sh


cd  pkg
	cscope  --version 2>&1  > /dev/null || {
        tar  -zxvf       cscope-15.8b.tar.gz
        cd  cscope-15.8b
	sh ./configure
	make
	make install
        cd ../
	rm -rf  cscope-15.8b
	}

