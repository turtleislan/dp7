FROM drupal:7-apache

MAINTAINER turtleislan

# custom the PHP extensions for drupal
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev \
	&& rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure opcache \
	&& docker-php-ext-install opcache 
  
# install require
RUN apt-get -y update && apt-get -y install vim drush net-tools mysql-client


# install pecl uploadprogress
RUN apt-get -y install php-pear \
  && pecl install uploadprogress \
  && echo "extension=uploadprogress.so" > /etc/php5/mods-available/uploadprogress.ini \
  && echo "extension=uploadprogress.so" > /usr/local/etc/php/conf.d/docker-php-ext-uploadprogress.ini
  

ENV DRUPAL_FOLDER default
ENV DRUPAL_DB_NAME drupal
ENV DRUPAL_DB_HOST 172.111.0.3
ENV DRUPAL_DB_SU drupal
ENV DRUPAL_DB_PASSWORD drupal
ENV DRUPAL_SETUP_SCRIPT drupal_setup.php

#COPY ${DRUPAL_SETUP_SCRIPT} ${DRUPAL_SETUP_SCRIPT}
COPY drupal-foreground  /usr/local/bin/      
RUN mkdir sites/all/translations




#install profile and save database to install.sql
RUN drush si minimal -y  \
    --account-mail=service@webco.tw \
    --account-name=admin \
    --account-pass=admin \
    --db-su=${DRUPAL_DB_SU} \
    --db-su-pw=${DRUPAL_DB_PASSWORD} \
    --db-url=mysql://${DRUPAL_DB_SU}:${DRUPAL_DB_PASSWORD}@${DRUPAL_DB_HOST}/${DRUPAL_DB_NAME} \
    --site-mail=dp7@webco.tw \
    --site-name=dp7 \
    --sites-subdir=default \
    install_configure_form.date_default_timezone="Asia/Taipei" \
    install_configure_form.site_default_country=TW
    
   
   
RUN drush dl -y --destination=sites/all/modules/contrib ctools module_filter devel admin_menu  l10n_update l10n_client 
RUN drush en -y ctools module_filter devel admin_menu  l10n_update  locale 
RUN drush vset dev_timer 1

COPY drupal_setup.php drupal_setup.php

#echo "Setup drupal by $SCRIPT"    
RUN drush php-script  drupal_setup.php
    


RUN drush dl -y drush_language \
  && drush language-add zh-hant \
  && drush language-enable zh-hant \
  && drush language-default zh-hant \
  && drush l10n-update-refresh \
  && drush l10n-update


#  if connect to mysql fail check the firwall
#  iptables -I FORWARD -j ACCEPT


RUN chown -R www-data:www-data sites

CMD ["drupal-foreground"]
