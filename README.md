# About this Repo

This is modify from Docker official [official image](https://docs.docker.com/docker-hub/official_repos/) for [drupal](https://registry.hub.docker.com/_/drupal/). See [the Docker Hub page](https://registry.hub.docker.com/_/drupal/)

#### Feature
 * php7.2 
 * drush 8.3.2
 * libapache2-mod-rpaf (reverse proxy add forward, fix remote IP Address)
 * PECL UploadProgress
 * OPCACH


```sh
git clone https://github.com/jimmy0916/dp7.git
cd dp7
deocker-compose up -d
```