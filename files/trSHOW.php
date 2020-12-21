<?php
$html = file_get_contents('van-gogh-paintings.html');
// $j = json_decode(file_get_contents('van-gogh-paintings.json'));

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
$arrIMG = [];
foreach($dom->getElementsByTagName('script') as $sc) {
	$data2 = $dom->saveHTML($sc);
	preg_match_all('/var s=\'(.*?)\';var ii=[[]\'(.*?)\'[]];/', $data2, $arrIMG2);	
	if(count($arrIMG2[0]) > 0){
		foreach($arrIMG2 as $key => $val){
			foreach($val as $ke => $val2){
				$arrIMG[$key][] = $arrIMG2[$key][$ke];
				$arrIMG[$key][] = $arrIMG2[$key][$ke];
				$arrIMG[$key][] = $arrIMG2[$key][$ke];
			}
		}
	}
}

foreach($arrData as $val) {
	$dom2 = new DomDocument();
	$dom2->loadHTML(mb_convert_encoding($val, 'HTML-ENTITIES', 'UTF-8'));
	
	foreach($dom2->getElementsByTagName('a') as $li) {
		$title = iconv("UTF-8","ISO-8859-1//IGNORE", $li->getAttribute('title'));
		$href = $li->getAttribute('href');
		preg_match('/[^(](\d+)+(?=[)])/', $title, $extension);
		$title = trim(preg_replace('/[(](\d+)[)]/', '', $title));
		$extension = (count($extension) > 0 ? $extension[0] : '');

		// $img = $j->knowledge_graph->artworks[array_search('https://www.google.com'.$href, array_column($j->knowledge_graph->artworks, "link"))]->image;
		$id = $li->getElementsByTagName('img')->item(0)->getAttribute('id');
		$out[] = [
			'name'			=> $title,
			'extensions'	=> [$extension],
			'link'			=> 'https://www.google.com'.$href,
			// 'image'			=> $img
			'image'			=> (array_search($id, $arrIMG[2])? rtrim($arrIMG[1][array_search($id, $arrIMG[2])], '\x3d') : '')
		];
	}
}

echo '<div style=""><table border=1>';
foreach($out as $val) {
	echo '<tr>';
	// echo '<td>'.$val['name'].'</td>';
	echo '<td><a href="'.$val['link'].'">'.$val['name'].'</a></td>';
	echo '<td>'.$val['extensions'][0].'</td>';
	echo '<td><img src='.$val['image'].'></td>';
	echo '</tr>';
}

echo '</table></div>';



