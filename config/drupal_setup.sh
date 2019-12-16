#!/bin/bash
set -e

FILE=sites/default/settings.php
if [ -f $FILE ];
then
  
  echo "File $FILE exists."
  
else
  
  #chown -Rcf www-data:www-data /var/www/html/sites
  #chmod 777 -Rcf /var/www/html/sites

  echo "File $FILE do not exist."
  echo "install to database $DRUPAL_DB_NAME to $DRUPAL_DB_HOST"
   
  drush si standard -y \
    --account-mail=service@webco.tw \
    --account-name=admin \
    --account-pass=admin \
    --db-su=$DRUPAL_DB_USER \
    --db-su-pw=$DRUPAL_DB_PASSWORD \
    --db-url=$DRUPAL_DB_DRIVE://$DRUPAL_DB_USER:$DRUPAL_DB_PASSWORD@$DRUPAL_DB_HOST/$DRUPAL_DB_NAME \
    --site-mail=dp7@webco.tw \
    --site-name=$DRUPAL_SITE_DOMAIN \
    --sites-subdir=default \
    install_configure_form.update_status_module='array(FALSE,FALSE)'\
    install_configure_form.date_default_timezone="Asia/Taipei" \
    install_configure_form.site_default_country=TW 
    
  drush dl -y --destination=sites/all/modules/contrib ctools module_filter devel admin_menu  l10n_update smtp backup_migrate bootstrap
  drush en -y ctools module_filter devel admin_menu  l10n_update locale smtp admin_devel update backup_migrate 
  drush vset dev_timer 1

  echo "default language zh-hant"
  drush dl -y --destination=sites/all/modules/contrib drush_language
  drush language-add zh-hant
  drush language-default zh-hant
  drush l10n-update-refresh
  drush l10n-update

  chown -Rcf www-data:www-data /var/www/html/sites/default/files
  drush php-script ./sites/drupal_setup.php
  chown -Rcf www-data:www-data /var/www/html/sites/default/private


fi

