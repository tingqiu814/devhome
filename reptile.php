<?php
/**
 * Created by PhpStorm.
 * User: cqg
 * Date: 16/5/3
 * Time: 下午2:08
 */
//set_time_limit(1);
//echo ini_get("max_execution_time");
//while(1);die;
function get_links($url)
{
    $cont = @file_get_contents($url);
    $preg = "/<a [^\\1]*?(href)=('|\")([^\\2]*?)\\2/"; //php正则中的引用是用两个转移符,并且用"?"取消贪婪匹配!!
    preg_match_all($preg,$cont,$arr,PREG_SET_ORDER);
    $arr = array_map(function($a){
        $m = array_pop($a);
        preg_match("/^http:/",$m,$return);
        if($return){
            file_put_contents("/tmp/output.txt",$m."\n",FILE_APPEND);
            return $m;
        }
    },$arr);
    $arr = array_unique($arr);
//    $arr = [
//        1=>"001",
//        2=>"002",
//        3=>"003",
//        4=>[
//            1=>"001",
//            2=>"002",
//            3=>"003"
//        ]
//    ];
    $str = outPutString($arr);
    file_put_contents("/tmp/output.txt",$str,FILE_APPEND);
    return $arr;
}
function outPutString($arr){
    $ret = '';
    if(is_array($arr)){
        foreach ($arr as $key => $val) {
            if(is_array($val)){

                $ret .= "[$key] => [\n".outPutString($val)."]\n";
            }else{
                $ret .= "[$key] => $val\n";
            }
        }
    }else{
        
    }
    return $ret;
}
$url = "http://www.hao123.com";
$links = get_links($url);
foreach ($links as $url) {
    $links = get_links($url);
}
