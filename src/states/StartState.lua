StartState = class{__includes = Basestate}

function StartState:init ()
  self.mode = 0
end

function StartState:update(dt)
  if love.keyboard.waspressed('up')  then
    self.mode = (self.mode - 1) % 3
  end
  if love.keyboard.waspressed('down')  then
    self.mode = (self.mode + 1) % 3
  end

  if love.keyboard.waspressed('return') then
    if self.mode == 0 then
      gStateMachine:change('chose', {mode = self.mode})
    end
    if self.mode == 1 then
      gStateMachine:change('chose',{mode = self.mode})
    end
    if self.mode == 2 then
      love.event.quit()
    end
  end

  if love.keyboard.waspressed('escape') then
    love.event.quit()
  end
end

function StartState:render()
  love.graphics.setFont(gFonts['large'])
  love.graphics.printf("PONG",0,VIRTUAL_HEIGHT/3 , VIRTUAL_WIDTH , 'center')

  love.graphics.setFont(gFonts['small'])

  if self.mode == 0 then
    love.graphics.setColor(0, 0, 255)
  end
  love.graphics.printf("SINGLE PLAYER",0 , VIRTUAL_HEIGHT/2 + 50, VIRTUAL_WIDTH, 'center')
  love.graphics.setColor(255, 255, 255)
  if self.mode == 1 then
    love.graphics.setColor(0, 0, 255)
  end
  love.graphics.printf("MULTIPLAYER",0 , VIRTUAL_HEIGHT/2 + 75, VIRTUAL_WIDTH, 'center')
  love.graphics.setColor(255, 255, 255)
  if self.mode == 2 then
    love.graphics.setColor(0, 0, 255)
  end
  love.graphics.printf("EXIT",0 , VIRTUAL_HEIGHT/2 + 100, VIRTUAL_WIDTH, 'center')
  love.graphics.setColor(255, 255, 255)
end

function StartState:enter() end
function StartState:exit() end
