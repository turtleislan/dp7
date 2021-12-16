FROM drupal:7.84-apache

MAINTAINER turtleislan@gmail.com

RUN apt-get update && apt-get install -y \
    vim \
    git

# custom the PHP extensions for drupal


# PHP mcrypt extension  
# mcrypt has been deprecated in 7.1 and removed in 7.2 in favor of OpenSSL


# GD freetype


    
  
# install require
RUN apt-get -y update && apt-get -y install vim  net-tools default-mysql-client  libapache2-mod-rpaf netcat cron

#RUN drush dl -y --destination=sites/all/modules/contrib ctools module_filter devel admin_menu  l10n_update l10n_client 
# netcat  detect mysql start up

# install drush
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN git clone https://github.com/drush-ops/drush.git /usr/local/src/drush
RUN cd /usr/local/src/drush &&  git checkout 8.4.5 && composer install
RUN ln -s /usr/local/src/drush/drush /usr/bin/drush


# Reverse proxy add forward, fix remote IP Address
# https://github.com/gnif/mod_rpaf
# https://www.howtoforge.com/tutorial/how-to-install-nginx-as-reverse-proxy-for-apache-on-ubuntu-15-10/#step-configure-logging
# RUN apt-get -y install libapache2-mod-rpaf tidy





# install pecl uploadprogress  fail in PHP7
 
  
# compile uploadprogress for PHP7.4
git clone https://github.com/php/pecl-php-uploadprogress/ /usr/src/php/ext/uploadprogress/ && \
    docker-php-ext-configure uploadprogress && \
    docker-php-ext-install uploadprogress && \




COPY ./config/default.settings.php  /var/www/html/sites/default
COPY ./config/wait-for-mysql.sh  /var/www/html
COPY ./config/drupal-foreground  /usr/local/bin/
COPY ./config/rpaf.conf  /etc/apache2/mods-available/rpaf.conf


#RUN ls -al /usr/local/bin \
RUN pwd \
  && chmod 755 /usr/local/bin/drupal-foreground \
  && chmod 755 /var/www/html/wait-for-mysql.sh

#backup default sites to tar
RUN chown -Rf www-data:www-data . \
  && chmod -Rf 777 ./sites \
  && tar -cf sites.tar ./sites \
  && rm -rf /var/lib/apt/lists/* \
  && chmod 755 /usr/local/bin/  \
  && a2enmod ssl headers expires\
  && a2ensite default-ssl \
  && mkdir /etc/apache2/ssl \
  && chmod -Rvf 600 /etc/apache2/ssl


# defaul disable SSL
COPY ./config/ssl/default-ssl.conf.disable  /etc/apache2/sites-available/default-ssl.conf



  
#RUN ls -al /usr/local/etc/php/conf.d/

EXPOSE 80 443

CMD ["drupal-foreground"]
