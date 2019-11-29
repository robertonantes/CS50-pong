WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

VIRTUAL_WIDTH = 300
VIRTUAL_HEIGHT = 225

PADDLE_SPEED = 200


-- push is a library that will allow us to draw our game at a virtual
-- resolution, instead of however large our window is; used to provide
-- a more retro aesthetic
--
-- https://github.com/Ulydev/push
push = require('push')

-- https://github.com/vrld/hump/blob/master/class.lua
Class = require('class')
require('Paddle')
require('Ball')

function love.load()

  -- Change filter to preserve retro look
  love.graphics.setDefaultFilter('nearest', 'nearest');
  math.randomseed(os.time())

  -- Load font
  scoreFont = love.graphics.newFont('assets/font.ttf', 32);
  love.graphics.setFont(scoreFont);

  -- Set window title
  love.window.setTitle('Pong!');

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
    fullscreen = false,
    resizable = false,
    vsync = true
  })

  player1 = Paddle(10, 30, 5, 20)
  player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)
  ball = Ball(VIRTUAL_WIDTH / 2 -2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

  gameState = 'start'


end

function love.update(dt)

  -- p1 movement
  if love.keyboard.isDown('w') then
    player1.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown('s') then
    player1.dy = PADDLE_SPEED
  else
    player1.dy = 0
  end

  -- p2 movement
  if love.keyboard.isDown('up') then
    player2.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown('down') then
    player2.dy = PADDLE_SPEED
  else
    player2.dy = 0
  end

  
  if gameState == 'play' then
    ball:update(dt)

    if(ball:collides(player1)) then
      ball.dx = -ball.dx * 1.03
      ball.x = player1.x + 5

      if(ball.dy < 0) then
        ball.dy = -math.random(10, 150)
      else
        ball.dy = math.random(10, 150)
      end
    end
    
  end

  -- Ball collision top screen
  if(ball.y <= 0) then
    ball.y = 0
    ball.dy = -ball.dy
  end

  -- Ball collision bottom screen
  if(ball.y >= VIRTUAL_HEIGHT -4 ) then 
    ball.y = VIRTUAL_HEIGHT -4
    ball.dy = -ball.dy
  end

  player1:update(dt)
  player2:update(dt)

end

function love.keypressed(key)
  if(key == 'escape') then
    love.event.quit()
  end 
  if(key == 'enter' or key == 'return') then
    if(gameState == 'start') then
      gameState = 'play'
    else
      gameState = 'start'
      ball:reset()
    end
  end
end

function love.draw()
  push:apply('start')

  love.graphics.clear(0.156, 0.17, 0.203, 1)

  -- draws score
  love.graphics.print(0, VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3);
  love.graphics.print(0, VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3);
  
  -- left paddle
  player1:render()

  -- right paddle
  player2:render()

  -- ball
  ball:render()
  push:apply('end')
end

