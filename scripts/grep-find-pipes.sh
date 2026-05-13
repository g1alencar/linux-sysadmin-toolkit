#!/bin/bash
# Referência rápida — grep, find e pipes

# grep — buscar dentro de arquivos
# grep -i "termo" arquivo          (ignora maiúsculas)
# grep -r "termo" /diretorio/      (recursivo)
# grep -n "termo" arquivo          (mostra número da linha)
# grep -A 3 -B 3 "termo" arquivo   (contexto: 3 linhas antes e depois)
# grep -c "termo" arquivo          (conta ocorrências)

# find — buscar arquivos
# find /caminho -name "*.conf"     (por nome)
# find /caminho -mtime -1          (modificados nas últimas 24h)
# find /caminho -size +100M        (maiores que 100MB)
# find /caminho -perm 777          (permissão específica)

# pipes — encadear comandos
# comando1 | comando2 | comando3
# ps aux | grep nginx              (filtrar processos)
# cat log | grep "erro" | wc -l   (contar erros)
# awk '{print $1}' arquivo         (pegar coluna específica)
