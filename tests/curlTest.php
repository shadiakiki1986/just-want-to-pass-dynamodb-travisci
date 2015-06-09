<?php

class curlTest extends PHPUnit_Framework_TestCase {

    public function testVersion() {
		$cv=curl_version();
		$this->assertTrue($cv['version']=='7.42.1');
    }

}
