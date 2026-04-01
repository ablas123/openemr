<?php

//  OpenEMR
//  MySQL Config

$host   = 'gateway01.eu-central-1.prod.aws.tidbcloud.com';
$port   = '4000';
$login  = '4Q3JgFwtV72XTzm.root';
$pass   = 'hCCzJBE3Ko33HuTW';   // ضع كلمة المرور الصحيحة إن كنت غيرتها
$dbase  = 'openemr_db';

$sqlconf = [];
global $sqlconf;
$sqlconf["host"]= $host;
$sqlconf["port"] = $port;
$sqlconf["login"] = $login;
$sqlconf["pass"] = $pass;
$sqlconf["dbase"] = $dbase;

// إعدادات SSL
$sqlconf["db_ssl"] = 1;
$sqlconf["db_ssl_ca"] = '/etc/ssl/certs/ca-tidb.pem';
$sqlconf["db_ssl_verify"] = 1;

//////////////////////////
// تم الانتهاء من التثبيت
$config = 1; // كانت 0
//////////////////////////
?>
