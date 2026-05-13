#!/bin/bash
set -euo pipefail

# Configurações
SERVICOS=("nginx" "ssh" "bancoDados")
LIMITE_DISCO=80
LIMITE_CPU=90
LIMITE_MEM=90
LOG="/tmp/health-check.log"

# Cores para output
VERDE='\033[0;32m'
VERMELHO='\033[0;31m'
AMARELO='\033[1;33m'
RESET='\033[0m'

DATA=$(date '+%Y-%m-%d %H:%M:%S')
echo "========================================" | tee -a $LOG
echo "Health Check — $DATA" | tee -a $LOG
echo "========================================" | tee -a $LOG

# 1. Verifica serviços
echo -e "\n[SERVIÇOS]" | tee -a $LOG
for SERVICO in "${SERVICOS[@]}"; do
    if systemctl is-active --quiet "$SERVICO"; then
        echo -e "${VERDE}✓ $SERVICO — rodando${RESET}" | tee -a $LOG
    else
        echo -e "${VERMELHO}✗ $SERVICO — PARADO${RESET}" | tee -a $LOG
    fi
done

# 2. Verifica uso de disco
echo -e "\n[DISCO]" | tee -a $LOG
USO=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
if [ "$USO" -gt "$LIMITE_DISCO" ]; then
    echo -e "${VERMELHO}✗ Disco: ${USO}% — CRÍTICO (limite: ${LIMITE_DISCO}%)${RESET}" | tee -a $LOG
else
    echo -e "${VERDE}✓ Disco: ${USO}% — OK${RESET}" | tee -a $LOG
fi

# 3. Verifica memória
echo -e "\n[MEMÓRIA]" | tee -a $LOG
MEM=$(free | awk 'NR==2 {printf "%.0f", $3/$2*100}')
if [ "$MEM" -gt "$LIMITE_MEM" ]; then
    echo -e "${VERMELHO}✗ Memória: ${MEM}% — CRÍTICO${RESET}" | tee -a $LOG
else
    echo -e "${VERDE}✓ Memória: ${MEM}% — OK${RESET}" | tee -a $LOG
fi

# 4. Verifica erros 404 recentes no Nginx
echo -e "\n[NGINX — erros 404 última hora]" | tee -a $LOG
HORA_ATUAL=$(date '+%d/%b/%Y:%H')
ERROS_404=$(sudo grep "$HORA_ATUAL" /var/log/nginx/access.log 2>/dev/null | grep -c " 404 " || true)
if [ "$ERROS_404" -gt 10 ]; then
    echo -e "${AMARELO}⚠ $ERROS_404 erros 404 na última hora${RESET}" | tee -a $LOG
else
    echo -e "${VERDE}✓ $ERROS_404 erros 404 na última hora — OK${RESET}" | tee -a $LOG
fi

echo -e "\nLog salvo em: $LOG"
