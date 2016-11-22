FROM drupal:7.51-apache

MAINTAINER turtleislan@gmail.com


RUN ls -al /usr/local/bin
COPY ./config/drupal-foreground   /usr/local/bin/
RUN chmod 755 /usr/local/bin/drupal-foreground 
RUN ls -al /usr/local/bin

CMD ["apache2-foreground"]
