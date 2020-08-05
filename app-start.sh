#!/bin/bash

# Definindo Document root
FOLDER_WEB=/var/www/html/

# Definindo dono do document root
chown -R apache:apache ${FOLDER_WEB}
chmod -R ug+rw ${FOLDER_WEB}/config
chmod -R ug+rw ${FOLDER_WEB}/files

# Removendo seção
rm -rf app/files/_sessions/*

php bin/console dependencies install

composer install

# Executando aplicação
exec /usr/sbin/httpd -D FOREGROUND
