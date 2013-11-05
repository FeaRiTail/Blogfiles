<?
$url = $_GET["url"];
$url .= "?1=1";
foreach ( $_GET as $getKey => $getVar ) {
  //print $getVar;
  if ( $getKey != "url" ) {
    $url .= "&".$getKey."=".str_replace(" ","+",urlencode($getVar));
  }
}
// tested with such urls:
// http://localhost/test/proxy.php?url=http://localhost:8888/kettle/transStatus/&name=Row+generator+test&id=ee8d2d9d-da0a-404c-8488-ededf6b176df&xml=y
//echo $url;
$curl = curl_init();
curl_setopt($curl, CURLOPT_URL, $url);
curl_setopt($curl, CURLOPT_HEADER, true);
curl_setopt($curl, CURLOPT_USERPWD, "cluster:cluster"); 
curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);

$response = curl_exec($curl);
$content = curl_getinfo($curl,CURLINFO_CONTENT_TYPE);
header("Content-type: ".$content);
// pretty ugly but I could not come up with a simpler approach to separate the HTTP-Headers from the Content
$response_arr = explode("\r\n",$response);
$startresponse = false;
$responsetext = "";
foreach (  $response_arr as $line ) {
  if ( trim($line) == "" ) {
    $startresponse = true;
  }
  if ( $startresponse ) {
    $responsetext .= $line;
  }
}
echo $responsetext;
?>