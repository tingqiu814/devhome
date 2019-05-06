<?php
header('content-type:text/html;charset=utf-8;');
class a {
    public function __call($name,$arguments){
        echo '调用方法:'.$name.'<br>';
        echo 'arguments '.implode(',',$arguments).'<br>';
    }   
}

$a = new a();
$a->testcall();
var_dump(get_class($a));
