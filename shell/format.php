<?php
$months = [
"Jan"=>"01",//"一月",
"Feb"=>"02",//"二月",
"Mar"=>"03",//"三月",
"Apr"=>"04",//"四月",
"May"=>"05",//"五月",
"Jun"=>"06",//"六月",
"Jul"=>"07",//"七月",
"Aug"=>"08",//"八月",
"Sep"=>"09",//"九月",
"Oct"=>"10",//"十月",
"Nov"=>"11",//"十一月",
"Dec"=>"12",//"十二月",
];
//比较时间
ini_set('date.timezone','Asia/Shanghai');

$now = date("Y m d H:i:s",strtotime("+1 month"));
echo $now;die;

if($argc==1){
    exit("please add domains file\n");
}
$pwd = dirname(__FILE__);
exec("sh $pwd/get_certificate_info $argv[1]",$res);
foreach($res as $item){
    if(strpos($item,"notAfter")===false){
        echo $item;
    }else{
        $str = str_replace("  "," ",substr($item,9,-4));
        $time = explode(" ",$str);
        $t = $time[3]." ".$months[$time[0]]." ".$time[1]." ".$time[2];
        if($t<=$now){
            echo '已过期';
        }
        echo "过期时间：". $t;
    }
    echo "\n";
};
