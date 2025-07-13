# Gerenciador do Serviço Warsaw-bin

Este projeto contém um script Bash (`manage_warsaw.sh`) desenvolvido para gerenciar o serviço **Warsaw-bin**, um módulo de segurança exigido por bancos brasileiros (como Banco do Brasil, Caixa, Itaú, Santander) para acesso ao internet banking pelo computador. O script permite ativar e desativar o serviço de forma prática, reduzindo o impacto no desempenho do sistema ao executá-lo apenas quando necessário. Ele é compatível com várias distribuições Linux e inclui mensagens coloridas para melhor legibilidade.

## Funcionalidades

- **Ativar o serviço Warsaw**: Inicia o serviço e abre um navegador configurável (padrão: Firefox) com uma URL opcional do banco.
- **Desativar o serviço Warsaw**: Para o serviço, minimizando o consumo de recursos e o monitoramento em segundo plano.
- **Verificar status**: Exibe se o serviço Warsaw está ativo ou inativo.
- **Interface interativa**: Menu com mensagens coloridas (verde para sucesso, vermelho para erros, amarelo para avisos, ciano para títulos).
- **Compatibilidade**: Suporta sistemas com `systemd` (Ubuntu, Debian, Fedora, Arch Linux) e `init.d` (distribuições mais antigas).
- **Configuração flexível**: Permite especificar o navegador e a URL do banco via argumentos (`-b` e `-u`) ou variáveis de ambiente.

## Pré-requisitos

- Sistema operacional Linux com `systemd` (ex.: Ubuntu, Debian, Fedora, Arch Linux) ou `init.d` (ex.: Slackware).
- Pacote `warsaw-bin` instalado (via AUR no Arch Linux com `yay -S warsaw-bin`, `.deb` no Ubuntu/Debian, ou `.rpm` no Fedora).
- Navegador instalado (ex.: Firefox, Chromium; Firefox é recomendado para melhor compatibilidade com o Warsaw).
- Permissões de administrador para gerenciar serviços com `sudo`.
- Terminal compatível com cores ANSI para exibir mensagens coloridas.
- Pacote `wget` instalado para baixar o script.

## Instalação

1. **Baixe o script**:

   - Use `wget` para baixar o script diretamente do repositório GitHub:

     ```bash
     mkdir ~/warsaw-manager
     cd ~/warsaw-manager
     wget https://raw.githubusercontent.com/franzopl/manage-warsaw/main/manage_warsaw.sh
     ```

2. **Torne o script executável**:

   ```bash
   chmod +x manage_warsaw.sh
   ```

3. **Verifique a instalação do Warsaw**:

   - No Arch Linux:

     ```bash
     yay -Qs warsaw-bin
     ```
   - No Ubuntu/Debian, verifique o pacote `.deb` instalado:

     ```bash
     dpkg -l | grep warsaw
     ```
   - No Fedora, verifique o pacote `.rpm`:

     ```bash
     rpm -qa | grep warsaw
     ```

## Uso

1. **Execute o script**:

   - Uso básico (menu interativo com Firefox padrão):

     ```bash
     ./manage_warsaw.sh
     ```
   - Com navegador e URL específicos:

     ```bash
     ./manage_warsaw.sh -b chromium -u https://www.seubanco.com.br
     ```

2. **Menu interativo**:

   - **1. Ativar Warsaw e abrir o navegador**: Inicia o serviço e abre o navegador (com a URL configurada, se especificada).
   - **2. Desativar Warsaw**: Para o serviço.
   - **3. Verificar status do Warsaw**: Mostra se o serviço está ativo ou inativo.
   - **4. Sair**: Encerra o script.

3. **Exemplo de fluxo**:

   - Execute `./manage_warsaw.sh -u https://www.bancodobrasil.com.br` para ativar o Warsaw e abrir o Banco do Brasil no Firefox.
   - Após usar o internet banking, escolha a opção 2 para desativar o serviço.

## Personalização

- **Mudar o navegador**:

  - Via argumento:

    ```bash
    ./manage_warsaw.sh -b chromium
    ```
  - Ou edite a variável `DEFAULT_BROWSER` no script (ex.: `DEFAULT_BROWSER="chromium"`).

- **Especificar a URL do banco**:

  - Via argumento:

    ```bash
    ./manage_warsaw.sh -u https://www.seubanco.com.br
    ```
  - Ou edite a variável `BROWSER_URL` no script.

- **Ajustar o nome do serviço**:

  - Se o serviço Warsaw tiver um nome diferente (ex.: `warsawd`), modifique a variável `SERVICE_NAME` no script.

- **Cores das mensagens**:

  - As mensagens usam cores ANSI (verde para sucesso, vermelho para erros, amarelo para avisos, ciano para títulos). Para alterar as cores, edite as variáveis `RED`, `GREEN`, etc., no início do script.

## Notas

- O script requer permissões de administrador (`sudo`) para gerenciar o serviço Warsaw.
- O Warsaw pode consumir recursos (CPU/memória). Desativá-lo após o uso melhora o desempenho do sistema.
- Para compatibilidade ideal, use o Firefox, pois o Warsaw pode apresentar problemas com outros navegadores (ex.: Chrome).
- Caso o Warsaw não funcione, verifique a versão mais recente
- Em sistemas sem `systemd` ou `init.d` (ex.: OpenRC, runit), o script pode precisar de ajustes adicionais. (não foram realizados testes)

## Contribuições

Contribuições são bem-vindas! Para sugerir melhorias ou relatar problemas:

1. Faça um fork do repositório (se hospedado em um serviço como GitHub).
2. Crie uma branch para suas alterações.
3. Envie um pull request com uma descrição clara das mudanças.

## Licença

Este projeto está licenciado sob a MIT License.
