#!/bin/bash

# Esperar o Elasticsearch estar disponível
until curl -s -XGET 'http://localhost:9200' >/dev/null; do
    echo "Aguardando Elasticsearch iniciar..."
    sleep 5
done

# Configurar senha para os usuários padrão
echo "Configurando senhas..."
/usr/share/elasticsearch/bin/elasticsearch-setup-passwords auto --batch

# Definir uma senha específica para o usuário 'elastic'
echo "Definindo senha para o usuário 'elastic'"
curl -XPOST -u elastic:password -H "Content-Type: application/json" -d '{
  "password" : "pesquisapdf"
}' "http://localhost:9200/_security/user/elastic/_password"
