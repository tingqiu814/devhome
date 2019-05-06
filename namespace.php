<?php
namespace my{
    function say(){
        echo 'hello';
    }
}
namespace your{
    //$name = 'my\say';
    //$name();
    \my\say();
}
