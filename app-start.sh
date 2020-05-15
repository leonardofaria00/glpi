#!/bin/bash

# Controle du choix de version ou prise de la latest
[[ ! "$VERSION_GLPI" ]] &&
	VERSION_GLPI=$(curl -s https://api.github.com/repos/glpi-project/glpi/releases/latest | grep tag_name | cut -d '"' -f 4)

SRC_GLPI=$(curl -s https://api.github.com/repos/glpi-project/glpi/releases/tags/${VERSION_GLPI} | jq .assets[0].browser_download_url | tr -d \")
TAR_GLPI=$(basename ${SRC_GLPI})
FOLDER_GLPI=glpi/
FOLDER_WEB=/var/www/html/

# Check if TLS_REQCERT is present
if !(grep -q "TLS_REQCERT" /etc/ldap/ldap.conf); then
	echo "TLS_REQCERT isn't present"
	echo -e "TLS_REQCERT\tnever" >>/etc/ldap/ldap.conf
fi

# Téléchargement et extraction des sources de GLPI
if [ "$(ls ${FOLDER_WEB}${FOLDER_GLPI})" ]; then
	echo "Aplication is already installed"
else
	# Removendo arquivos do document root
	rm -rf /var/www/html/*

	wget -P ${FOLDER_WEB} ${SRC_GLPI}
	tar -xzf ${FOLDER_WEB}${TAR_GLPI} -C ${FOLDER_WEB}
	rm -Rf ${FOLDER_WEB}${TAR_GLPI}
	chown -R www-data:www-data ${FOLDER_WEB}${FOLDER_GLPI}
	mv /var/www/html/glpi/* /var/www/html
	chmod 777 -R /var/www/html/

fi

# Modificando vhost para default
echo -e "<VirtualHost *:80>\n\tDocumentRoot /var/www/html/glpi\n\n\t<Directory /var/www/html/glpi>\n\t\tAllowOverride All\n\t\tOrder Allow,Deny\n\t\tAllow from all\n\t</Directory>\n\n\tErrorLog /var/log/apache2/error-glpi.log\n\tLogLevel warn\n\tCustomLog /var/log/apache2/access-glpi.log combined\n</VirtualHost>" >/etc/apache2/sites-available/000-default.conf

#Add scheduled task by cron and enable
echo "*/2 * * * * www-data /usr/bin/php /var/www/html/glpi/front/cron.php &>/dev/null" >>/etc/cron.d/glpi

#Start cron service
service cron start

# Habilitar extension sqlsrv e pdo_sqlsrv
echo "extension=/usr/lib/php/20180731/sqlsrv.so" >>/etc/php/7.3/apache2/php.ini
echo "extension=/usr/lib/php/20180731/pdo_sqlsrv.so" >>/etc/php/7.3/apache2/php.ini
echo "extension=/usr/lib/php/20180731/sqlsrv.so" >>/etc/php/7.3/cli/php.ini
echo "extension=/usr/lib/php/20180731/pdo_sqlsrv.so" >>/etc/php/7.3/cli/php.ini

# Ativando rewrite no apache2
a2enmod rewrite && service apache2 restart && service apache2 stop

#Lancement du service apache au premier plan
exec /usr/sbin/httpd -D FOREGROUND
