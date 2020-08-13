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

# Adicionando tarefas no CRONTAB do host
echo "*/2 * * * * apache /usr/bin/php /var/www/html/front/cron.php &>/dev/null" >> /etc/cron.d/glpi
service crontabs start

# Executando aplicação
exec /usr/sbin/httpd -D FOREGROUND
