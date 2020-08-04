################################################################################
# VERSION v0.0.4
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

FROM leonardofaria00/centos7-httpd-php73:latest

# Copiando variáveis de ambiente para o container
# COPY config/environment /etc/
# COPY config/yum.conf /etc/

# Instalando Pacotes de Dependências especificas para o GLPI
RUN yum -y --setopt=tsflags=nodocs update

RUN yum -y --setopt=tsflags=nodocs install \
    php-ldap \
    php-xmlrpc \
    php-imap \
    php-pear-CAS \
    php-pecl-apcu \
    php-opcache \
    php-devel \
    unixodbc-devel \
    php-sodium

# Copiando projeto para o container
COPY app/ /var/www/html

# Copia e executa o script de instalação do Projeto
COPY app-start.sh /opt/
RUN chmod +x /opt/app-start.sh

# Expondo a porta web
EXPOSE 80

# Iniciando projeto
ENTRYPOINT ["/opt/app-start.sh"]