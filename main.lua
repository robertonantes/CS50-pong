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
push = require('push');

function love.load()

  -- Change filter to preserve retro looking
  love.graphics.setDefaultFilter('nearest', 'nearest');

  -- Load font
  scoreFont = love.graphics.newFont('assets/font.ttf', 32);
  love.graphics.setFont(scoreFont);

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
    fullscreen = false,
    resizable = false,
    vsync = true
  })


  -- Players position
  player1Y = 30;
  player2Y = VIRTUAL_HEIGHT - 50;
end

function love.update(dt)
  if love.keyboard.isDown('w') then
    player1Y = player1Y - PADDLE_SPEED * dt
  elseif love.keyboard.isDown('s') then
    player1Y = player1Y + PADDLE_SPEED * dt
  end

  if love.keyboard.isDown('up') then
    player2Y = player2Y - PADDLE_SPEED * dt
  elseif love.keyboard.isDown('down') then
    player2Y = player2Y + PADDLE_SPEED * dt
  end

end

function love.keypressed(key)
  if(key == 'escape') then
    love.event.quit()
  end 

end

function love.draw()
  push:apply('start')

  love.graphics.clear(0.156, 0.17, 0.203, 1)

  -- draws score
  love.graphics.print(0, VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3);
  love.graphics.print(0, VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3);
  
  -- left paddle
  love.graphics.rectangle('fill', 10, player1Y, 5, 20)
  
  -- right paddle
  love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)
  
  -- ball
  love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
  push:apply('end')
end

