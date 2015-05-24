<?php

use Aws\DynamoDb\DynamoDbClient;

class getitemTest extends PHPUnit_Framework_TestCase {

    public function checkEnv() {
	if(!getenv('J2P_AWS_KEY')) throw new Exception("Please set environment variable J2P_AWS_KEY");
	if(!getenv('J2P_AWS_SECRET')) throw new Exception("Please set environment variable J2P_AWS_SECRET");
	if(!getenv('J2P_AWS_REGION')) throw new Exception("Please set environment variable J2P_AWS_REGION");
    }

    public function ddbFactory() {
	return DynamoDbClient::factory(array(
	    'key' => getenv('J2P_AWS_KEY'), # check config file
	    'secret'  => getenv('J2P_AWS_SECRET'),
	    'region'  => getenv('J2P_AWS_REGION')
	));
    }

    public function testGetItem() {
	$this->checkEnv();
	$client=$this->ddbFactory();

	$item=$client->getItem(array(
	    'TableName' => 'zboota-users',
	    'Key' => array( 'email'      => array('S' => "shadiakiki1986@yahoo.com") )
	));
	$item=$item['Item'];

	$this->assertTrue(array_key_exists("email",$item));
	$this->assertTrue(array_key_exists("pass",$item));
    }

    public function testUpdateItem() {
	$this->checkEnv();
	$client=$this->ddbFactory();

	$client->updateItem(array(
	    'TableName' => 'zboota-users',
	    'Key' => array( 'email'      => array('S' => "shadiakiki1986@yahoo.com") ),
	    'ExpressionAttributeValues'=>array( ':tnow'=>array('S'=>date("Y-m-d H:i:s"))),
	    'UpdateExpression' => 'SET lastLoginTs = :tnow'
	));
    }
/*
    public function testPutItem() {
	$this->checkEnv();
	$client=$this->ddbFactory();

	$client->putItem(array(
	    'TableName' => 'zboota-users',
	    'Item' => array(
		'email' => array('S' => (string)rand(1000,9999)),
		'pass'  => array('S' => "something else"),
		'registrationDate' => array('S' => date("Y-m-d H:i:s")),
		'lastloginDate' => array('S' => "-"),
		'lpns' => array('S' => "{}")
	    )
	));

    }
*/

}
