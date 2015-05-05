#!/bin/bash

set -e

drush_site_install() {
  MYSQL_PASSWORD=${MYSQL_PASSWORD:-$MYSQL_ENV_MYSQL_ROOT_PASSWORD}
  MYSQL_HOST=${MYSQL_HOST:-$MYSQL_PORT_3306_TCP_ADDR}
  MYSQL_DB=${MYSQL_DB:-$MYSQL_ENV_MYSQL_DATABASE}
  MYSQL_USER=${MYSQL_USER:-root}
  MYSQL_PORT=${MYSQL_PORT_3306_TCP_PORT:-3306}

  while ! mysqladmin --password=$MYSQL_PASSWORD ping -h "$MYSQL_HOST" --silent; do
    sleep 1
  done

  drush site-install commerce_kickstart --db-url=mysql://$MYSQL_USER:$MYSQL_PASSWORD@$MYSQL_HOST:$MYSQL_PORT/$MYSQL_DB \
    --site-name=default --account-pass=changeme -y

  chown -R www-data:www-data sites
  echo "=> Done installing site using drush!"
}

extra_script() {
  if [ $EXTRA_SETUP_SCRIPT ]; then
    . $EXTRA_SETUP_SCRIPT
    echo "=> Successfully ran extra setup script ${EXTRA_SETUP_SCRIPT}."
  fi
}

main() {
  SITE_INSTALL=${SITE_INSTALL:-true}
  if [ "$SITE_INSTALL" = true ]; then
    drush_site_install
  fi

  extra_script
  exec apache2-foreground
  exit 1
}

main
