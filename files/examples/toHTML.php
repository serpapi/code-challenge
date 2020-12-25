<?php
require __DIR__ . '/../vendor/autoload.php';

// call class
$google = new googleScraper();

// defualt paths
$google->_htmlFilesPath =  __DIR__."/files/";
$google->_saveOutPut =  __DIR__."/OutPut/";

//output needed
$google->_outPutType = "html";

// init for class
$init = $google->init();

//check if init is correct
if($init['status'] == true) {
	
	// get all *.html files in ($google->_htmlFilesPath) path
	foreach($google->_filesInPath as $file) {
		
		// run code and take html file path
		$run = $google->runCode($file);
		echo $run['msg'];
	}
} else {
	echo $init['msg'];
}
