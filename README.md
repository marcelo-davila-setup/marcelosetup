# MaceloSetup v1.0 - Guia de Instalação

## 🚀 Instalação Rápida

### Comando One-Line (Recomendado)
```bash
curl -sSL https://raw.githubusercontent.com/marceloagentedigital/macelosetup/main/macelosetup.sh | bash
```

### Instalação Manual
```bash
# 1. Download do script
wget https://raw.githubusercontent.com/marceloagentedigital/macelosetup/main/macelosetup.sh

# 2. Dar permissão de execução
chmod +x macelosetup.sh

# 3. Executar como root
sudo ./macelosetup.sh
```

## 🛠️ Modos de Instalação

### 1. Instalação Completa (Padrão)
```bash
sudo ./macelosetup.sh --mode=full
```
**Inclui:** Docker, Nginx, SSL, Evolution API, Typebot, n8n, Portainer, Grafana, PostgreSQL, Redis, Backup automático

### 2. Instalação Básica
```bash
sudo ./macelosetup.sh --mode=basic
```
**Inclui:** Docker, Nginx, SSL, Firewall

### 3. Apenas Marketing
```bash
sudo ./macelosetup.sh --mode=marketing
```
**Inclui:** Modo básico + Evolution API, Typebot, n8n

### 4. Personalizada
```bash
sudo ./macelosetup.sh --mode=custom
```
**Permite:** Seleção individual de componentes

## 📋 Requisitos do Sistema

### Mínimos
- **SO:** Ubuntu 20.04+ ou Debian 11+
- **RAM:** 4GB
- **Disco:** 20GB SSD
- **CPU:** 2 cores
- **Acesso:** Root/sudo

### Recomendados
- **RAM:** 8GB
- **Disco:** 50GB SSD  
- **CPU:** 4 cores
- **Rede:** Banda larga estável

## 🌐 Domínios Configurados

Após a instalação, os seguintes subdomínios estarão disponíveis:

| Serviço | URL | Descrição |
|---------|-----|-----------|
| Evolution API | `https://api.marceloautomacoes.com.br` | API do WhatsApp Business |
| Typebot | `https://bot.marceloautomacoes.com.br` | Construtor de chatbots |
| n8n | `https://n8n.marceloautomacoes.com.br` | Automação de workflows |
| Portainer | `https://admin.marceloautomacoes.com.br` | Gerenciamento Docker |
| Grafana | `https://monitor.marceloautomacoes.com.br` | Monitoramento e dashboards |

## 🔐 Credenciais e Segurança

### Localização das Senhas
```bash
# Todas as senhas são salvas em:
/opt/macelosetup/configs/passwords.env

# Para visualizar:
sudo cat /opt/macelosetup/configs/passwords.env
```

### Senhas Geradas Automaticamente
- **PostgreSQL:** Senha aleatória de 25 caracteres
- **Redis:** Senha aleatória de 25 caracteres
- **Evolution API Key:** Chave aleatória de 25 caracteres
- **n8n Encryption Key:** Chave de criptografia
- **Grafana Admin:** Senha do usuário admin

### Recursos de Segurança
- ✅ Firewall configurado (UFW)
- ✅ SSL automático (Let's Encrypt)
- ✅ Headers de segurança (Nginx)
- ✅ Rate limiting por IP
- ✅ Senhas criptograficamente seguras
- ✅ Containers isolados em rede privada

## 📊 Monitoramento

### Verificar Status dos Serviços
```bash
# Status dos containers
sudo docker-compose -f /opt/macelosetup/docker-compose.yml ps

# Logs em tempo real
sudo docker-compose -f /opt/macelosetup/docker-compose.yml logs -f

# Logs de um serviço específico
sudo docker-compose -f /opt/macelosetup/docker-compose.yml logs -f evolution
```

### Recursos do Sistema
```bash
# Uso de CPU e memória
htop

# Uso de disco
df -h

# Status dos containers
docker stats
```

## 🔧 Comandos Úteis

### Gerenciar Serviços
```bash
# Parar todos os serviços
sudo docker-compose -f /opt/macelosetup/docker-compose.yml down

# Iniciar todos os serviços
sudo docker-compose -f /opt/macelosetup/docker-compose.yml up -d

# Reiniciar serviços
sudo docker-compose -f /opt/macelosetup/docker-compose.yml restart

# Reiniciar um serviço específico
sudo docker-compose -f /opt/macelosetup/docker-compose.yml restart evolution
```

### Backup e Restore
```bash
# Executar backup manual
sudo /opt/macelosetup/backup.sh

# Localizar backups
ls -la /opt/macelosetup/backups/

# Backup é executado automaticamente às 2h da manhã
```

### SSL e Certificados
```bash
# Renovar certificados SSL manualmente
sudo certbot renew

# Verificar status dos certificados
sudo certbot certificates

# Testar renovação automática
sudo certbot renew --dry-run
```

## 🚨 Troubleshooting

### Problemas Comuns

#### 1. Erro "Permission denied"
```bash
# Verificar se está executando como root
sudo su -
./macelosetup.sh
```

#### 2. Porta em uso
```bash
# Verificar portas ocupadas
sudo netstat -tlnp | grep :80
sudo netstat -tlnp | grep :443

# Parar serviço conflitante
sudo systemctl stop apache2  # Se Apache estiver instalado
```

#### 3. DNS não resolve
```bash
# Verificar se os domínios apontam para o servidor
nslookup api.marceloautomacoes.com.br
nslookup bot.marceloautomacoes.com.br

# Aguardar propagação DNS (até 24h)
```

#### 4. Container não inicia
```bash
# Verificar logs do container
sudo docker-compose -f /opt/macelosetup/docker-compose.yml logs evolution

# Verificar recursos do sistema
free -h
df -h
```

### Logs Importantes
```bash
# Logs do Nginx
sudo tail -f /var/log/nginx/error.log
sudo tail -f /var/log/nginx/access.log

# Logs do sistema
sudo journalctl -u docker.service -f
sudo journalctl -u nginx.service -f
```

## 📞 Suporte

### Contato
- **Email:** info@marceloautomacoes.com.br
- **Website:** https://marceloautomacoes.com.br
- **Instagram:** @marceloagentedigital

### Documentação Adicional
- [Evolution API Docs](https://doc.evolution-api.com/)
- [Typebot Docs](https://docs.typebot.io/)
- [n8n Docs](https://docs.n8n.io/)

### Suporte Premium
Para suporte 24/7, instalação personalizada ou consultoria:
- WhatsApp: [Link do WhatsApp Business]
- Calendário: [Link para agendamento]

---

**Powered by @marceloagentedigital**  
**MaceloSetup v1.0 - Automação de Marketing Profissional**
