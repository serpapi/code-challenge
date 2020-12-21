<?php
$html = file_get_contents('van-gogh-paintings.html');
$j = json_decode(file_get_contents('van-gogh-paintings.json'));

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


$dom = new DOMDocument(); 
libxml_use_internal_errors(true);
$dom->loadHTML($html);
libxml_clear_errors();

$data = getElementByClass($dom, 'div', 'EDblX DAVP1')->firstChild;

$arrData = [];
do { $arrData[] = $dom->saveHTML($data);} while ($data = @$data->nextSibling);


$out = [];

foreach($arrData as $val) {
	$dom2 = new DomDocument();
	$dom2->loadHTML(mb_convert_encoding($val, 'HTML-ENTITIES', 'UTF-8'));
	
	foreach($dom2->getElementsByTagName('a') as $li) {
		$title = $li->getAttribute('title');
		$href = $li->getAttribute('href');
		preg_match('/[^(\)]+(?=[)])/', $title, $extension);
		$title = iconv("UTF-8","ISO-8859-1//IGNORE", trim(preg_replace('/[(](.*?)[)]/', '', $title)));
		$extension = (count($extension) > 0 ? $extension[0] : '');
		$img = $j->knowledge_graph->artworks[array_search($title, array_column($j->knowledge_graph->artworks, "name"))]->image;
		$out['artworks'][] = [
			'name'			=> $title,
			'extensions'	=> [$extension],
			'link'			=> 'https://www.google.com'.$href,
			'image'			=> $img
		];
	}
}


echo json_encode($out);

