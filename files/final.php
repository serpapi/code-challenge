<?php

$htmlFilesPath = __DIR__."/files/";
$saveOutPut = __DIR__."/OutPut/";
$outPutType = 'html'; // html - json

// create files path if not exists
if (!file_exists($htmlFilesPath)) {
    mkdir($htmlFilesPath, 0777, true);
}

// create outout path if not exists
if (!file_exists($saveOutPut)) {
    mkdir($saveOutPut, 0777, true);
}

// get all html files from path
$files = glob($htmlFilesPath."*.html");

// Check if there's files inside the folder(files).
if(is_array($files) and count($files) == 0){
	exit("There no HTML files at ".$htmlFilesPath);
}

// extracting data from the css classes
function getElementByClass(&$parentNode, $tagName, $className, $offset = 0) {
	$response = false;

	$childNodeList = $parentNode->getElementsByTagName($tagName);
	$tagCount = 0;
	for ($i = 0; $i < $childNodeList->length; $i++) {
		$temp = $childNodeList->item($i);
		if (stripos($temp->getAttribute('class'), $className) !== false) {
			if ($tagCount == $offset) {
				$response = $temp;
				break;
			}
			$tagCount++;
		}
	}
	return $response;
}

// Take 2 args : htmlPath [required] , returnType [optional, defualt html]
function getDataFromHTML($htmlPath, $returnType = 'html') {
	global $saveOutPut;
	
	$outputData = [];
	$allIMGfromJSToArray = [];
	$getAllDivsDataToArray = [];
	
	// Get HTML data file.
	$html = file_get_contents($htmlPath);
	
	// init DOMDocument class .
	$dom = new DOMDocument(); 
	
	libxml_use_internal_errors(true);
	// parse html 
	$dom->loadHTML($html);
	libxml_clear_errors();

	// get all script tags and search for images.
	foreach($dom->getElementsByTagName('script') as $sc) {
		$data2 = $dom->saveHTML($sc);
		//From Regex cheatsheet.
		preg_match_all('/var s=\'(.*?)\';var ii=[[]\'(.*?)\'[]];/', $data2, $arrIMG2);	
		if(count($arrIMG2[0]) > 0){
			foreach($arrIMG2 as $key => $val){
				foreach($val as $ke => $val2){
					$allIMGfromJSToArray[$key][] = $arrIMG2[$key][$ke];
				}
			}
		}
	}
	
	

	// Get all div that has (EDblX DAVP1) css class .
	$getAllDivsData = getElementByClass($dom, 'div', 'EDblX DAVP1')->firstChild;
	
	// save html from opject to HTML code.
	do { $getAllDivsDataToArray[] = $dom->saveHTML($getAllDivsData);} while ($getAllDivsData = @$getAllDivsData->nextSibling);
	
	// Get each div and extract data from it.
	foreach($getAllDivsDataToArray as $val) {
		$dom2 = new DomDocument();
		$dom2->loadHTML(mb_convert_encoding($val, 'HTML-ENTITIES', 'UTF-8'));	
		
		foreach($dom2->getElementsByTagName('a') as $attribute) {
			// get title from [title] attribute and clear from any bad characters.
			$title = iconv("UTF-8","ISO-8859-1//IGNORE", $attribute->getAttribute('title'));
			
			// get URL from [href] attribute.
			$href = $attribute->getAttribute('href');
			
			// get between Braces [( )]
			preg_match('/(?<=\().+?(?=\))/', $title, $insideBraces);
			
			// remove the Braces () and its data.
			$title = trim(preg_replace('/[(](.*?)[)]/', '', $title));
			
			// check if Braces exist. 
			$insideBraces = (count($insideBraces) > 0 ? $insideBraces[0] : '');
			
			// get id from [img] tag.
			$id = null;
			if($attribute->getElementsByTagName('img')->length > 0)
				$id = $attribute->getElementsByTagName('img')->item(0)->getAttribute('id');
			
			$outputData['artworks'][] = [
				'name'			=> $title,
				'extensions'	=> [$insideBraces],
				'link'			=> 'https://www.google.com'.$href,
				'image'			=> (array_search($id, $allIMGfromJSToArray[2]) !== false ? str_replace('\x3d', "", $allIMGfromJSToArray[1][array_search($id, $allIMGfromJSToArray[2])]) : '') // search for image from $allIMGfromJSToArray by id 
			];
		}
	}
	
	// name of current HTML file.
	$nameFile = pathinfo($htmlPath)['filename'];
	
	// name of new file to save data inside it.
	$nameNewFile = $saveOutPut.$nameFile.'_'.time();
	
	// which type user want to save the above data with.
	if($returnType == 'html') {
		
		$htmlData = '<div style=""><table border=1>';
		foreach($outputData['artworks'] as $val) {
			$htmlData .= '<tr>';
			$htmlData .= '<td><a href="'.$val['link'].'">'.$val['name'].'</a></td>';
			$htmlData .= '<td>'.$val['extensions'][0].'</td>';
			$htmlData .= '<td><img src='.$val['image'].'></td>';
			$htmlData .= '</tr>';
		}
		$htmlData .= '</table></div>';
		$outPutFileSaved = $nameNewFile.'.html';
		
		// save the data into file.
		file_put_contents($outPutFileSaved, $htmlData);
	
	} elseif($returnType == 'json') {
		$outPutFileSaved = $nameNewFile.'.json';
		// save the data into file.
		file_put_contents($outPutFileSaved, json_encode($outputData));
	} else {
		
	}
	
	return "[Done] The extracted data saved into : ".$outPutFileSaved;

}

foreach($files as $val) {
	echo getDataFromHTML($val, $outPutType)."<br>\n";
}