#!/bin/bash

# Esperar o Elasticsearch estar disponível
until curl -s -XGET 'http://localhost:9200' >/dev/null; do
    echo "Aguardando Elasticsearch iniciar..."
    sleep 5
done

# Configurar senha para os usuários padrão e definir uma senha específica para o usuário 'elastic'
echo "Configurando senhas..."

# Definir a senha desejada para o usuário 'elastic'
ELASTIC_PASSWORD="pesquisapdf"

# Definir a senha para o usuário 'elastic'
echo "Definindo senha para o usuário 'elastic'"
curl -XPOST -u elastic:$ELASTIC_PASSWORD -H "Content-Type: application/json" -d '{
  "password" : "'$ELASTIC_PASSWORD'"
}' "http://localhost:9200/_security/user/elastic/_password"
