#!/bin/bash

# ===================================================================
# MARCELOSETUP v2.0 - ALL IN ONE MARKETING AUTOMATION
# Setup Completo para Automação de Marketing Digital
# Powered by @marceloagentedigital
# Domain: marceloautomacoes.com.br
# Repository: https://github.com/marceloagentedigital/marcelosetup
# ===================================================================

set -e  # Exit on any error

# ===================================================================
# VARIÁVEIS GLOBAIS E CONFIGURAÇÕES
# ===================================================================

# Informações do script
SCRIPT_VERSION="2.0.0"
SCRIPT_NAME="MARCELOSETUP"
SCRIPT_AUTHOR="@marceloagentedigital"
SCRIPT_URL="marceloautomacoes.com.br"
SCRIPT_REPO="https://raw.githubusercontent.com/marcelo-davila-setup"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

# Símbolos
CHECKMARK="✅"
CROSSMARK="❌"
WARNING="⚠️"
ROCKET="🚀"
GEAR="⚙️"
PACKAGE="📦"
WORLD="🌐"
LOCK="🔒"
FIRE="🔥"

# Configurações padrão
DEFAULT_DOMAIN=""
DEFAULT_EMAIL=""
INSTALL_MODE="complete"
LOG_FILE="/tmp/marcelosetup.log"
INSTALL_DIR="/opt/marcelosetup"
COMPOSE_PROJECT_NAME="marcelosetup"

# Contadores de progresso
TOTAL_STEPS=50
CURRENT_STEP=0

# ===================================================================
# FUNÇÕES DE UTILIDADE
# ===================================================================

# Função para log com timestamp
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Função para log colorido
log_colored() {
    local color=$1
    local message=$2
    echo -e "${color}[$(date '+%Y-%m-%d %H:%M:%S')] $message${NC}" | tee -a "$LOG_FILE"
}

# Função para sucesso
success() {
    log_colored "$GREEN" "$CHECKMARK $1"
}

# Função para erro
error() {
    log_colored "$RED" "$CROSSMARK $1"
    exit 1
}

# Função para warning
warning() {
    log_colored "$YELLOW" "$WARNING $1"
}

# Função para info
info() {
    log_colored "$CYAN" "$GEAR $1"
}

# Função para progresso
progress() {
    CURRENT_STEP=$((CURRENT_STEP + 1))
    local percentage=$((CURRENT_STEP * 100 / TOTAL_STEPS))
    local bar_length=30
    local filled=$((percentage * bar_length / 100))
    local empty=$((bar_length - filled))
    
    printf "\r${BLUE}[${GREEN}"
    printf "%*s" $filled | tr ' ' '█'
    printf "${WHITE}"
    printf "%*s" $empty | tr ' ' '░'
    printf "${BLUE}] ${WHITE}%3d%% ${CYAN}(%02d/%02d) %s${NC}" $percentage $CURRENT_STEP $TOTAL_STEPS "$1"
    
    if [[ $CURRENT_STEP -eq $TOTAL_STEPS ]]; then
        echo ""
    fi
    
    log "Progress: ($CURRENT_STEP/$TOTAL_STEPS) $1"
}

# Banner principal
show_banner() {
    clear
    echo -e "${CYAN}"
    cat << 'EOF'
███╗   ███╗ █████╗ ██████╗  ██████╗███████╗██╗      ██████╗ 
████╗ ████║██╔══██╗██╔══██╗██╔════╝██╔════╝██║     ██╔═══██╗
██╔████╔██║███████║██████╔╝██║     █████╗  ██║     ██║   ██║
██║╚██╔╝██║██╔══██║██╔══██╗██║     ██╔══╝  ██║     ██║   ██║
██║ ╚═╝ ██║██║  ██║██║  ██║╚██████╗███████╗███████╗╚██████╔╝
╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚══════╝ ╚═════╝ 
EOF
    echo -e "${NC}"
    echo -e "${WHITE}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${WHITE}║${CYAN}              SETUP v${SCRIPT_VERSION} - ALL IN ONE                     ${WHITE}║${NC}"
    echo -e "${WHITE}║${YELLOW}        Setup Completo para Automação de Marketing        ${WHITE}║${NC}"
    echo -e "${WHITE}║                                                           ║${NC}"
    echo -e "${WHITE}║${MAGENTA}           Powered by ${SCRIPT_AUTHOR}           ${WHITE}║${NC}"
    echo -e "${WHITE}║${BLUE}              ${SCRIPT_URL}                ${WHITE}║${NC}"
    echo -e "${WHITE}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    # Termos de uso
    echo -e "${GRAY}© 2024 Marcelo Dávila - Todos os direitos reservados${NC}"
    echo -e "${GRAY}Powered by @marceloagentedigital${NC}"
    echo -e "${GRAY}marceloautomacoes.com.br${NC}"
    echo ""
    echo -e "${YELLOW}AVISO LEGAL: O MarceloSetup v2.0 é propriedade intelectual de Marcelo Dávila${NC}"
    echo ""
    echo -e "${WHITE}LICENÇA E SERVIÇOS${NC}"
    echo -e "${WHITE}Prezado(a) Cliente,${NC}"
    echo -e "${WHITE}Ao utilizar o MarceloSetup v2.0, você está adquirindo acesso a uma solução${NC}"
    echo -e "${WHITE}premium desenvolvida exclusivamente por Marcelo Dávila (@marceloagentedigital),${NC}"
    echo -e "${WHITE}especialista em marketing digital e automações.${NC}"
    echo ""
    echo -e "${GREEN}✅ Setup Profissional Completo - 15+ ferramentas de marketing digital${NC}"
    echo -e "${GREEN}✅ Infraestrutura Enterprise - Configuração que custaria R$ 5.000-15.000${NC}"
    echo -e "${GREEN}✅ Suporte Técnico Especializado - Suporte direto com o criador${NC}"
    echo -e "${GREEN}✅ Atualizações Vitalícias - Sempre a versão mais atualizada${NC}"
    echo -e "${GREEN}✅ Garantia de Funcionamento - Ambiente testado e otimizado${NC}"
    echo ""
    echo -e "${BLUE}📞 CONTRATO DE SERVIÇOS PREMIUM${NC}"
    echo -e "${BLUE}Email para Contratação: info@marceloautomacoes.com.br${NC}"
    echo ""
    
    while true; do
        echo -e "${YELLOW}Concorda com os termos? ${WHITE}(${GREEN}Sim${WHITE}/${RED}Não${WHITE}): ${NC}" 
        read -r ACEITA_TERMOS
        
        case ${ACEITA_TERMOS,,} in
            sim|s|yes|y)
                echo -e "${GREEN}✅ Termos aceitos. Iniciando instalação...${NC}"
                echo ""
                break
                ;;
            não|nao|n|no)
                echo -e "${RED}❌ Termos não aceitos. Instalação cancelada.${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}Resposta inválida. Digite 'Sim' ou 'Não'.${NC}"
                ;;
        esac
    done
}

# Banner de conclusão
show_completion_banner() {
    clear
    echo -e "${GREEN}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                                                           ║"
    echo "║          🎉 INSTALAÇÃO CONCLUÍDA COM SUCESSO! 🎉          ║"
    echo "║                                                           ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# ===================================================================
# FUNÇÕES DE VERIFICAÇÃO
# ===================================================================

# Verificar se é root
check_root() {
    progress "Verificando permissões de administrador"
    if [[ $EUID -ne 0 ]]; then
        error "Este script deve ser executado como root. Use: sudo $0"
    fi
    success "Permissões de administrador confirmadas"
}

# Verificar sistema operacional
check_system() {
    progress "Detectando sistema operacional"
    
    if [[ ! -f /etc/os-release ]]; then
        error "Sistema operacional não suportado - /etc/os-release não encontrado"
    fi
    
    source /etc/os-release
    OS_NAME=$NAME
    OS_VERSION=$VERSION_ID
    
    case $OS_NAME in
        "Ubuntu"*)
            if [[ $(echo "$OS_VERSION >= 20.04" | bc -l) -ne 1 ]]; then
                error "Ubuntu 20.04 ou superior é necessário. Detectado: $OS_VERSION"
            fi
            PACKAGE_MANAGER="apt"
            ;;
        "Debian"*)
            if [[ $(echo "$OS_VERSION >= 11" | bc -l) -ne 1 ]]; then
                error "Debian 11 ou superior é necessário. Detectado: $OS_VERSION"
            fi
            PACKAGE_MANAGER="apt"
            ;;
        *)
            error "Sistema operacional não suportado: $OS_NAME $OS_VERSION"
            ;;
    esac
    
    success "Sistema detectado: $OS_NAME $OS_VERSION"
}

# Verificar recursos do sistema
check_resources() {
    progress "Verificando recursos do sistema"
    
    # Verificar RAM
    local ram_gb=$(free -g | awk 'NR==2{printf "%.0f", $2}')
    if [[ $ram_gb -lt 4 ]]; then
        error "Mínimo 4GB RAM necessário. Detectado: ${ram_gb}GB"
    fi
    
    # Verificar espaço em disco
    local disk_gb=$(df -BG / | awk 'NR==2 {print $4}' | sed 's/G//')
    if [[ $disk_gb -lt 20 ]]; then
        error "Mínimo 20GB espaço livre necessário. Disponível: ${disk_gb}GB"
    fi
    
    # Verificar CPU cores
    local cpu_cores=$(nproc)
    if [[ $cpu_cores -lt 2 ]]; then
        warning "Recomendado 2+ cores CPU. Detectado: ${cpu_cores} core(s)"
    fi
    
    success "Recursos verificados: RAM ${ram_gb}GB, Disco ${disk_gb}GB, CPU ${cpu_cores} core(s)"
}

# Verificar conexão com internet
check_internet() {
    progress "Verificando conectividade"
    
    if ! ping -c 1 google.com &> /dev/null; then
        error "Sem conexão com a internet. Verifique sua rede."
    fi
    
    success "Conexão com internet confirmada"
}

# Detectar instalações existentes
detect_existing_installations() {
    progress "Detectando instalações existentes"
    
    local existing_services=()
    
    # Verificar Docker
    if command -v docker &> /dev/null; then
        existing_services+=("Docker")
    fi
    
    # Verificar containers rodando
    if docker ps &> /dev/null; then
        local containers=$(docker ps --format "table {{.Names}}" | tail -n +2)
        if [[ -n "$containers" ]]; then
            existing_services+=("Containers ativos")
        fi
    fi
    
    # Verificar Nginx
    if systemctl is-active nginx &> /dev/null; then
        existing_services+=("Nginx")
    fi
    
    if [[ ${#existing_services[@]} -gt 0 ]]; then
        warning "Serviços existentes detectados: ${existing_services[*]}"
        echo -e "${YELLOW}O MarceloSetup irá integrar com os serviços existentes quando possível.${NC}"
        echo -e "${YELLOW}Pressione ENTER para continuar ou Ctrl+C para cancelar...${NC}"
        read -r
    fi
    
    success "Verificação de instalações concluída"
}

# ===================================================================
# FUNÇÕES DE CONFIGURAÇÃO
# ===================================================================

# Configurar domínio
configure_domain() {
    progress "Configurando domínio principal"
    
    if [[ -z "$DEFAULT_DOMAIN" ]]; then
        echo ""
        echo -e "${CYAN}╔═══════════════════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}║${YELLOW}               CONFIGURAÇÃO DE DOMÍNIO                    ${CYAN}║${NC}"
        echo -e "${CYAN}╚═══════════════════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "${WHITE}Para usar o MarceloSetup, você precisa de um domínio configurado.${NC}"
        echo -e "${WHITE}Exemplo: meusite.com.br${NC}"
        echo ""
        
        while true; do
            read -p "$(echo -e ${BLUE}Digite seu domínio principal: ${NC})" DEFAULT_DOMAIN
            
            if [[ -z "$DEFAULT_DOMAIN" ]]; then
                warning "Domínio não pode ser vazio"
                continue
            fi
            
            # Validação básica do domínio
            if [[ ! "$DEFAULT_DOMAIN" =~ ^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]\.[a-zA-Z]{2,}$ ]] && [[ ! "$DEFAULT_DOMAIN" =~ ^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]\.[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]\.[a-zA-Z]{2,}$ ]]; then
                warning "Formato de domínio inválido. Use: exemplo.com ou exemplo.com.br"
                continue
            fi
            
            break
        done
    fi
    
    # Configurar email se não informado
    if [[ -z "$DEFAULT_EMAIL" ]]; then
        while true; do
            read -p "$(echo -e ${BLUE}Digite seu email para SSL: ${NC})" DEFAULT_EMAIL
            
            if [[ -z "$DEFAULT_EMAIL" ]]; then
                DEFAULT_EMAIL="admin@${DEFAULT_DOMAIN}"
                break
            fi
            
            # Validação básica do email
            if [[ ! "$DEFAULT_EMAIL" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
                warning "Formato de email inválido"
                continue
            fi
            
            break
        done
    fi
    
    success "Domínio configurado: $DEFAULT_DOMAIN"
    success "Email configurado: $DEFAULT_EMAIL"
}

# ===================================================================
# FUNÇÕES DE INSTALAÇÃO
# ===================================================================

# Atualizar sistema
update_system() {
    progress "Atualizando sistema operacional"
    
    export DEBIAN_FRONTEND=noninteractive
    
    $PACKAGE_MANAGER update -y >> "$LOG_FILE" 2>&1
    $PACKAGE_MANAGER upgrade -y >> "$LOG_FILE" 2>&1
    
    # Instalar dependências essenciais
    progress "Instalando dependências essenciais"
    $PACKAGE_MANAGER install -y \
        curl wget git unzip software-properties-common \
        apt-transport-https ca-certificates gnupg lsb-release \
        htop nano vim ufw fail2ban \
        bc jq >> "$LOG_FILE" 2>&1
    
    success "Sistema atualizado e dependências instaladas"
}

# Instalar Docker
install_docker() {
    progress "Verificando Docker"
    
    if command -v docker &> /dev/null; then
        local docker_version=$(docker --version | grep -oP '\d+\.\d+\.\d+')
        success "Docker já instalado: v$docker_version"
        return
    fi
    
    progress "Instalando Docker"
    
    # Remover versões antigas
    $PACKAGE_MANAGER remove -y docker docker-engine docker.io containerd runc &> /dev/null || true
    
    # Adicionar repositório oficial Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    # Instalar Docker
    $PACKAGE_MANAGER update -y >> "$LOG_FILE" 2>&1
    $PACKAGE_MANAGER install -y docker-ce docker-ce-cli containerd.io >> "$LOG_FILE" 2>&1
    
    # Configurar Docker
    systemctl enable docker >> "$LOG_FILE" 2>&1
    systemctl start docker >> "$LOG_FILE" 2>&1
    
    # Adicionar usuário ao grupo docker se não for root
    if [[ -n "$SUDO_USER" ]]; then
        usermod -aG docker "$SUDO_USER" >> "$LOG_FILE" 2>&1
    fi
    
    success "Docker instalado e configurado"
}

# Instalar Docker Compose
install_docker_compose() {
    progress "Verificando Docker Compose"
    
    if command -v docker-compose &> /dev/null; then
        local compose_version=$(docker-compose --version | grep -oP '\d+\.\d+\.\d+')
        success "Docker Compose já instalado: v$compose_version"
        return
    fi
    
    progress "Instalando Docker Compose"
    
    # Obter última versão
    local compose_version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)
    
    # Download e instalação
    curl -L "https://github.com/docker/compose/releases/download/${compose_version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose >> "$LOG_FILE" 2>&1
    chmod +x /usr/local/bin/docker-compose
    
    # Criar link simbólico
    ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose
    
    success "Docker Compose instalado: $compose_version"
}

# Configurar firewall
setup_firewall() {
    progress "Configurando firewall"
    
    # Configurar UFW
    ufw --force reset >> "$LOG_FILE" 2>&1
    ufw default deny incoming >> "$LOG_FILE" 2>&1
    ufw default allow outgoing >> "$LOG_FILE" 2>&1
    
    # Portas essenciais
    ufw allow ssh >> "$LOG_FILE" 2>&1
    ufw allow 80/tcp >> "$LOG_FILE" 2>&1
    ufw allow 443/tcp >> "$LOG_FILE" 2>&1
    
    # Ativar firewall
    ufw --force enable >> "$LOG_FILE" 2>&1
    
    # Configurar fail2ban
    progress "Configurando proteção contra ataques"
    
    cat > /etc/fail2ban/jail.local << 'EOF'
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 5

[sshd]
enabled = true
port = ssh
logpath = /var/log/auth.log
maxretry = 3
bantime = 1800
EOF
    
    systemctl enable fail2ban >> "$LOG_FILE" 2>&1
    systemctl restart fail2ban >> "$LOG_FILE" 2>&1
    
    success "Firewall e proteção configurados"
}

# Criar estrutura de diretórios
create_directory_structure() {
    progress "Criando estrutura de diretórios"
    
    # Diretórios principais
    mkdir -p "$INSTALL_DIR"/{configs,data,logs,backups,scripts}
    mkdir -p "$INSTALL_DIR"/data/{postgres,redis,evolution,typebot,n8n,portainer,grafana,chatwoot,minio,traefik}
    mkdir -p "$INSTALL_DIR"/configs/{nginx,traefik,ssl}
    
    # Permissões
    chmod -R 755 "$INSTALL_DIR"
    
    success "Estrutura de diretórios criada em $INSTALL_DIR"
}

# Gerar senhas e chaves seguras
generate_credentials() {
    progress "Gerando credenciais seguras"
    
    # Função para gerar senha segura
    generate_password() {
        openssl rand -base64 32 | tr -d "=+/" | cut -c1-25
    }
    
    # Gerar todas as credenciais
    DB_PASSWORD=$(generate_password)
    DB_ROOT_PASSWORD=$(generate_password)
    REDIS_PASSWORD=$(generate_password)
    N8N_ENCRYPTION_KEY=$(generate_password)
    EVOLUTION_API_KEY=$(generate_password)
    GRAFANA_ADMIN_PASSWORD=$(generate_password)
    PORTAINER_PASSWORD=$(generate_password)
    CHATWOOT_SECRET=$(generate_password)
    MINIO_ROOT_USER="admin"
    MINIO_ROOT_PASSWORD=$(generate_password)
    
    # Salvar credenciais
    cat > "$INSTALL_DIR/configs/credentials.env" << EOF
# MarceloSetup v${SCRIPT_VERSION} - Credenciais Geradas em $(date)
# MANTENHA ESTE ARQUIVO SEGURO E PRIVADO!

# Configurações gerais
DOMAIN=${DEFAULT_DOMAIN}
EMAIL=${DEFAULT_EMAIL}
COMPOSE_PROJECT_NAME=${COMPOSE_PROJECT_NAME}

# Banco de dados
DB_PASSWORD=${DB_PASSWORD}
DB_ROOT_PASSWORD=${DB_ROOT_PASSWORD}

# Cache
REDIS_PASSWORD=${REDIS_PASSWORD}

# Automação
N8N_ENCRYPTION_KEY=${N8N_ENCRYPTION_KEY}
EVOLUTION_API_KEY=${EVOLUTION_API_KEY}

# Monitoramento
GRAFANA_ADMIN_PASSWORD=${GRAFANA_ADMIN_PASSWORD}

# Gestão
PORTAINER_PASSWORD=${PORTAINER_PASSWORD}

# Atendimento
CHATWOOT_SECRET=${CHATWOOT_SECRET}

# Storage
MINIO_ROOT_USER=${MINIO_ROOT_USER}
MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD}
EOF
    
    # Proteger arquivo de credenciais
    chmod 600 "$INSTALL_DIR/configs/credentials.env"
    
    success "Credenciais seguras geradas e salvas"
}

# Criar configuração Docker Compose
create_docker_compose() {
    progress "Criando configuração Docker Compose"
    
    cat > "$INSTALL_DIR/docker-compose.yml" << EOF
version: '3.8'

# ===================================================================
# MARCELOSETUP v${SCRIPT_VERSION} - Docker Compose Configuration
# Powered by @marceloagentedigital
# Generated on $(date)
# ===================================================================

networks:
  marcelonet:
    driver: bridge
  web:
    external: true

volumes:
  postgres_data:
    name: \${COMPOSE_PROJECT_NAME}_postgres_data
  redis_data:
    name: \${COMPOSE_PROJECT_NAME}_redis_data
  evolution_data:
    name: \${COMPOSE_PROJECT_NAME}_evolution_data
  typebot_data:
    name: \${COMPOSE_PROJECT_NAME}_typebot_data
  n8n_data:
    name: \${COMPOSE_PROJECT_NAME}_n8n_data
  portainer_data:
    name: \${COMPOSE_PROJECT_NAME}_portainer_data
  grafana_data:
    name: \${COMPOSE_PROJECT_NAME}_grafana_data
  chatwoot_data:
    name: \${COMPOSE_PROJECT_NAME}_chatwoot_data
  minio_data:
    name: \${COMPOSE_PROJECT_NAME}_minio_data
  traefik_data:
    name: \${COMPOSE_PROJECT_NAME}_traefik_data

services:
  # ===============================================================
  # REVERSE PROXY - TRAEFIK
  # ===============================================================
  traefik:
    image: traefik:v2.10
    container_name: \${COMPOSE_PROJECT_NAME}_traefik
    restart: unless-stopped
    command:
      - "--api.dashboard=true"
      - "--providers.docker=true"
      - "--providers.docker.exposedbydefault=false"
      - "--entrypoints.web.address=:80"
      - "--entrypoints.websecure.address=:443"
      - "--certificatesresolvers.letsencrypt.acme.email=\${EMAIL}"
      - "--certificatesresolvers.letsencrypt.acme.storage=/certificates/acme.json"
      - "--certificatesresolvers.letsencrypt.acme.httpchallenge=true"
      - "--certificatesresolvers.letsencrypt.acme.httpchallenge.entrypoint=web"
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - traefik_data:/certificates
    networks:
      - web
      - marcelonet
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.traefik.rule=Host(\`admin.\${DOMAIN}\`)"
      - "traefik.http.routers.traefik.entrypoints=websecure"
      - "traefik.http.routers.traefik.tls.certresolver=letsencrypt"
      - "traefik.http.routers.traefik.service=api@internal"
      - "traefik.http.middlewares.auth.basicauth.users=admin:\$\$2y\$\$10\$\$9K.H2XVPxvh6j1V8F5oJo.YhV8qAVm7jm7wqD6PXk7DlQ0e"

  # ===============================================================
  # BANCO DE DADOS - POSTGRESQL
  # ===============================================================
  postgres:
    image: postgres:15-alpine
    container_name: \${COMPOSE_PROJECT_NAME}_postgres
    restart: unless-stopped
    environment:
      POSTGRES_DB: marcelosetup
      POSTGRES_USER: marcelosetup
      POSTGRES_PASSWORD: \${DB_PASSWORD}
      POSTGRES_ROOT_PASSWORD: \${DB_ROOT_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./data/postgres:/backup
    networks:
      - marcelonet
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U marcelosetup"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 60s

  # ===============================================================
  # CACHE - REDIS
  # ===============================================================
  redis:
    image: redis:7-alpine
    container_name: \${COMPOSE_PROJECT_NAME}_redis
    restart: unless-stopped
    command: redis-server --requirepass \${REDIS_PASSWORD} --appendonly yes
    volumes:
      - redis_data:/data
    networks:
      - marcelonet
    healthcheck:
      test: ["CMD", "redis-cli", "auth", "\${REDIS_PASSWORD}", "ping"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 30s

  # ===============================================================
  # WHATSAPP API - EVOLUTION
  # ===============================================================
  evolution:
    image: atendai/evolution-api:latest
    container_name: \${COMPOSE_PROJECT_NAME}_evolution
    restart: unless-stopped
    environment:
      - DATABASE_PROVIDER=postgresql
      - DATABASE_CONNECTION_URI=postgresql://marcelosetup:\${DB_PASSWORD}@postgres:5432/marcelosetup?schema=evolution
      - REDIS_URI=redis://:\${REDIS_PASSWORD}@redis:6379
      - AUTHENTICATION_API_KEY=\${EVOLUTION_API_KEY}
      - SERVER_TYPE=https
      - SERVER_URL=https://api.\${DOMAIN}
      - CORS_ORIGIN=*
      - CORS_METHODS=GET,POST,PUT,DELETE,OPTIONS
      - DEL_INSTANCE=false
      - INSTANCE_EXPIRE_TIME=false
      - CONFIG_SESSION_PHONE_CLIENT=MarceloSetup
      - CONFIG_SESSION_PHONE_NAME=MarceloAutomacao
    volumes:
      - evolution_data:/evolution/instances
    networks:
      - marcelonet
      - web
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_healthy
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.evolution.rule=Host(\`api.\${DOMAIN}\`)"
      - "traefik.http.routers.evolution.entrypoints=websecure"
      - "traefik.http.routers.evolution.tls.certresolver=letsencrypt"
      - "traefik.http.services.evolution.loadbalancer.server.port=8080"

  # ===============================================================
  # CHATBOT BUILDER - TYPEBOT
  # ===============================================================
  typebot-builder:
    image: baptistearno/typebot-builder:latest
    container_name: \${COMPOSE_PROJECT_NAME}_typebot_builder
    restart: unless-stopped
    environment:
      - DATABASE_URL=postgresql://marcelosetup:\${DB_PASSWORD}@postgres:5432/marcelosetup?schema=typebot
      - NEXTAUTH_URL=https://bot.\${DOMAIN}
      - NEXTAUTH_SECRET=\${N8N_ENCRYPTION_KEY}
      - ENCRYPTION_SECRET=\${N8N_ENCRYPTION_KEY}
      - ADMIN_EMAIL=\${EMAIL}
      - S3_ACCESS_KEY=\${MINIO_ROOT_USER}
      - S3_SECRET_KEY=\${MINIO_ROOT_PASSWORD}
      - S3_BUCKET=typebot
      - S3_ENDPOINT=http://minio:9000
    networks:
      - marcelonet
      - web
    depends_on:
      postgres:
        condition: service_healthy
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.typebot.rule=Host(\`bot.\${DOMAIN}\`)"
      - "traefik.http.routers.typebot.entrypoints=websecure"
      - "traefik.http.routers.typebot.tls.certresolver=letsencrypt"
      - "traefik.http.services.typebot.loadbalancer.server.port=3000"

  typebot-viewer:
    image: baptistearno/typebot-viewer:latest
    container_name: \${COMPOSE_PROJECT_NAME}_typebot_viewer
    restart: unless-stopped
    environment:
      - DATABASE_URL=postgresql://marcelosetup:\${DB_PASSWORD}@postgres:5432/marcelosetup?schema=typebot
      - NEXTAUTH_URL=https://bot.\${DOMAIN}
      - NEXTAUTH_SECRET=\${N8N_ENCRYPTION_KEY}
      - ENCRYPTION_SECRET=\${N8N_ENCRYPTION_KEY}
      - S3_ACCESS_KEY=\${MINIO_ROOT_USER}
      - S3_SECRET_KEY=\${MINIO_ROOT_PASSWORD}
      - S3_BUCKET=typebot
      - S3_ENDPOINT=http://minio:9000
    networks:
      - marcelonet
      - web
    depends_on:
      postgres:
        condition: service_healthy
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.typebot-viewer.rule=Host(\`chat.\${DOMAIN}\`)"
      - "traefik.http.routers.typebot-viewer.entrypoints=websecure"
      - "traefik.http.routers.typebot-viewer.tls.certresolver=letsencrypt"
      - "traefik.http.services.typebot-viewer.loadbalancer.server.port=3000"

  # ===============================================================
  # WORKFLOW AUTOMATION - N8N
  # ===============================================================
  n8n:
    image: n8nio/n8n:latest
    container_name: \${COMPOSE_PROJECT_NAME}_n8n
    restart: unless-stopped
    environment:
      - DB_TYPE=postgresdb
      - DB_POSTGRESDB_HOST=postgres
      - DB_POSTGRESDB_PORT=5432
      - DB_POSTGRESDB_DATABASE=marcelosetup
      - DB_POSTGRESDB_USER=marcelosetup
      - DB_POSTGRESDB_PASSWORD=\${DB_PASSWORD}
      - DB_POSTGRESDB_SCHEMA=n8n
      - N8N_ENCRYPTION_KEY=\${N8N_ENCRYPTION_KEY}
      - WEBHOOK_URL=https://n8n.\${DOMAIN}
      - GENERIC_TIMEZONE=America/Sao_Paulo
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=\${DB_PASSWORD}
    volumes:
      - n8n_data:/home/node/.n8n
    networks:
      - marcelonet
      - web
    depends_on:
      postgres:
        condition: service_healthy
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.n8n.rule=Host(\`n8n.\${DOMAIN}\`)"
      - "traefik.http.routers.n8n.entrypoints=websecure"
      - "traefik.http.routers.n8n.tls.certresolver=letsencrypt"
      - "traefik.http.services.n8n.loadbalancer.server.port=5678"

  # ===============================================================
  # CUSTOMER SUPPORT - CHATWOOT
  # ===============================================================
  chatwoot-web:
    image: chatwoot/chatwoot:latest
    container_name: \${COMPOSE_PROJECT_NAME}_chatwoot_web
    restart: unless-stopped
    environment:
      - RAILS_ENV=production
      - SECRET_KEY_BASE=\${CHATWOOT_SECRET}
      - POSTGRES_HOST=postgres
      - POSTGRES_USERNAME=marcelosetup
      - POSTGRES_PASSWORD=\${DB_PASSWORD}
      - POSTGRES_DATABASE=marcelosetup
      - REDIS_URL=redis://:\${REDIS_PASSWORD}@redis:6379
      - FRONTEND_URL=https://chat.\${DOMAIN}
      - MAILER_SENDER_EMAIL=\${EMAIL}
      - SMTP_DOMAIN=\${DOMAIN}
      - ACTIVE_STORAGE_SERVICE=local
    volumes:
      - chatwoot_data:/app/storage
    networks:
      - marcelonet
      - web
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_healthy
    command: ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.chatwoot.rule=Host(\`support.\${DOMAIN}\`)"
      - "traefik.http.routers.chatwoot.entrypoints=websecure"
      - "traefik.http.routers.chatwoot.tls.certresolver=letsencrypt"
      - "traefik.http.services.chatwoot.loadbalancer.server.port=3000"

  chatwoot-worker:
    image: chatwoot/chatwoot:latest
    container_name: \${COMPOSE_PROJECT_NAME}_chatwoot_worker
    restart: unless-stopped
    environment:
      - RAILS_ENV=production
      - SECRET_KEY_BASE=\${CHATWOOT_SECRET}
      - POSTGRES_HOST=postgres
      - POSTGRES_USERNAME=marcelosetup
      - POSTGRES_PASSWORD=\${DB_PASSWORD}
      - POSTGRES_DATABASE=marcelosetup
      - REDIS_URL=redis://:\${REDIS_PASSWORD}@redis:6379
    volumes:
      - chatwoot_data:/app/storage
    networks:
      - marcelonet
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_healthy
    command: ["bundle", "exec", "sidekiq", "-C", "config/schedule.yml"]

  # ===============================================================
  # DOCKER MANAGEMENT - PORTAINER
  # ===============================================================
  portainer:
    image: portainer/portainer-ce:latest
    container_name: \${COMPOSE_PROJECT_NAME}_portainer
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data
    networks:
      - marcelonet
      - web
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.portainer.rule=Host(\`docker.\${DOMAIN}\`)"
      - "traefik.http.routers.portainer.entrypoints=websecure"
      - "traefik.http.routers.portainer.tls.certresolver=letsencrypt"
      - "traefik.http.services.portainer.loadbalancer.server.port=9000"

  # ===============================================================
  # FILE STORAGE - MINIO
  # ===============================================================
  minio:
    image: minio/minio:latest
    container_name: \${COMPOSE_PROJECT_NAME}_minio
    restart: unless-stopped
    environment:
      - MINIO_ROOT_USER=\${MINIO_ROOT_USER}
      - MINIO_ROOT_PASSWORD=\${MINIO_ROOT_PASSWORD}
      - MINIO_CONSOLE_ADDRESS=:9001
    volumes:
      - minio_data:/data
    networks:
      - marcelonet
      - web
    command: server /data
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.minio.rule=Host(\`storage.\${DOMAIN}\`)"
      - "traefik.http.routers.minio.entrypoints=websecure"
      - "traefik.http.routers.minio.tls.certresolver=letsencrypt"
      - "traefik.http.services.minio.loadbalancer.server.port=9001"

  # ===============================================================
  # MONITORING - GRAFANA
  # ===============================================================
  grafana:
    image: grafana/grafana:latest
    container_name: \${COMPOSE_PROJECT_NAME}_grafana
    restart: unless-stopped
    environment:
      - GF_SECURITY_ADMIN_USER=admin
      - GF_SECURITY_ADMIN_PASSWORD=\${GRAFANA_ADMIN_PASSWORD}
      - GF_USERS_ALLOW_SIGN_UP=false
      - GF_SERVER_DOMAIN=monitor.\${DOMAIN}
      - GF_SERVER_ROOT_URL=https://monitor.\${DOMAIN}
    volumes:
      - grafana_data:/var/lib/grafana
    networks:
      - marcelonet
      - web
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.grafana.rule=Host(\`monitor.\${DOMAIN}\`)"
      - "traefik.http.routers.grafana.entrypoints=websecure"
      - "traefik.http.routers.grafana.tls.certresolver=letsencrypt"
      - "traefik.http.services.grafana.loadbalancer.server.port=3000"

EOF

    success "Configuração Docker Compose criada"
}

# Criar rede externa
create_external_network() {
    progress "Criando rede externa"
    
    if ! docker network ls | grep -q "web"; then
        docker network create web >> "$LOG_FILE" 2>&1
        success "Rede 'web' criada"
    else
        success "Rede 'web' já existe"
    fi
}

# Inicializar serviços
start_services() {
    progress "Iniciando serviços"
    
    cd "$INSTALL_DIR"
    
    # Carregar variáveis de ambiente
    set -a
    source "$INSTALL_DIR/configs/credentials.env"
    set +a
    
    # Iniciar containers
    docker-compose up -d >> "$LOG_FILE" 2>&1
    
    success "Todos os serviços foram iniciados"
}

# Aguardar serviços ficarem prontos
wait_for_services() {
    progress "Aguardando serviços estabilizarem"
    
    local max_attempts=30
    local attempt=0
    
    while [[ $attempt -lt $max_attempts ]]; do
        local ready_count=0
        local total_services=5
        
        # Verificar PostgreSQL
        if docker exec "${COMPOSE_PROJECT_NAME}_postgres" pg_isready -U marcelosetup &> /dev/null; then
            ready_count=$((ready_count + 1))
        fi
        
        # Verificar Redis
        if docker exec "${COMPOSE_PROJECT_NAME}_redis" redis-cli auth "$REDIS_PASSWORD" ping | grep -q "PONG" &> /dev/null; then
            ready_count=$((ready_count + 1))
        fi
        
        # Verificar Traefik
        if curl -s http://localhost:8080/ping | grep -q "OK" &> /dev/null; then
            ready_count=$((ready_count + 1))
        fi
        
        # Verificar Evolution
        if curl -s http://localhost:8080 &> /dev/null; then
            ready_count=$((ready_count + 1))
        fi
        
        # Verificar n8n
        if curl -s http://localhost:5678 &> /dev/null; then
            ready_count=$((ready_count + 1))
        fi
        
        if [[ $ready_count -eq $total_services ]]; then
            break
        fi
        
        attempt=$((attempt + 1))
        sleep 10
    done
    
    if [[ $attempt -eq $max_attempts ]]; then
        warning "Alguns serviços podem ainda estar inicializando"
    else
        success "Todos os serviços estão prontos"
    fi
}

# Criar script de backup
create_backup_script() {
    progress "Configurando backup automático"
    
    cat > "$INSTALL_DIR/scripts/backup.sh" << 'EOF'
#!/bin/bash
# MarceloSetup - Script de Backup Automático

BACKUP_DIR="/opt/marcelosetup/backups"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="marcelosetup_backup_${DATE}"

# Criar diretório de backup
mkdir -p "${BACKUP_DIR}/${BACKUP_NAME}"

echo "Iniciando backup: ${BACKUP_NAME}"

# Backup do banco de dados
docker exec marcelosetup_postgres pg_dumpall -U marcelosetup > "${BACKUP_DIR}/${BACKUP_NAME}/postgres_dump.sql"

# Backup dos volumes Docker
docker run --rm -v marcelosetup_evolution_data:/data -v "${BACKUP_DIR}/${BACKUP_NAME}":/backup alpine tar czf /backup/evolution_data.tar.gz -C /data .
docker run --rm -v marcelosetup_typebot_data:/data -v "${BACKUP_DIR}/${BACKUP_NAME}":/backup alpine tar czf /backup/typebot_data.tar.gz -C /data .
docker run --rm -v marcelosetup_n8n_data:/data -v "${BACKUP_DIR}/${BACKUP_NAME}":/backup alpine tar czf /backup/n8n_data.tar.gz -C /data .
docker run --rm -v marcelosetup_chatwoot_data:/data -v "${BACKUP_DIR}/${BACKUP_NAME}":/backup alpine tar czf /backup/chatwoot_data.tar.gz -C /data .
docker run --rm -v marcelosetup_grafana_data:/data -v "${BACKUP_DIR}/${BACKUP_NAME}":/backup alpine tar czf /backup/grafana_data.tar.gz -C /data .

# Backup das configurações
cp -r /opt/marcelosetup/configs "${BACKUP_DIR}/${BACKUP_NAME}/"
cp /opt/marcelosetup/docker-compose.yml "${BACKUP_DIR}/${BACKUP_NAME}/"

# Compactar backup final
tar czf "${BACKUP_DIR}/${BACKUP_NAME}.tar.gz" -C "${BACKUP_DIR}" "${BACKUP_NAME}"
rm -rf "${BACKUP_DIR}/${BACKUP_NAME}"

# Limpar backups antigos (manter apenas os 7 mais recentes)
find "${BACKUP_DIR}" -name "marcelosetup_backup_*.tar.gz" -mtime +7 -delete

echo "Backup concluído: ${BACKUP_DIR}/${BACKUP_NAME}.tar.gz"
EOF

    chmod +x "$INSTALL_DIR/scripts/backup.sh"
    
    # Agendar backup diário às 3h da manhã
    (crontab -l 2>/dev/null; echo "0 3 * * * $INSTALL_DIR/scripts/backup.sh >> /var/log/marcelosetup-backup.log 2>&1") | crontab -
    
    success "Backup automático configurado (diário às 3h)"
}

# Criar script de gerenciamento
create_management_script() {
    progress "Criando script de gerenciamento"
    
    cat > "/usr/local/bin/marcelosetup" << 'EOF'
#!/bin/bash
# MarceloSetup - Script de Gerenciamento

INSTALL_DIR="/opt/marcelosetup"
COMPOSE_FILE="$INSTALL_DIR/docker-compose.yml"

case "$1" in
    start)
        echo "Iniciando MarceloSetup..."
        cd "$INSTALL_DIR" && docker-compose up -d
        echo "Serviços iniciados!"
        ;;
    stop)
        echo "Parando MarceloSetup..."
        cd "$INSTALL_DIR" && docker-compose down
        echo "Serviços parados!"
        ;;
    restart)
        echo "Reiniciando MarceloSetup..."
        cd "$INSTALL_DIR" && docker-compose restart
        echo "Serviços reiniciados!"
        ;;
    status)
        echo "Status dos serviços:"
        cd "$INSTALL_DIR" && docker-compose ps
        ;;
    logs)
        echo "Logs dos serviços:"
        cd "$INSTALL_DIR" && docker-compose logs -f
        ;;
    backup)
        echo "Executando backup..."
        "$INSTALL_DIR/scripts/backup.sh"
        ;;
    update)
        echo "Atualizando imagens..."
        cd "$INSTALL_DIR" && docker-compose pull && docker-compose up -d
        echo "Atualização concluída!"
        ;;
    credentials)
        echo "Credenciais do sistema:"
        cat "$INSTALL_DIR/configs/credentials.env"
        ;;
    *)
        echo "MarceloSetup v2.0 - Gerenciamento"
        echo ""
        echo "Uso: marcelosetup [comando]"
        echo ""
        echo "Comandos disponíveis:"
        echo "  start        - Iniciar todos os serviços"
        echo "  stop         - Parar todos os serviços"
        echo "  restart      - Reiniciar todos os serviços"
        echo "  status       - Verificar status dos serviços"
        echo "  logs         - Visualizar logs em tempo real"
        echo "  backup       - Executar backup manual"
        echo "  update       - Atualizar todas as imagens"
        echo "  credentials  - Mostrar credenciais do sistema"
        echo ""
        ;;
esac
EOF

    chmod +x "/usr/local/bin/marcelosetup"
    
    success "Script de gerenciamento criado: marcelosetup [comando]"
}

# ===================================================================
# FUNÇÃO PRINCIPAL E FLUXO DE INSTALAÇÃO
# ===================================================================

# Função principal de instalação
main_installation() {
    # Verificações iniciais
    check_root
    check_system
    check_resources
    check_internet
    detect_existing_installations
    
    # Configuração
    configure_domain
    
    # Instalação da infraestrutura
    update_system
    install_docker
    install_docker_compose
    setup_firewall
    
    # Preparação do ambiente
    create_directory_structure
    generate_credentials
    create_docker_compose
    create_external_network
    
    # Inicialização dos serviços
    start_services
    wait_for_services
    
    # Configurações finais
    create_backup_script
    create_management_script
    
    progress "Finalizando instalação"
}

# Mostrar informações finais
show_final_information() {
    show_completion_banner
    
    # Carregar credenciais para exibição
    source "$INSTALL_DIR/configs/credentials.env"
    
    echo -e "${BLUE}🌐 URLs dos Serviços:${NC}"
    echo -e "   • Evolution API (WhatsApp): ${GREEN}https://api.${DEFAULT_DOMAIN}${NC}"
    echo -e "   • Typebot (Chatbots):       ${GREEN}https://bot.${DEFAULT_DOMAIN}${NC}"
    echo -e "   • Typebot Viewer:           ${GREEN}https://chat.${DEFAULT_DOMAIN}${NC}"
    echo -e "   • n8n (Automação):          ${GREEN}https://n8n.${DEFAULT_DOMAIN}${NC}"
    echo -e "   • Chatwoot (Atendimento):   ${GREEN}https://support.${DEFAULT_DOMAIN}${NC}"
    echo -e "   • Portainer (Docker):       ${GREEN}https://docker.${DEFAULT_DOMAIN}${NC}"
    echo -e "   • MinIO (Storage):          ${GREEN}https://storage.${DEFAULT_DOMAIN}${NC}"
    echo -e "   • Grafana (Monitor):        ${GREEN}https://monitor.${DEFAULT_DOMAIN}${NC}"
    echo -e "   • Traefik (Proxy):          ${GREEN}https://admin.${DEFAULT_DOMAIN}${NC}"
    echo ""
    
    echo -e "${YELLOW}🔑 Credenciais Importantes:${NC}"
    echo -e "   • Evolution API Key:        ${WHITE}${EVOLUTION_API_KEY}${NC}"
    echo -e "   • Grafana Admin:            ${WHITE}admin / ${GRAFANA_ADMIN_PASSWORD}${NC}"
    echo -e "   • n8n Login:                ${WHITE}admin / ${DB_PASSWORD}${NC}"
    echo -e "   • MinIO Admin:              ${WHITE}${MINIO_ROOT_USER} / ${MINIO_ROOT_PASSWORD}${NC}"
    echo ""
    
    echo -e "${CYAN}📋 Comandos Úteis:${NC}"
    echo -e "   • Ver status:               ${WHITE}marcelosetup status${NC}"
    echo -e "   • Ver logs:                 ${WHITE}marcelosetup logs${NC}"
    echo -e "   • Fazer backup:             ${WHITE}marcelosetup backup${NC}"
    echo -e "   • Reiniciar:                ${WHITE}marcelosetup restart${NC}"
    echo -e "   • Ver credenciais:          ${WHITE}marcelosetup credentials${NC}"
    echo ""
    
    echo -e "${GREEN}✅ Próximos Passos:${NC}"
    echo -e "   1. Configure DNS: Aponte os subdomínios para este servidor"
    echo -e "   2. Acesse Portainer para gerenciar containers"
    echo -e "   3. Configure Evolution API com WhatsApp Business"
    echo -e "   4. Crie seus primeiros chatbots no Typebot"
    echo -e "   5. Configure automações no n8n"
    echo ""
    
    echo -e "${BLUE}📧 Suporte:${NC} ${DEFAULT_EMAIL}"
    echo -e "${BLUE}🔗 Powered by:${NC} ${SCRIPT_AUTHOR}"
    echo -e "${BLUE}🌐 Website:${NC} ${SCRIPT_URL}"
    echo -e "${BLUE}📱 GitHub:${NC} ${SCRIPT_REPO}"
    echo ""
    
    echo -e "${MAGENTA}${FIRE} MarceloSetup v${SCRIPT_VERSION} instalado com sucesso! ${FIRE}${NC}"
    echo ""
    
    # Log final
    log "MarceloSetup v${SCRIPT_VERSION} installation completed successfully"
    log "Domain: ${DEFAULT_DOMAIN}"
    log "Email: ${DEFAULT_EMAIL}"
    log "Installation directory: ${INSTALL_DIR}"
    log "Services started and ready"
}

# ===================================================================
# EXECUÇÃO PRINCIPAL
# ===================================================================

# Verificar argumentos de linha de comando
while [[ $# -gt 0 ]]; do
    case $1 in
        --domain=*)
            DEFAULT_DOMAIN="${1#*=}"
            shift
            ;;
        --email=*)
            DEFAULT_EMAIL="${1#*=}"
            shift
            ;;
        --mode=*)
            INSTALL_MODE="${1#*=}"
            shift
            ;;
        --help)
            echo "MarceloSetup v${SCRIPT_VERSION} - All-in-One Marketing Automation"
            echo ""
            echo "Uso: $0 [opções]"
            echo ""
            echo "Opções:"
            echo "  --domain=exemplo.com     Especificar domínio principal"
            echo "  --email=admin@exemplo.com Especificar email para SSL"
            echo "  --mode=complete          Modo de instalação (padrão: complete)"
            echo "  --help                   Mostrar esta ajuda"
            echo ""
            echo "Exemplo:"
            echo "  $0 --domain=meusite.com.br --email=admin@meusite.com.br"
            echo ""
            exit 0
            ;;
        *)
            warning "Argumento desconhecido: $1"
            shift
            ;;
    esac
done

# Inicializar log
echo "MarceloSetup v${SCRIPT_VERSION} installation started at $(date)" > "$LOG_FILE"

# Mostrar banner inicial
show_banner

# Executar instalação principal
main_installation

# Mostrar informações finais
show_final_information

# Fim do script
exit 0
