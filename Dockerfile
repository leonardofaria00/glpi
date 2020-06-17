################################################################################
# VERSION v0.0.2
# AUTHOR:         Leonardo Santos <leonardofaria00@gmail.com>
# DESCRIPTION:    Image CentOS with PHP 7.3 and httpd 2.4
#
# TO_BUILD:       docker build --pull --rm -f "Dockerfile" -t glpi:latest "."
# TO_RUN:         docker run --rm -it  -p 80:80/tcp glpi:latest
#
# Dockerfile de construção do container WebApp utilizado pelo MD
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

# TODO
FROM leonardofaria00/centos7-httpd-php73:latest

# Instalando Pacotes de Dependências especificas para o GLPI
RUN yum -y --setopt=tsflags=nodocs update

RUN yum -y --setopt=tsflags=nodocs install \
    php-ldap \
    php-xmlrpc \
    php-imap \
    php-pear-CAS \
    php-pear-Net-Curl \
    php73-php-pecl-apcu-bc \
    php-pecl-apcu \
    php-opcache \
    php-devel \
    unixodbc-devel

# RUN pecl install pdo_sqlsrv sqlsrv

# Copia e executa o script de instalação do Projeto
COPY app-start.sh /opt/
RUN chmod +x /opt/app-start.sh

COPY glpi/ /var/www/html
COPY config/config_db.php /var/www/html/config

COPY config/environment /etc/
COPY config/yum.conf /etc/

# Expondo a porta web
EXPOSE 80

# Iniciando projeto
ENTRYPOINT ["/opt/app-start.sh"]
