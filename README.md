# Gerenciador do Serviço Warsaw-bin

Este projeto contém um script Bash (`manage_warsaw.sh`) desenvolvido para facilitar a ativação e desativação do serviço **Warsaw-bin** no Arch Linux (ou distribuições baseadas em Arch, como Manjaro). O Warsaw-bin é um módulo de segurança exigido por bancos brasileiros para acesso ao internet banking pelo computador. Este script permite gerenciar o serviço de forma prática, ativando-o apenas antes de acessar o banco e desativando-o após o uso, reduzindo o impacto no desempenho do sistema.

## Funcionalidades

- **Ativar o serviço Warsaw**: Inicia o serviço e abre o Firefox para acesso ao internet banking.
- **Desativar o serviço Warsaw**: Para o serviço, reduzindo o consumo de recursos e o monitoramento em segundo plano.
- **Verificar status**: Exibe se o serviço Warsaw está ativo ou inativo.
- **Interface interativa**: Menu simples para escolher as opções de gerenciamento.

## Pré-requisitos

- Sistema operacional baseado em Arch Linux (como Arch Linux ou Manjaro) com `systemd`.
- Pacote `warsaw-bin` instalado via AUR (por exemplo, com `yay -S warsaw-bin`).
- Firefox instalado (ou outro navegador, com ajustes no script).
- Permissões de administrador para gerenciar serviços com `sudo`.

## Instalação

1. **Baixe o script**:
   - Copie o arquivo `manage_warsaw.sh` para um diretório de sua escolha, por exemplo:
     ```bash
     mkdir ~/warsaw-manager
     cd ~/warsaw-manager
     nano manage_warsaw.sh
     ```
   - Cole o conteúdo do script e salve.

2. **Torne o script executável**:
   ```bash
   chmod +x manage_warsaw.sh
   ```

3. **Verifique a instalação do Warsaw**:
   Certifique-se de que o `warsaw-bin` está instalado:
   ```bash
   yay -Qs warsaw-bin
   ```

## Uso

1. **Execute o script**:
   ```bash
   ./manage_warsaw.sh
   ```

2. **Escolha uma opção no menu**:
   - **1. Ativar Warsaw e abrir o navegador**: Inicia o serviço e abre o Firefox.
   - **2. Desativar Warsaw**: Para o serviço.
   - **3. Verificar status do Warsaw**: Mostra se o serviço está ativo ou inativo.
   - **4. Sair**: Encerra o script.

3. **Exemplo de fluxo**:
   - Escolha a opção 1 para ativar o Warsaw e acessar o banco.
   - Após usar o internet banking, escolha a opção 2 para desativar o serviço.

## Personalização

- **Mudar o navegador**: Por padrão, o script abre o Firefox. Para usar outro navegador (como Chromium), edite a linha no script:
  ```bash
  firefox &
  ```
  para, por exemplo:
  ```bash
  chromium &
  ```

- **Adicionar URL do banco**: Para abrir diretamente o site do banco, modifique a linha do navegador para:
  ```bash
  firefox https://www.seubanco.com.br &
  ```

## Notas

- O script requer permissões de administrador (`sudo`) para gerenciar o serviço Warsaw.
- O Warsaw pode consumir muitos recursos (CPU/memória). Desativá-lo após o uso ajuda a melhorar o desempenho do sistema.
- Caso o Warsaw não funcione corretamente, verifique a compatibilidade com seu navegador (Firefox é recomendado) e a versão mais recente do `warsaw-bin` no AUR.

## Contribuições

Contribuições são bem-vindas! Para sugerir melhorias ou relatar problemas:
1. Faça um fork do repositório (se hospedado em um serviço como GitHub).
2. Crie uma branch para suas alterações.
3. Envie um pull request com uma descrição clara das mudanças.

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).
