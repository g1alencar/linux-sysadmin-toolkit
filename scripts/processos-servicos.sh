
# Interpretar status de um serviço:
# Active: active (running) = saudável
# Active: failed = investigar com journalctl -u SERVICO -n 50
# enabled = inicia automaticamente no boot

# Ver log de acesso do Nginx
# sudo tail -f /var/log/nginx/access.log

# Campos do log: IP - - [data] "MÉTODO /caminho" STATUS bytes "-" "agente"
# Status 200 = OK | 404 = não encontrado | 500 = erro no servidor
