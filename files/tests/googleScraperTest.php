<?php declare(strict_types=1);
use PHPUnit\Framework\TestCase;

final class googleScraperTest extends TestCase {
	
	/** @test - Output HTML */
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
          $attrExist = ['name', 'extensions', 'link', 'image'];
          foreach($attrExist as $attr){
            if(array_key_exists($attr, $returnData['outputData']['artworks'][0]))
              echo "Has a ".$attr."\n";
            else
              echo "Not has a ".$attr."\n";
          }
        }
        
      }
      
      $this->assertTrue($google->runCode($file)['status']);
    }
  }
	
	/** @test - Output Json */
	public function getOutPutAsJSONFile() {
    $google = new googleScraper();
    $google->_htmlFilesPath =  __DIR__."/files/";
    $google->_saveOutPut =  __DIR__."/OutPut/";
    $this->assertTrue($google->init()['status']);
    
    $google->_outPutType = "json";
    foreach($google->_filesInPath as $file) {
      echo "Json Output Tests for Vangogh Paintings, filepath: ".$file."\n";
      $returnData = $google->runCode($file);
      if($returnData['status']) {
        if(array_key_exists('artworks', $returnData['outputData'])){
          echo "Has a `artworks`\n";
          $attrExist = ['name', 'extensions', 'link', 'image'];
          foreach($attrExist as $attr){
            if(array_key_exists($attr, $returnData['outputData']['artworks'][0]))
              echo "Has a ".$attr."\n";
            else
              echo "Not has a ".$attr."\n";
          }
        }
        
      }
      
      $this->assertTrue($google->runCode($file)['status']);
    }
  }
}