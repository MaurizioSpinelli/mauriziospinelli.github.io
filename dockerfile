FROM docker.elastic.co/elasticsearch/elasticsearch:7.16.2

# Instalar a ferramenta expect
USER root
RUN apt-get update && apt-get install -y expect

# Copiar o arquivo de configuração para o contêiner
COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

# Copiar o script de inicialização para o contêiner
COPY setup-users.sh /usr/share/elasticsearch/setup-users.sh

# Definir permissões adequadas para o arquivo de configuração e script de inicialização
RUN chown elasticsearch:elasticsearch /usr/share/elasticsearch/config/elasticsearch.yml
RUN chmod +x /usr/share/elasticsearch/setup-users.sh
USER elasticsearch

# Expor a porta 9200 para requisições HTTP RESTful
EXPOSE 9200

# Configurar o Elasticsearch para ligar na interface 0.0.0.0
ENV network.host=0.0.0.0

# Comando para iniciar o Elasticsearch e configurar usuários
CMD ["/bin/bash", "-c", "bin/elasticsearch & /usr/share/elasticsearch/setup-users.sh && tail -f /dev/null"]
