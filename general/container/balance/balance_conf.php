<?php

$lines = file('/etc/hosts');

$localhost = array_shift(preg_split('/\s+/', array_shift($lines)));

$lines = array_filter($lines, function($var) {
  $arr = preg_split('/\s+/', $var);
  if (! ip2long($arr[0])) return false;

  return strpos($var, '_' . getenv('BACKEND_NAME') . '_');
});

$port = getenv('PORT');

$lines = array_map(function($var) use ($port) {
  $arr = preg_split('/\s+/', $var);
  return $arr[0] . ":$port";
}, $lines);

$lines = array_unique($lines);

$cmd = "balance -b ::ffff:$localhost $port " . join($lines, ' ');

exec($cmd);
