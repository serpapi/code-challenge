<?php
require __DIR__ . '/../vendor/autoload.php';

$google = new googleScraper();
$google->_htmlFilesPath =  __DIR__."/files/";
$google->_saveOutPut =  __DIR__."/OutPut/";
$google->_outPutType = "html";
$init = $google->init();
if($init['status'] == true) {
	foreach($google->_filesInPath as $file) {
		$run = $google->runCode($file);
		echo $run['msg'];
	}
} else {
	echo $init['msg'];
}
