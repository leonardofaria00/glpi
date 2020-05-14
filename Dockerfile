################################################################################
# VERSION v0.0.1
# AUTHOR:         Leonardo Santos <leonardofaria00@gmail.com>
# DESCRIPTION:    Image CentOS with PHP 7.3 and httpd 2.4
# TO_BUILD:       docker-compose build
# TO_RUN:         docker-compose up -d
#
# Dockerfile de construção do container WebApp utilizado pelo MD
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

#TODO
FROM leonardofaria00/httpd-base_webapp:latest

# Copia e executa o script de instalação do Projeto
COPY app-start.sh /opt/
RUN chmod +x /opt/app-start.sh

##################### FIM DA INSTALAÇÃO #####################

# Expondo a porta web
EXPOSE 80

# Iniciando servidor
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

ENTRYPOINT ["/opt/app-start.sh"]