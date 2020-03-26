require 'src/dependence'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  math.randomseed(os.time())

  love.window.setTitle('PONG')

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
                    vsync = true,
                    fullscreen = false,
                    resizable = true
  })

  gFonts = {
        ['small'] = love.graphics.newFont('Fonts/font.ttf', 8),
        ['medium'] = love.graphics.newFont('Fonts/font.ttf', 16),
        ['large'] = love.graphics.newFont('Fonts/font.ttf', 32)
    }

  Sounds = {
    ['paddle_hit'] = love.audio.newSource('Sounds/paddle_hit.wav', 'static'),
    ['score'] = love.audio.newSource('Sounds/score.wav', 'static'),
    ['wall_hit'] = love.audio.newSource('Sounds/wall_hit.wav', 'static')
  }

 gStateMachine = StateMachine{
   ['start'] = function() return StartState() end,
   ['chose'] = function() return ChoseState() end,
   ['play'] = function() return PlayState() end,
 }
 gStateMachine:change('start')
 love.keyboard.keypressed = {}
end

function love.resize(w, h)
  push:resize(w,h)
end

function love.update(dt)
  gStateMachine:update(dt)
  love.keyboard.keypressed = {}
end

function love.keypressed(key)
  love.keyboard.keypressed[key] = true
end

function love.keyboard.waspressed(key)
  return love.keyboard.keypressed[key]
end

function love.draw()
  push:start()
  gStateMachine:render()
  displayfps()
  push:finish()
end

function displayfps()
  love.graphics.setFont(gFonts['small'])
  love.graphics.setColor(0, 255, 0, 150)
  love.graphics.print('FPS: '..tostring(love.timer.getFPS()), 10, 10)
end
