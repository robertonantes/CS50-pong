WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

VIRTUAL_WIDTH = 300
VIRTUAL_HEIGHT = 225


-- push is a library that will allow us to draw our game at a virtual
-- resolution, instead of however large our window is; used to provide
-- a more retro aesthetic
--
-- https://github.com/Ulydev/push
push = require('push');

function love.load()

  -- Change filter to preserve retro looking
  love.graphics.setDefaultFilter('nearest', 'nearest');

  -- Load retro font
  retroFont = love.graphics.newFont('assets/font.ttf', 8);
  love.graphics.setFont(retroFont);

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
    fullscreen = false,
    resizable = false,
    vsync = true
  })
end

function love.keypressed(key)
  if(key == 'escape') then
    love.event.quit()
  end
end

function love.draw()
  push:apply('start')

  love.graphics.clear(0.156, 0.17, 0.203, 1)
  
  -- left paddle
  love.graphics.rectangle('fill', 10, 30, 5, 20)
  
  -- right paddle
  love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT -50, 5, 20)
  
  -- ball
  love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
  push:apply('end')
end

