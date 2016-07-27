FROM drupal:7.50-apache

MAINTAINER turtleislan@gmail.com

# custom the PHP extensions for drupal
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev apt-utils \
	&& rm -rf /var/lib/apt/lists/* 
	#&& pecl install opcache \
	#&& docker-php-ext-install opcache 
	#&& docker-php-ext-enable  opcache 
  
  
  
  
# install require
RUN apt-get -y update && apt-get -y install vim drush net-tools mysql-client libapache2-mod-rpaf netcat
RUN drush dl -y --destination=sites/all/modules/contrib ctools module_filter devel admin_menu  l10n_update l10n_client 




# Reverse proxy add forward, fix remote IP Address
# https://github.com/gnif/mod_rpaf
# https://www.howtoforge.com/tutorial/how-to-install-nginx-as-reverse-proxy-for-apache-on-ubuntu-15-10/#step-configure-logging
# RUN apt-get -y install libapache2-mod-rpaf





# install pecl uploadprogress
#RUN apt-get -y install php-pear \
  #&& pecl install uploadprogress \
  #&& docker-php-ext-install uploadprogress 
  #&& docker-php-ext-enable  uploadprogress 
  #&& echo "extension=uploadprogress.so" > /etc/php5/mods-available/uploadprogress.ini \
  #&& echo "extension=uploadprogress.so" > /usr/local/etc/php/conf.d/docker-php-ext-uploadprogress.ini
  
# netcat  detect mysql start up


COPY ./config/drupal-foreground  /usr/local/bin/      
COPY ./config/drupal_setup.php  /var/www/html      

CMD ["drupal-foreground"]
