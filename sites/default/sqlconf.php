<?php
$host = 'gateway01.eu-central-1.prod.aws.tidbcloud.com';
$port = 4000;
$login = '4Q3JgFwtV72XTzm.root';
$pass = 'hCCzJBE3Ko33HuTW';
$dbase = 'openemr_db';

$sqlconf = [];
global $sqlconf;
$sqlconf["host"]= $host;
$sqlconf["port"] = $port;
$sqlconf["login"] = $login;
$sqlconf["pass"] = $pass;
$sqlconf["dbase"] = $dbase;
$sqlconf["db_ssl"] = 1;
$sqlconf["db_ssl_ca"] = '/etc/ssl/certs/ca-tidb.pem';
$sqlconf["db_ssl_verify"] = 1;

$config = 1; // تم التثبيت
?>
