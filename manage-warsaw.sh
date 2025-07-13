#!/bin/bash

# Script para ativar/desativar o serviço Warsaw-bin e abrir o navegador para acesso ao banco

# Função para verificar se o Warsaw está instalado
check_warsaw_installed() {
    if ! systemctl --quiet is-active warsaw.service && ! systemctl --quiet is-enabled warsaw.service; then
        echo "Erro: O serviço Warsaw não está instalado ou não foi encontrado."
        exit 1
    fi
}

# Função para ativar o Warsaw e abrir o navegador
start_warsaw() {
    echo "Ativando o serviço Warsaw..."
    sudo systemctl start warsaw.service
    if systemctl --quiet is-active warsaw.service; then
        echo "Serviço Warsaw ativado com sucesso!"
        # Abre o Firefox (ou outro navegador, se preferir)
        echo "Abrindo o Firefox para acessar o banco..."
        firefox &
    else
        echo "Erro: Não foi possível ativar o serviço Warsaw."
        exit 1
    fi
}

# Função para desativar o Warsaw
stop_warsaw() {
    echo "Desativando o serviço Warsaw..."
    sudo systemctl stop warsaw.service
    if systemctl --quiet is-active warsaw.service; then
        echo "Erro: Não foi possível desativar o serviço Warsaw."
        exit 1
    else
        echo "Serviço Warsaw desativado com sucesso!"
    fi
}

# Função para exibir o menu
show_menu() {
    echo "Gerenciador do Serviço Warsaw"
    echo "----------------------------"
    echo "1. Ativar Warsaw e abrir o navegador"
    echo "2. Desativar Warsaw"
    echo "3. Verificar status do Warsaw"
    echo "4. Sair"
    echo -n "Escolha uma opção [1-4]: "
}

# Função para verificar o status do serviço
check_status() {
    if systemctl --quiet is-active warsaw.service; then
        echo "O serviço Warsaw está ATIVO."
    else
        echo "O serviço Warsaw está INATIVO."
    fi
}

# Verifica se o systemctl está disponível
if ! command -v systemctl &> /dev/null; then
    echo "Erro: O systemctl não está disponível. Este script requer um sistema com systemd."
    exit 1
fi

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
            echo "Saindo..."
            exit 0
            ;;
        *)
            echo "Opção inválida! Por favor, escolha uma opção entre 1 e 4."
            ;;
    esac
    echo
done
