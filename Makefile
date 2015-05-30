preinstall:
	curl -sS https://getcomposer.org/installer | php
	sudo mv composer.phar /usr/local/bin/composer
	wget https://phar.phpunit.de/phpunit.phar
	chmod +x phpunit.phar
	sudo mv phpunit.phar /usr/local/bin/phpunit

test:
	phpunit --verbose

install:
	composer install
