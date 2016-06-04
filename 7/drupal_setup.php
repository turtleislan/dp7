<?php
 
/**
  Setup private file
  */
  
  
drupal_mkdir(conf_path().'/all/translations');

$path = conf_path().'/private';
drupal_mkdir($path);
if (is_dir($path) && is_writable($path)){
  file_create_htaccess($path);
  variable_set('file_private_path',$path);
}







