<?php
var_dump(PHP_SAPI);
file_put_contents("/tmp/out.log",PHP_SAPI."\n",FILE_APPEND);
