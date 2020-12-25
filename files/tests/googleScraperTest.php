<?php declare(strict_types=1);
use PHPUnit\Framework\TestCase;

final class googleScraperTest extends TestCase {
	
	/** @test */
	public function getOutPutAsHTMLFile() {
		$google = new googleScraper();
		$google->_htmlFilesPath =  __DIR__."/files/";
		$google->_saveOutPut =  __DIR__."/OutPut/";
		$this->assertTrue($google->init()['status']);
		
		$google->_outPutType = "html";
		foreach($google->_filesInPath as $file) {
			$this->assertTrue($google->runCode($file)['status']);
		}
	}
	
	/** @test */
	public function getOutPutAsJSONFile() {
		$google = new googleScraper();
		$google->_htmlFilesPath =  __DIR__."/files/";
		$google->_saveOutPut =  __DIR__."/OutPut/";
		$this->assertTrue($google->init()['status']);
		
		$google->_outPutType = "json";
		foreach($google->_filesInPath as $file) {
			$this->assertTrue($google->runCode($file)['status']);
		}
	}
}