<?php declare(strict_types=1);
use PHPUnit\Framework\TestCase;

final class googleScraperTest extends TestCase {
	
	private $_attrValidate = [ 
		[
			'name'		=> 'name',
			'validate'	=> 'is_string',
			'type'		=> 'function'
		],						
		[
			'name'		=> 'extensions',
			'validate'	=> 'is_array',
			'type'		=> 'function'
		],						
		[
			'name'		=> 'link',
			'validate'	=> '/^(http|https|ftp):\/\/([A-Z0-9][A-Z0-9_-]*(?:\.[A-Z0-9][A-Z0-9_-]*)+):?(\d+)?\/?/i',
			'type'		=> 'regex'
		],						
		[
			'name'		=> 'image',
			'validate'	=> '/^data:image\/(?:gif|png|jpeg|bmp|webp)(?:;charset=utf-8)?;base64,(?:[A-Za-z0-9]|[+\/])+={0,2}/',
			'type'		=> 'regex'
		]
	];
	
	/** @test */
	public function getOutPutAsHTMLFile() {
		$google = new googleScraper();
		$google->_htmlFilesPath =  __DIR__."/files/";
		$google->_saveOutPut =  __DIR__."/OutPut/";
		$this->assertTrue($google->init()['status']);
		
		$google->_outPutType = "html";
		foreach($google->_filesInPath as $file) {
			echo "HTML Output Tests for Vangogh Paintings, filepath: ".$file."\n";
			$returnData = $google->runCode($file);
			if($returnData['status']) {
				if(array_key_exists('artworks', $returnData['outputData'])){
					echo "Has a `artworks`\n";
					
					foreach($this->_attrValidate as $attr){
						if(array_key_exists($attr['name'], $returnData['outputData']['artworks'][0])){
							$vaild = false;
							if($attr['type'] == 'regex') {
								$vaild = preg_match($attr['validate'], $returnData['outputData']['artworks'][0][$attr['name']]);
							} elseif($attr['type'] == 'function') {
								$vaild = call_user_func_array($attr['validate'], [$returnData['outputData']['artworks'][0][$attr['name']]]);
							}
							if($vaild)
								echo "Has a ".$attr['name']."\n";
							else
								echo "Not has a ".$attr['name']."\n";
						} else {
							echo "Not has a ".$attr['name']."\n";
						}
					}
				}
				
			}
			
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
			echo "JSON Output Tests for Vangogh Paintings, filepath: ".$file."\n";
			$returnData = $google->runCode($file);
			if($returnData['status']) {
				if(array_key_exists('artworks', $returnData['outputData'])){
					echo "Has a `artworks`\n";
					
					foreach($this->_attrValidate as $attr){
						if(array_key_exists($attr['name'], $returnData['outputData']['artworks'][0])){
							$vaild = false;
							if($attr['type'] == 'regex') {
								$vaild = preg_match($attr['validate'], $returnData['outputData']['artworks'][0][$attr['name']]);
							} elseif($attr['type'] == 'function') {
								$vaild = call_user_func_array($attr['validate'], [$returnData['outputData']['artworks'][0][$attr['name']]]);
							}
							if($vaild)
								echo "Has a ".$attr['name']."\n";
							else
								echo "Not has a ".$attr['name']."\n";
						} else {
							echo "Not has a ".$attr['name']."\n";
						}
					}
				}
				
			}
			
			$this->assertTrue($google->runCode($file)['status']);
		}
	}
}