#!/bin/bash
# Referência rápida — permissões e usuários

# Ver usuário atual e grupos
whoami && id

# Criar usuário de serviço (sem login)
# sudo useradd -r -s /bin/false NOME_USUARIO

# Mudar dono de arquivo/diretório
# sudo chown -R usuario:grupo /caminho

# Permissões comuns:
# 755 - diretórios públicos (rwxr-xr-x)
# 750 - diretórios de serviço (rwxr-x---)
# 644 - arquivos de config públicos (rw-r--r--)
# 600 - arquivos sensíveis/chaves (rw-------)
