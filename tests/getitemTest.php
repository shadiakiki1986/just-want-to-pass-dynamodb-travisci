<?php

use Aws\DynamoDb\DynamoDbClient;

class getitemTest extends PHPUnit_Framework_TestCase {

    public function testGet() {

	if(!getenv('J2P_AWS_KEY')) throw new Exception("Please set environment variable J2P_AWS_KEY");
	if(!getenv('J2P_AWS_SECRET')) throw new Exception("Please set environment variable J2P_AWS_SECRET");
	if(!getenv('J2P_AWS_REGION')) throw new Exception("Please set environment variable J2P_AWS_REGION");

	$client= DynamoDbClient::factory(array(
	    'key' => getenv('J2P_AWS_KEY'), # check config file
	    'secret'  => getenv('J2P_AWS_SECRET'),
	    'region'  => getenv('J2P_AWS_REGION')
	));

	$item=$client->getItem(array(
	    'TableName' => 'zboota-users',
	    'Key' => array( 'email'      => array('S' => "shadiakiki1986@yahoo.com") )
	));
	$item=$item['Item'];

	$this->assertTrue(array_key_exists("email",$item));
	$this->assertTrue(array_key_exists("pass",$item));
    }

}
