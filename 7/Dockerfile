FROM drupal:7-apache

MAINTAINER turtleislan@gmail.com

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





CMD ["drupal-foreground"]
