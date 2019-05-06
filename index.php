<?php
var_dump((in_array(1,array('1',2,4))));
die;
//phpinfo();
$a = ['nihao','hello'];
$b = ['h'=>'hello','n'=>'nihao'];
$b = array_values($b);

// var_dump($a,$b);
// var_dump($a==$b);
// var_dump($a===$b);

$m = preg_match("xunjj","http://xunlei.com");
var_dump($m);
$i = $a[array_rand($a=array(25,35,45),1)];
var_dump($i);
switch ($i){
case 25:
case 35:
    echo '25 or 35';
    break;
case 45:
    echo '45';
default:
    echo 'other';
}
$uri='http://gitlab.i.mm/acc-base/login_i_xunlei_com';
var_dump(parse_url($uri));
var_dump($_SERVER['REQUEST_URI']);
header("HTTP/1.1 404 Not Found");
setcookie("nihao",1);

//echo '用户';
//var_dump($_GET);
//echo mb_convert_encoding( $_GET['in'] , "GBK", "UTF-8"); 
