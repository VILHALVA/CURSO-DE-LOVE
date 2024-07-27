-- main.lua

-- Configurações do jogo
local paddleWidth = 20
local paddleHeight = 100
local ballSize = 20
local paddleSpeed = 300
local ballSpeedX = 400
local ballSpeedY = 300

-- Estado do jogo
local leftPaddle = { x = 30, y = 300 - paddleHeight / 2 }
local rightPaddle = { x = 770 - paddleWidth, y = 300 - paddleHeight / 2 }
local ball = { x = 400 - ballSize / 2, y = 300 - ballSize / 2, speedX = ballSpeedX, speedY = ballSpeedY }
local leftScore = 0
local rightScore = 0

-- Configurações iniciais
function love.load()
    love.window.setMode(800, 600)
    love.window.setTitle("Pong")
end

-- Atualiza o jogo
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

-- Desenha o jogo
function love.draw()
    -- Desenha paddles
    love.graphics.rectangle('fill', leftPaddle.x, leftPaddle.y, paddleWidth, paddleHeight)
    love.graphics.rectangle('fill', rightPaddle.x, rightPaddle.y, paddleWidth, paddleHeight)

    -- Desenha a bola
    love.graphics.rectangle('fill', ball.x, ball.y, ballSize, ballSize)

    -- Desenha a pontuação
    love.graphics.setFont(love.graphics.newFont(30))
    love.graphics.print("Left: " .. leftScore, 10, 10)
    love.graphics.print("Right: " .. rightScore, 720, 10)
end

-- Reinicia a posição da bola
function resetBall()
    ball.x = 400 - ballSize / 2
    ball.y = 300 - ballSize / 2
    ball.speedX = -ball.speedX
    ball.speedY = ballSpeedY
end
