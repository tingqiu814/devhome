<?php
session_start();
function sumOfInts(int ...$ints)
{
    return array_sum($ints);
}
var_dump(sumOfInts(1,'2',3.4));

function arraysSum(array ...$arrays): array 
{
    return array_map(function(array $array): int 
    {
        return array_sum($array);
    }, $arrays);
}
print_r(arraysSum([1,2,3], [4,5,6], [7,8,9]));

$username = $_GET['user']??'nobody';
//等价于 
$username = isset($_GET['user']) ? $_GET['user'] : 'nobody';
$username = $_GET['user'] ?? $_POST['user'] ?? 'nobody';

//太空船操作符(组合比较符)
//echo 1 <=> 1;    //0
//echo 1 <=> 2;    //-1
//echo 2 <=> 1;    //1

//通过define()定义常量数组
define('Animals',[
    'dog',
    'cat'
]);
//匿名类
//现在支持通过new class 来实例化一个匿名类，这可以用来替代一些“用后即焚”的完整类定义。
interface Logger{
    public function log(string $msg);
}

class Application {
    private $logger;

    public function getLogger(): Logger {
        return $this->logger;
    }
    public function setLogger(Logger $logger){
        $this->logger = $logger;
    }
}
$app = new Application;
$app->setLogger(new class implements Logger{
    public function log(string $msg){
        echo $msg;
    }
}); 
var_dump($app->getLogger());

//Closure::call() 现在有着更好的性能，简短干练的暂时绑定一个方法到对象上闭包并调用它。
class A { private $x=1;}
// pre php 7 code
$getXCB = function (){return $this->x;};
$getX = $getXCB -> bindTo(new A, 'A');  //intermediate closure
echo $getX();
// PHP 7+ code 
$getX = function(){return $this->x;};
echo $getX->call(new A);

//从同一个namespace导入类、函数和常量可以通过单个use语句一次性导入了。
//pre php7 code
//use some\namespace\ClassA;
//use some\namespace\ClassB;
//use some\namespace\ClassC;
//
//use function some\namespace\fn_a;
//use function some\namespace\fn_b;
//use function some\namespace\fn_c;
//
//use const some\namespace\ConstA;
//use const some\namespace\ConstB;
//use const some\namespace\ConstC;
////PHP7 code
//use some\namespace\{ClassA, ClassB, ClassC as C};
//use function some\namespace\{fn_a, fn_b, fn_c};
//use const some\namespace\{ConstA, ConstB, ConstC};

// new Generator::getReturn() method
$gen = (function() {
        yield 1;
        yield 2;

        return 3;
        })();

foreach ($gen as $val) {
    echo $val, PHP_EOL;
}

echo $gen->getReturn(), PHP_EOL;

//
function gen()
{
    yield 1;
    yield 2;

    yield from gen2();
}

function gen2()
{
    yield 3;
    yield 4;
}

foreach (gen() as $val)
{
    echo $val, PHP_EOL;
}
// intdiv()
$v = intdiv(11,3);
//等同于floor之后再强制转换为int
$v = floor(11/3);
var_dump($v);

$subject = 'Aaaaaa Bbb';

preg_replace_callback_array(
    [
        '~[a]+~i' => function ($match) {
        echo strlen($match[0]), ' matches for "a" found', PHP_EOL;
        },
        '~[b]+~i' => function ($match) {
        echo strlen($match[0]), ' matches for "b" found', PHP_EOL;
        }
    ],
    $subject
);

var_dump($subject);




