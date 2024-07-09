# Use a imagem oficial do Elasticsearch
FROM docker.elastic.co/elasticsearch/elasticsearch:7.10.1

# Instale Tini
USER root
RUN apt-get update && apt-get install -y tini

# Use Tini como o entrypoint
ENTRYPOINT ["/usr/bin/tini", "--"]

# Exponha a porta 9200 para o Elasticsearch
EXPOSE 9200

# Configure variáveis de ambiente necessárias
ENV discovery.type=single-node

# Comando para iniciar o Elasticsearch
CMD ["elasticsearch"]
