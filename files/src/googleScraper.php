<?php declare(strict_types=1);

final class googleScraper {
	
	public $_htmlFilesPath = __DIR__."/files/";
	public $_saveOutPut = __DIR__."/OutPut/";
	public $_outPutType = 'html'; // html - json
	public $_filesInPath;
	
	public function init() {
		// create files path if not exists
		if (!file_exists($this->_htmlFilesPath)) {
			mkdir($this->_htmlFilesPath, 0777, true);
		}

		// create outout path if not exists
		if (!file_exists($this->_saveOutPut)) {
			mkdir($this->_saveOutPut, 0777, true);
		}

		// get all html files from path
		$files = glob($this->_htmlFilesPath."*.html");

		// Check if there's files inside the folder(files).
		if(is_array($files) and count($files) == 0){
			return ["status" => false, "msg" => "There no HTML files at ".$this->_htmlFilesPath];
		}
		
		$this->_filesInPath = $files;
		return ["status" => true];
	}
	
	// public function getFiles() {
		// foreach($this->_filesInPath as $file) {
			// return
			// echo getDataFromHTML($file, $this->_outPutType)."<br>\n";
		// }
	// }
	
	public function runCode($htmlPath) {
	
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
		$getAllDivsData = $this->getElementByClass($dom, 'div', 'EDblX DAVP1')->firstChild;
		
		// save html from opject to HTML code.
		do { $getAllDivsDataToArray[] = $dom->saveHTML($getAllDivsData);} while ($getAllDivsData = @$getAllDivsData->nextSibling);
		
		// Get each div and extract data from it.
		foreach($getAllDivsDataToArray as $val) {
			$dom2 = new DomDocument();
			$dom2->loadHTML(mb_convert_encoding($val, 'HTML-ENTITIES', 'UTF-8'));
			
			$dataAtAtag = $dom2->getElementsByTagName('a')->item(0);
			
			// get title from [aria-label] attribute and clear from any bad characters.
			$title = iconv("UTF-8","ISO-8859-1//IGNORE", $dataAtAtag->getAttribute('aria-label'));
			
			// get URL from [href] attribute.
			$href = $dataAtAtag->getAttribute('href');
			
			// get between Braces [( )] and delete title if repeted
			preg_match('/(?<=\().+?(?=\))/', str_replace($title, '', iconv("UTF-8","ISO-8859-1//IGNORE", $dataAtAtag->getAttribute('title'))), $insideBraces);
			
			// check if Braces exist. 
			$insideBraces = (count($insideBraces) > 0 ? str_replace($title, '', $insideBraces[0]) : '');
			
			// get id from [img] tag.
			$id = null;
			if($dataAtAtag->getElementsByTagName('img')->length > 0)
				$id = $dataAtAtag->getElementsByTagName('img')->item(0)->getAttribute('id');
			
			$outputData['artworks'][] = [
				'name'			=> $title,
				'extensions'	=> [$insideBraces],
				'link'			=> 'https://www.google.com'.$href,
				'image'			=> (array_search($id, $allIMGfromJSToArray[2]) !== false ? str_replace('\x3d', "", $allIMGfromJSToArray[1][array_search($id, $allIMGfromJSToArray[2])]) : '') // search for image from $allIMGfromJSToArray by id 
			];
		}
		
		// name of current HTML file.
		$nameFile = pathinfo($htmlPath)['filename'];
		
		// name of new file to save data inside it.
		$nameNewFile = $this->_saveOutPut.$nameFile.'_'.time();
		
		// which type user want to save the above data with.
		if($this->_outPutType == 'html') {
			
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
			$saveToFile = file_put_contents($outPutFileSaved, $htmlData);
			if (($saveToFile === false) || ($saveToFile == -1)) {
				return ["status"=> false, "msg" => "[Error] There was an error saving the file"];
			}
		
		} elseif($this->_outPutType == 'json') {
			$outPutFileSaved = $nameNewFile.'.json';
			// save the data into file.
			$saveToFile = file_put_contents($outPutFileSaved, json_encode($outputData));
			if (($saveToFile === false) || ($saveToFile == -1)) {
				return ["status" => false, "msg" => "[Error] There was an error saving the file"];
			}
		} else {
			return ["status" => false, "msg" => "[Error] output type not exist"];
		}
		
		return ["status" => true, "msg" => "[Done] The extracted data saved into : ".$outPutFileSaved];
	}
	
	// extracting data from the css classes
	private function getElementByClass(&$parentNode, $tagName, $className, $offset = 0) {
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
}