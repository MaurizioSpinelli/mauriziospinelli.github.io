#!/bin/bash

# Esperar o Elasticsearch estar disponível
until curl -s -XGET 'http://localhost:9200' >/dev/null; do
    echo "Aguardando Elasticsearch iniciar..."
    sleep 5
done

# Configurar senha para os usuários padrão
echo "Configurando senhas..."
/usr/share/elasticsearch/bin/elasticsearch-setup-passwords auto --batch

# Exemplo de como definir uma senha específica para o usuário 'elastic'
echo "Criando usuário 'elastic' com senha 'pesquisapdf'"
curl -XPOST -u elastic:pesquisapdf 'http://localhost:9200/_security/user/elastic/_password' -H "Content-Type: application/json" -d'
{
  "password" : "pesquisapdf"
}'
