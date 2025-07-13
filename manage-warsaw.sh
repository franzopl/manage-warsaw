#!/bin/bash

# Script para gerenciar o serviço Warsaw em diferentes distribuições Linux com mensagens coloridas

# Cores ANSI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Configurações padrão
DEFAULT_BROWSER="firefox"
SERVICE_NAME="warsaw"
INITD_PATH="/etc/init.d/warsaw"
BROWSER_URL=""
# Caminhos comuns onde o Warsaw pode estar instalado
WARSOW_PATHS=("/opt/warsaw" "/usr/lib/warsaw" "/usr/local/bin/warsaw")

# Função para detectar o gerenciador de serviços
detect_service_manager() {
    if command -v systemctl &> /dev/null; then
        SERVICE_MANAGER="systemd"
    elif [ -f "$INITD_PATH" ]; then
        SERVICE_MANAGER="initd"
    else
        echo -e "${RED}Erro: Nenhum gerenciador de serviços suportado (systemd ou init.d) encontrado.${NC}"
        exit 1
    fi
}

# Função para verificar se o Warsaw está instalado
check_warsaw_installed() {
    if [ "$SERVICE_MANAGER" = "systemd" ]; then
        if ! systemctl --quiet is-enabled "$SERVICE_NAME".service 2>/dev/null && ! systemctl --quiet is-active "$SERVICE_NAME".service 2>/dev/null; then
            echo -e "${RED}Erro: O serviço Warsaw ($SERVICE_NAME) não está instalado ou não foi encontrado.${NC}"
            exit 1
        fi
    elif [ "$SERVICE_MANAGER" = "initd" ]; then
        if [ ! -f "$INITD_PATH" ]; then
            echo -e "${RED}Erro: O script de inicialização do Warsaw ($INITD_PATH) não foi encontrado.${NC}"
            exit 1
        fi
    fi

    # Verifica se o binário do Warsaw existe em algum dos caminhos comuns
    warsaw_found=false
    for path in "${WARSOW_PATHS[@]}"; do
        if [ -d "$path" ] || [ -f "$path/core" ] || [ -f "$path/warsaw" ]; then
            warsaw_found=true
            break
        fi
    done
    if [ "$warsaw_found" = false ]; then
        echo -e "${RED}Erro: Nenhum binário do Warsaw encontrado nos caminhos comuns.${NC}"
        exit 1
    fi
}

# Função para ativar o serviço Warsaw
start_warsaw() {
    echo -e "${YELLOW}Ativando o serviço Warsaw...${NC}"
    if [ "$SERVICE_MANAGER" = "systemd" ]; then
        sudo systemctl start "$SERVICE_NAME".service
        if systemctl --quiet is-active "$SERVICE_NAME".service; then
            echo -e "${GREEN}Serviço Warsaw ativado com sucesso!${NC}"
        else
            echo -e "${RED}Erro: Não foi possível ativar o serviço Warsaw.${NC}"
            exit 1
        fi
    elif [ "$SERVICE_MANAGER" = "initd" ]; then
        sudo "$INITD_PATH" start
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Serviço Warsaw ativado com sucesso!${NC}"
        else
            echo -e "${RED}Erro: Não foi possível ativar o serviço Warsaw.${NC}"
            exit 1
        fi
    fi

    # Abre o navegador
    BROWSER=${BROWSER:-$DEFAULT_BROWSER}
    if command -v "$BROWSER" &> /dev/null; then
        echo -e "${YELLOW}Abrindo $BROWSER...${NC}"
        if [ -n "$BROWSER_URL" ]; then
            "$BROWSER" "$BROWSER_URL" &
        else
            "$BROWSER" &
        fi
    else
        echo -e "${YELLOW}Aviso: Navegador $BROWSER não encontrado. Inicie o navegador manualmente.${NC}"
    fi
}

# Função para desativar o serviço Warsaw
stop_warsaw() {
    echo -e "${YELLOW}Desativando o serviço Warsaw...${NC}"
    if [ "$SERVICE_MANAGER" = "systemd" ]; then
        sudo systemctl stop "$SERVICE_NAME".service
        if systemctl --quiet is-active "$SERVICE_NAME".service; then
            echo -e "${RED}Erro: Não foi possível desativar o serviço Warsaw.${NC}"
            exit 1
        else
            echo -e "${GREEN}Serviço Warsaw desativado com sucesso!${NC}"
        fi
    elif [ "$SERVICE_MANAGER" = "initd" ]; then
        sudo "$INITD_PATH" stop
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Serviço Warsaw desativado com sucesso!${NC}"
        else
            echo -e "${RED}Erro: Não foi possível desativar o serviço Warsaw.${NC}"
            exit 1
        fi
    fi
}

# Função para verificar o status do serviço
check_status() {
    if [ "$SERVICE_MANAGER" = "systemd" ]; then
        if systemctl --quiet is-active "$SERVICE_NAME".service; then
            echo -e "${GREEN}O serviço Warsaw está ATIVO.${NC}"
        else
            echo -e "${YELLOW}O serviço Warsaw está INATIVO.${NC}"
        fi
    elif [ "$SERVICE_MANAGER" = "initd" ]; then
        if sudo "$INITD_PATH" status &> /dev/null; then
            echo -e "${GREEN}O serviço Warsaw está ATIVO.${NC}"
        else
            echo -e "${YELLOW}O serviço Warsaw está INATIVO.${NC}"
        fi
    fi
}

# Função para exibir o menu
show_menu() {
    echo -e "${CYAN}Gerenciador do Serviço Warsaw${NC}"
    echo -e "${CYAN}----------------------------${NC}"
    echo -e "${WHITE}1. Ativar Warsaw e abrir o navegador${NC}"
    echo -e "${WHITE}2. Desativar Warsaw${NC}"
    echo -e "${WHITE}3. Verificar status do Warsaw${NC}"
    echo -e "${WHITE}4. Sair${NC}"
    echo -en "${WHITE}Escolha uma opção [1-4]: ${NC}"
}

# Configurações via argumentos ou variáveis de ambiente
while getopts "b:u:" opt; do
    case $opt in
        b) BROWSER="$OPTARG" ;;
        u) BROWSER_URL="$OPTARG" ;;
        *) echo -e "${RED}Uso: $0 [-b navegador] [-u url_do_banco]${NC}"; exit 1 ;;
    esac
done

# Detecta o gerenciador de serviços
detect_service_manager

# Verifica se o Warsaw está instalado
check_warsaw_installed

# Loop do menu
while true; do
    show_menu
    read option
    case $option in
        1)
            start_warsaw
            ;;
        2)
            stop_warsaw
            ;;
        3)
            check_status
            ;;
        4)
            echo -e "${CYAN}Saindo...${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Opção inválida! Por favor, escolha uma opção entre 1 e 4.${NC}"
            ;;
    esac
    echo
done
