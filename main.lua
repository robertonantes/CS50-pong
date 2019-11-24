WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


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

function love.draw()
  push:apply('start')
  love.graphics.printf(
    'Hello Pong!',
    0,
    VIRTUAL_HEIGHT / 2 - 6,
    VIRTUAL_WIDTH,
    'center'
  )
  push:apply('end')
end