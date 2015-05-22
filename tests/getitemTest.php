<?php

# To test with a different ROOT, uncomment the below
# define("ROOT", "/home/ubuntu/Development/zboota-server"); // Development ROOT
require_once dirname(__FILE__).'/../config.php';
use Aws\DynamoDb\DynamoDbClient;

class getitemTest extends PHPUnit_Framework_TestCase {

    public function testGet() {

	$client= DynamoDbClient::factory(array(
	    'key' => getenv('J2P_AWS_KEY'), # check config file
	    'secret'  => getenv('J2P_AWS_SECRET'),
	    'region'  => getenv('J2P_AWS_REGION')
	));

	$item=$zc->client->getItem(array(
	    'TableName' => 'zboota-users',
	    'Key' => array( 'email'      => array('S' => "shadiakiki1986@yahoo.com") )
	));

	$this->assertTrue(array_key_exists("email",$item));
	$this->assertTrue(array_key_exists("pass",$item));
    }

}
