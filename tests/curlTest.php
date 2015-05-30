<?php

class curlTest extends PHPUnit_Framework_TestCase {

    public function testVersion735() {
		$this->assertTrue(curl_version()['version']=='7.35.0');
    }

}
