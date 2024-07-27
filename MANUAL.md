# MANUAL
## 1. INSTALAÇÃO DO INTERPRETADOR LUA
Para desenvolver em Lua, você precisa instalar o interpretador Lua.

### WINDOWS:
1. Acesse o [site oficial do Lua](https://luabinaries.sourceforge.net/download.html).
2. Baixe a versão mais recente do binário do interpretador Lua para Windows (por exemplo, `lua-5.4.4_Win64_bin.zip`).
3. Extraia o conteúdo do arquivo ZIP em um diretório de sua escolha (por exemplo, `C:\Lua`).
4. Adicione o diretório ao PATH:
   - Abra o Painel de Controle.
   - Vá em Sistema e Segurança > Sistema > Configurações avançadas do sistema.
   - Clique em "Variáveis de Ambiente".
   - Em "Variáveis do sistema", encontre a variável `Path`, clique em "Editar" e adicione o caminho do diretório, por exemplo, `C:\Lua`.

Para verificar se a instalação foi bem-sucedida, abra o Prompt de Comando e execute:
```sh
lua -v
```

### MACOS:
1. Abra o Terminal.
2. Instale o Homebrew se ainda não o tiver instalado:
   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
3. Use o Homebrew para instalar o Lua:
   ```sh
   brew install lua
   ```

Para verificar se a instalação foi bem-sucedida, abra o Terminal e execute:
```sh
lua -v
```

### LINUX:
1. Abra um terminal.
2. Execute os seguintes comandos para instalar o Lua:
   ```sh
   sudo apt update
   sudo apt install lua5.4
   ```

Para verificar se a instalação foi bem-sucedida, abra um terminal e execute:
```sh
lua -v
```

## 2. INSTALAÇÃO DO LOVE:
### WINDOWS:
1. **Baixar o LÖVE**:
   - Vá para o [site oficial do LÖVE](https://love2d.org/) e baixe o instalador para Windows.

2. **Instalar o LÖVE**:
   - Execute o instalador baixado e siga as instruções na tela para concluir a instalação.

3. **Adicionar ao PATH** (opcional, mas recomendado):
   - Abra o Menu Iniciar e procure por "variáveis de ambiente".
   - Selecione "Editar variáveis de ambiente do sistema".
   - Na janela que aparece, clique em "Variáveis de Ambiente".
   - Encontre e edite a variável `Path` na seção "Variáveis do sistema".
   - Adicione o caminho para a pasta onde o LÖVE foi instalado (por exemplo, `C:\Program Files\LOVE`).

### MACOS:
1. **Baixar o LÖVE**:
   - Vá para o [site oficial do LÖVE](https://love2d.org/) e baixe o arquivo `.dmg` para macOS.

2. **Instalar o LÖVE**:
   - Abra o arquivo `.dmg` baixado e arraste o ícone do LÖVE para a pasta Aplicativos.

3. **Adicionar ao PATH** (opcional, mas recomendado):
   - Abra o Terminal e edite o arquivo de perfil (por exemplo, `.zshrc` ou `.bash_profile`) para adicionar o LÖVE ao PATH:
     ```bash
     export PATH="/Applications/love.app/Contents/MacOS:$PATH"
     ```

### LINUX:
1. **Baixar e Instalar o LÖVE**:
   - Consulte as instruções específicas para sua distribuição no [site do LÖVE](https://love2d.org/) ou use pacotes disponíveis nos repositórios.

   Por exemplo, em distribuições baseadas no Debian/Ubuntu, você pode usar:
   ```bash
   sudo apt-get install love
   ```

## 3. CONFIGURAÇÃO DO AMBIENTE:
Após a instalação, você pode verificar se o LÖVE está instalado corretamente abrindo um terminal (ou prompt de comando) e digitando:

```bash
love --version
```

Se o LÖVE estiver instalado corretamente, você verá a versão atual do LÖVE.

## 4. CRIAR UM PROJETO BÁSICO:
### PASSO 1: ESTRUTURA DO DIRETÓRIO:
1. Crie uma nova pasta para o seu projeto. Por exemplo, `MeuJogo`.

2. Dentro dessa pasta, crie um arquivo chamado `main.lua`.

   A estrutura básica do diretório deve ser assim:
   ```
   MeuJogo/
   ├── main.lua
   ```

### PASSO 2: ESCREVER O CÓDIGO DO JOGO:
Edite o arquivo `main.lua` com o seguinte código básico:

```lua
-- main.lua

-- Configurações iniciais
function love.load()
    love.window.setMode(800, 600) -- Define o tamanho da janela
    player = {
        x = 400,
        y = 300,
        size = 50,
        speed = 200
    }
end

-- Atualiza o jogo
function love.update(dt)
    -- Movimentação do jogador
    if love.keyboard.isDown('right') then
        player.x = player.x + player.speed * dt
    end
    if love.keyboard.isDown('left') then
        player.x = player.x - player.speed * dt
    end
    if love.keyboard.isDown('down') then
        player.y = player.y + player.speed * dt
    end
    if love.keyboard.isDown('up') then
        player.y = player.y - player.speed * dt
    end

    -- Limita o movimento do jogador dentro da tela
    if player.x < 0 then player.x = 0 end
    if player.x + player.size > 800 then player.x = 800 - player.size end
    if player.y < 0 then player.y = 0 end
    if player.y + player.size > 600 then player.y = 600 - player.size end
end

-- Desenha o jogo
function love.draw()
    love.graphics.clear(0.1, 0.1, 0.1) -- Cor de fundo
    love.graphics.setColor(1, 0, 0) -- Cor do jogador (vermelho)
    love.graphics.rectangle('fill', player.x, player.y, player.size, player.size)
end
```

### PASSO 3: RODAR O JOGO:
1. Abra o terminal (ou prompt de comando) e navegue até a pasta do seu projeto. Por exemplo:

   ```bash
   cd caminho/para/MeuJogo
   ```

2. Execute o LÖVE apontando para a pasta do seu projeto:

   ```bash
   love .
   ```

   Isso deve abrir uma janela do LÖVE com o jogo básico que você criou.

## 5. ESTRUTURA DO DIRETÓRIO E ORGANIZAÇÃO:
À medida que seu projeto cresce, você pode querer organizar melhor seus arquivos. Aqui está uma estrutura de diretório recomendada para projetos maiores:

```
MeuJogo/
├── main.lua
├── assets/
│   ├── imagem.png
│   └── som.wav
├── scripts/
│   └── util.lua
├── conf.lua
└── README.md
```

- **`main.lua`**: Arquivo principal do jogo.
- **`assets/`**: Pasta para recursos do jogo, como imagens, sons e músicas.
- **`scripts/`**: Pasta para scripts Lua adicionais que você pode querer modularizar.
- **`conf.lua`**: Arquivo de configuração opcional para definir configurações específicas do LÖVE.
- **`README.md`**: Arquivo de documentação para descrever o projeto.

### ARQUIVO DE CONFIGURAÇÃO (`conf.lua`):
Você pode criar um arquivo `conf.lua` para definir configurações adicionais, como o título da janela, tamanho da tela, etc.

```lua
-- conf.lua

function love.conf(t)
    t.title = "Meu Jogo"        -- Título da janela
    t.window.width = 800         -- Largura da janela
    t.window.height = 600        -- Altura da janela
    t.window.resizable = true    -- Permitir redimensionar a janela
end
```

Com essas etapas, você estará pronto para começar a desenvolver e expandir seu jogo usando LÖVE. 