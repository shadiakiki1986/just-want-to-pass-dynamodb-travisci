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
	sudo apt-get -V build-dep curl libc6 libcurl3 php5-curl apache2 libgnutls28
	sudo apt-get -V install curl libc6 libcurl3 php5-curl apache2 libgnutls28
else
	echo "This script was only meant to run on Ubuntu 12.04";
fi

