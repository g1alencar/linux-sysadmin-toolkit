#!/usr/bin/env bash
# health_check.sh — Verifica se serviços essenciais estão rodando
# Autor: Gabriel Alencar
# Data: $(date)

set -euo pipefail

# ── Configuração ──────────────────────────────────────────
SERVICES=("ssh" "cron")   # adicione os serviços que quiser checar
LOG_FILE="/tmp/health_check.log"

# ── Cores para output ─────────────────────────────────────
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# ── Função principal ──────────────────────────────────────
check_service() {
  local service=$1

  if systemctl is-active --quiet "$service" 2>/dev/null; then
    echo -e "${GREEN}[OK]${NC}   $service está rodando"
    echo "[OK] $service" >> "$LOG_FILE"
  else
    echo -e "${RED}[FAIL]${NC} $service está PARADO ou não existe"
    echo "[FAIL] $service" >> "$LOG_FILE"
  fi
}

# ── Execução ──────────────────────────────────────────────
echo "======================================"
echo " Health Check — $(date '+%Y-%m-%d %H:%M:%S')"
echo "======================================"
echo "" > "$LOG_FILE"

for service in "${SERVICES[@]}"; do
  check_service "$service"
done

echo "--------------------------------------"
echo "Log salvo em: $LOG_FILE"
