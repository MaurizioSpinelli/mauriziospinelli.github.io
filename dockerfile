# Use a imagem oficial do Elasticsearch
FROM docker.elastic.co/elasticsearch/elasticsearch:7.16.1

# Exponha a porta 9200 para o Elasticsearch
EXPOSE 9200

# Copiar o arquivo de configuração para o contêiner
COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

# Definir permissões adequadas para o arquivo de configuração
USER root
RUN chown elasticsearch:elasticsearch /usr/share/elasticsearch/config/elasticsearch.yml
USER elasticsearch

# Configure variáveis de ambiente necessárias
ENV discovery.type=single-node

ENV network.host=0.0.0.0

# Comando para iniciar o Elasticsearch
CMD ["elasticsearch"]
