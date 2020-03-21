FROM bref/php-74-fpm-dev:0.5.17

COPY --from=jakzal/phpqa:1.33.0-php7.4 \
  /tools/deptrac \
  /tools/psalm \
  /tools/php-cs-fixer \
  /tools/phpcs \
  /tools/phpcbf \
  /tools/phpmd \
  /tools/security-checker \
  /usr/bin/

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_HOME=/tmp/.composer
COPY --from=composer:1.9.3 /usr/bin/composer /usr/bin/

USER root
COPY php-fpm.conf /opt/bref/etc/php-fpm.conf
CMD /opt/bin/php-fpm \
  --nodaemonize \
  --fpm-config /opt/bref/etc/php-fpm.conf \
  -d opcache.validate_timestamps=1 \
  --force-stderr \
  --allow-to-run-as-root
