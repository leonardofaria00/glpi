################################################################################
# VERSION v0.0.1
# AUTHOR:         Leonardo Santos <leonardofaria00@gmail.com>
# DESCRIPTION:    Image CentOS with PHP 7.3 and httpd 2.4
#
# TO_BUILD:       docker build --pull --rm -f "Dockerfile" -t base-glpi:latest "."
# TO_RUN:         docker run --rm -it  -p 80:80/tcp base-glpi:latest
#
# Dockerfile de construção do container WebApp utilizado pelo MD
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

# TODO
FROM leonardofaria00/httpd-base_webapp:latest

# Instalando Pacotes de Dependências especificas para o GLPI
RUN yum -y --setopt=tsflags=nodocs update

RUN yum -y --setopt=tsflags=nodocs install \
    php-ldap \
    php-xmlrpc \
    php-imap \
    # php-cas \
    # php-curl \
    # php-apcu-bc \
    php-devel \
    unixodbc-devel

# RUN pecl install pdo_sqlsrv sqlsrv

# Copia e executa o script de instalação do Projeto
COPY app-start.sh /opt/
RUN chmod +x /opt/app-start.sh

##################### FIM DA INSTALAÇÃO #####################

# Expondo a porta web
EXPOSE 80

# Iniciando projeto
ENTRYPOINT ["/opt/app-start.sh"]