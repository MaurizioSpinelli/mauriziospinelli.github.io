#!/bin/bash

# Esperar o Elasticsearch estar disponível
until curl -s -XGET 'http://localhost:9200' >/dev/null; do
    echo "Aguardando Elasticsearch iniciar..."
    sleep 5
done

# Configurar senha para os usuários padrão e capturar a saída
echo "Configurando senhas..."
PASSWORD_OUTPUT=$(expect -c '
spawn /usr/share/elasticsearch/bin/elasticsearch-setup-passwords auto --batch
expect "PASSWORD elastic"
set elastic_password $expect_out(buffer)
puts $elastic_password
')

# Extrair a senha gerada para o usuário 'elastic'
ELASTIC_PASSWORD=$(echo "$PASSWORD_OUTPUT" | grep -oP "(?<=PASSWORD elastic : )\S+")

echo "Senha gerada para o usuário 'elastic': $ELASTIC_PASSWORD"

# Definir uma nova senha específica para o usuário 'elastic' usando a senha gerada
echo "Definindo nova senha para o usuário 'elastic'"
curl -XPOST -u elastic:$ELASTIC_PASSWORD -H "Content-Type: application/json" -d '{
  "password" : "changeme"
}' "http://localhost:9200/_security/user/elastic/_password"
