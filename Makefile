preinstall:
	curl -sS https://getcomposer.org/installer | php
	sudo mv composer.phar /usr/local/bin/composer
	wget https://phar.phpunit.de/phpunit.phar
	chmod +x phpunit.phar
	#sudo mv phpunit.phar /usr/local/bin/phpunit
	sudo apt-get update
	sudo apt-get install make php5-cli php5-curl

test:
	phpunit --verbose

install:
	wget https://s3-us-west-2.amazonaws.com/zboota-server/travis-ci+debian+packages/nettle_2.7.1-1_amd64.deb && sudo dpkg -i nettle_2.7.1-1_amd64.deb
	sudo ldconfig
	#cd /usr/lib/x86_64-linux-gnu/ && sudo rm libgnutls* && cd -
	wget https://s3-us-west-2.amazonaws.com/zboota-server/travis-ci+debian+packages/gnutls_3.1.28-1_amd64.deb && sudo dpkg -i gnutls_3.1.28-1_amd64.deb
	cd /usr/lib/x86_64-linux-gnu/ && sudo rm libgnutls-openssl.so.27 libgnutls-openssl.so libgnutlsxx.so libgnutlsxx.so.27 libgnutls-openssl.so.27.0.0 libgnutlsxx.so.27.0.0 && cd - # testing
	sudo ldconfig
	sudo apt-get remove libneon27-gnutls
	# instead of the below rm, which removes /usr/lib/x86.../libcurl-gnutls.so.4 (and even if I ln -s to /usr/local/lib/libcurl.so.4, it doesn't really work), 
	# I should figure out how libcurl-gnutls.so.4 gets generated
	# cd /usr/lib/x86_64-linux-gnu/ && sudo rm libcurl* && cd -
	wget https://s3-us-west-2.amazonaws.com/zboota-server/travis-ci+debian+packages/curl_7.42.1-1_amd64.deb && sudo dpkg -i curl_7.42.1-1_amd64.deb
	sudo ldconfig
