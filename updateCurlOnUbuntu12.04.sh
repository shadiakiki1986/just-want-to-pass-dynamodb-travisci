#!/bin/bash
# Needed as described here
# https://github.com/aws/aws-sdk-php/issues/588
# Will no longer be needed when travis-ci start using Ubuntu 14.04

if [ `lsb_release -a|grep Release|awk '{print $2}'` == '12.04' ]; then
	echo 'deb http://security.ubuntu.com/ubuntu trusty main' > /tmp/myppa.list
	echo 'deb http://security.ubuntu.com/ubuntu trusty-security main' >> /tmp/myppa.list
	echo 'deb http://security.ubuntu.com/ubuntu trusty-updates main' >> /tmp/myppa.list
	sudo cp /tmp/myppa.list /etc/apt/sources.list.d/
	rm /tmp/myppa.list
	sudo apt-get update
	sudo apt-get -V build-dep curl libc6 libcurl3 libcurl3-gnutls php5-curl apache2 libgnutls28 libcurl4-gnutls-dev
	sudo apt-get -V install curl libc6 libcurl3 libcurl3-gnutls php5-curl apache2 libgnutls28 libcurl4-gnutls-dev

	# download and build from source: gnutls + nettle
	if [ -d nettle-2.7.1 ]; then 
		cd nettle-2.7.1
		sudo make install
		cd -
	else
		sudo apt-get install libgpm-dev autogen pkg-config
		wget ftp://ftp.gnu.org/gnu/nettle/nettle-2.7.1.tar.gz
		tar -xzf nettle-2.7.1.tar.gz
		cd nettle-2.7.1
		./configure
		make
		make check
		sudo make install
		cd -
	fi

	if [ -d gnutls-3.1.28 ]; then 
		cd gnutls-3.1.28
		sudo make install
		cd -
	else
		wget ftp://ftp.gnutls.org/gcrypt/gnutls/stable/gnutls-3.1.28.tar.xz
		unxz gnutls-3.1.28.tar.xz
		tar -xvf gnutls-3.1.28.tar
		cd gnutls-3.1.28
		./configure
		make
		make check
		sudo make install
		cd -
	fi

else
	echo "This script was only meant to run on Ubuntu 12.04";
fi

