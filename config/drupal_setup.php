<?php
 
/**
  Setup private file
  */
  


$path = conf_path().'/all/translations';
if (!is_dir($path)){  
  #drupal_mkdir($path);
}

$path = conf_path().'/private';

if (!is_dir($path)){  
  drupal_mkdir($path);
}

echo "private path: ". $path ."\n";

if (is_dir($path) && is_writable($path)){
  file_create_htaccess($path);
  variable_set('file_private_path',$path);
}







