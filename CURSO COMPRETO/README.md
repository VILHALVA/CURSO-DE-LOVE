# EXPLICAÇÃO DE `./main.lua`
## EXPLICAÇÃO LINHA POR LINHA:
### CONFIGURAÇÕES DO JOGO:
```lua
local paddleWidth = 20
local paddleHeight = 100
local ballSize = 20
local paddleSpeed = 300
local ballSpeedX = 400
local ballSpeedY = 300
```
- **Variáveis de Configuração**: Define as dimensões dos paddles e da bola, além das velocidades de movimento dos paddles e da bola.

### ESTADO DO JOGO:
```lua
local leftPaddle = { x = 30, y = 300 - paddleHeight / 2 }
local rightPaddle = { x = 770 - paddleWidth, y = 300 - paddleHeight / 2 }
local ball = { x = 400 - ballSize / 2, y = 300 - ballSize / 2, speedX = ballSpeedX, speedY = ballSpeedY }
local leftScore = 0
local rightScore = 0
```
- **Estado do Jogo**:
  - **`leftPaddle` e `rightPaddle`**: Define a posição inicial dos paddles. O paddle esquerdo começa a 30 pixels da borda esquerda, e o paddle direito começa a 770 pixels da borda esquerda (o que coloca o paddle direito na borda direita da tela).
  - **`ball`**: Define a posição e velocidade inicial da bola.
  - **`leftScore` e `rightScore`**: Inicializa a pontuação dos jogadores.

### CONFIGURAÇÕES INICIAIS:
```lua
function love.load()
    love.window.setMode(800, 600)
    love.window.setTitle("Pong")
end
```
- **`love.load`**: Função chamada uma vez quando o jogo inicia. Configura o tamanho da janela do jogo para 800x600 pixels e define o título da janela como "Pong".

### ATUALIZA O JOGO:
```lua
function love.update(dt)
    -- Movimentação dos paddles
    if love.keyboard.isDown('w') then
        leftPaddle.y = leftPaddle.y - paddleSpeed * dt
    end
    if love.keyboard.isDown('s') then
        leftPaddle.y = leftPaddle.y + paddleSpeed * dt
    end
    if love.keyboard.isDown('up') then
        rightPaddle.y = rightPaddle.y - paddleSpeed * dt
    end
    if love.keyboard.isDown('down') then
        rightPaddle.y = rightPaddle.y + paddleSpeed * dt
    end

    -- Restringe os paddles à tela
    leftPaddle.y = math.max(0, math.min(leftPaddle.y, 600 - paddleHeight))
    rightPaddle.y = math.max(0, math.min(rightPaddle.y, 600 - paddleHeight))

    -- Atualiza a posição da bola
    ball.x = ball.x + ball.speedX * dt
    ball.y = ball.y + ball.speedY * dt

    -- Colisão com a borda superior e inferior
    if ball.y <= 0 or ball.y >= 600 - ballSize then
        ball.speedY = -ball.speedY
    end

    -- Colisão com os paddles
    if (ball.x <= leftPaddle.x + paddleWidth and ball.x + ballSize >= leftPaddle.x and
        ball.y + ballSize >= leftPaddle.y and ball.y <= leftPaddle.y + paddleHeight) or
       (ball.x + ballSize >= rightPaddle.x and ball.x <= rightPaddle.x + paddleWidth and
        ball.y + ballSize >= rightPaddle.y and ball.y <= rightPaddle.y + paddleHeight) then
        ball.speedX = -ball.speedX
    end

    -- Pontuação e reinício da bola
    if ball.x < 0 then
        rightScore = rightScore + 1
        resetBall()
    elseif ball.x > 800 then
        leftScore = leftScore + 1
        resetBall()
    end
end
```
- **`love.update(dt)`**: Função chamada a cada frame. Atualiza o estado do jogo:
  - **Movimentação dos Paddles**: Verifica as teclas pressionadas e ajusta a posição dos paddles. `dt` é o tempo desde o último frame, garantindo movimentos suaves e consistentes.
  - **Restringe Paddles**: Garante que os paddles não saiam da tela.
  - **Atualiza a Bola**: Move a bola com base na sua velocidade.
  - **Colisão com Bordas**: Inverte a direção da bola se ela colidir com a borda superior ou inferior da tela.
  - **Colisão com Paddles**: Inverte a direção da bola se ela colidir com um paddle.
  - **Pontuação e Reinício**: Se a bola sair da tela (à esquerda ou à direita), atualiza a pontuação e reinicia a posição da bola.

### DESENHA O JOGO:
```lua
function love.draw()
    -- Desenha paddles
    love.graphics.rectangle('fill', leftPaddle.x, leftPaddle.y, paddleWidth, paddleHeight)
    love.graphics.rectangle('fill', rightPaddle.x, rightPaddle.y, paddleWidth, paddleHeight)

    -- Desenha a bola
    love.graphics.rectangle('

fill', ball.x, ball.y, ballSize, ballSize)

    -- Desenha a pontuação
    love.graphics.setFont(love.graphics.newFont(30))
    love.graphics.print("Left: " .. leftScore, 10, 10)
    love.graphics.print("Right: " .. rightScore, 720, 10)
end
```
- **`love.draw()`**: Função chamada a cada frame para desenhar o jogo:
  - **Desenha os Paddles**: Usa `love.graphics.rectangle` para desenhar os paddles na tela.
  - **Desenha a Bola**: Desenha a bola na tela.
  - **Desenha a Pontuação**: Usa `love.graphics.print` para mostrar a pontuação dos jogadores no canto superior da tela.

### REINICIA A POSIÇÃO DA BOLA:
```lua
function resetBall()
    ball.x = 400 - ballSize / 2
    ball.y = 300 - ballSize / 2
    ball.speedX = -ball.speedX
    ball.speedY = ballSpeedY
end
```
- **`resetBall()`**: Função para reiniciar a bola no centro da tela e inverter sua direção horizontal. 

## COMO JOGAR?
- **Execute o Jogo**: 
    - Execute o LÖVE apontando para a pasta do seu projeto `(./main.lua)`:

   ```bash
   love .
   ```

   - Isso deve abrir uma janela do LÖVE com o jogo do PONG.

- **Movimentação do Paddle Esquerdo**:
  - **`W`**: Move o paddle esquerdo para cima.
  - **`S`**: Move o paddle esquerdo para baixo.

- **Movimentação do Paddle Direito**:
  - **`Setas para cima`**: Move o paddle direito para cima.
  - **`Setas para baixo`**: Move o paddle direito para baixo.

- **Objetivo do Jogo**:
  - Rebata a bola com seu paddle para evitar que ela passe pelo seu lado da tela.
  - Marque pontos quando a bola passar pelo paddle adversário.
  - O jogo continua até que você feche a janela do jogo.
