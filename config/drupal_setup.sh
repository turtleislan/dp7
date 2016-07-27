#!/bin/bash
set -e

FILE=sites/default/settings.php


if [ -f $FILE ];
then
   echo "File $FILE exists."
   
   
else
   echo "File $FILE does not exist. install to database $DRUPAL_DB_HOST"
   drush si standard -y \
    --account-mail=service@webco.tw \
    --account-name=admin \
    --account-pass=admin \
    --db-su=$DRUPAL_DB_USER \
    --db-su-pw=$DRUPAL_DB_PASSWORD \
    --db-url=mysql://$DRUPAL_DB_USER:$DRUPAL_DB_PASSWORD@$DRUPAL_DB_HOST/$DRUPAL_DB_NAME \
    --site-mail=dp7@webco.tw \
    --site-name=$DRUPAL_SITE_DOMAIN \
    --sites-subdir=default \
    install_configure_form.update_status_module='array(FALSE,FALSE)'\
    install_configure_form.date_default_timezone="Asia/Taipei" \
    install_configure_form.site_default_country=TW 
    


    
    drush dl -y ctools module_filter devel admin_menu  l10n_update smtp
    drush en -y ctools module_filter devel admin_menu  l10n_update locale smtp admin_devel update


    drush dl -y drush_language
    drush language-add zh-hant
    drush language-default zh-hant
    drush  l10n-update-refresh
    drush l10n-update
    
    drush vset dev_timer 1

fi

chown -Rcf www-data:www-data /var/www/html/sites/default
chown -Rcf www-data:www-data /var/www/html/sites/all
echo "Setup drupal by drupal_setup.php"   
drush php-script sites/drupal_setup.php