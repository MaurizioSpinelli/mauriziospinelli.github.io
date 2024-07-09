# Use a imagem oficial do Elasticsearch
FROM docker.elastic.co/elasticsearch/elasticsearch:7.10.1

# Instale Tini usando apk
USER root
RUN apk add --no-cache tini

# Use o tini como entrypoint para gerenciar sinalização
ENTRYPOINT ["/sbin/tini", "--"]

# Exponha a porta 9200 para o Elasticsearch
EXPOSE 9200

# Configure variáveis de ambiente necessárias
ENV discovery.type=single-node

# Comando para iniciar o Elasticsearch
CMD ["elasticsearch"]
