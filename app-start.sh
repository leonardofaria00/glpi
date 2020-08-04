#!/bin/bash

# Definindo Document root
FOLDER_WEB=/var/www/html/

# Definindo dono do document root
chown -R apache:apache ${FOLDER_WEB}

# Removendo seção
rm -rf app/files/_sessions/*

# Executando aplicação
exec /usr/sbin/httpd -D FOREGROUND
