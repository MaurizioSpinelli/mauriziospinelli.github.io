# Use a imagem oficial do Elasticsearch
FROM docker.elastic.co/elasticsearch/elasticsearch:7.10.1

# Exponha a porta 9200 para o Elasticsearch
EXPOSE 9200

# Configure variáveis de ambiente necessárias
ENV discovery.type=single-node

# Comando para iniciar o Elasticsearch
CMD ["elasticsearch"]
