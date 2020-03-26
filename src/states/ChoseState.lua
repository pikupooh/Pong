ChoseState = class{__includes = Basestate}

function ChoseState:enter (params)
  self.mode = params.mode
end

function ChoseState:init ()
  self.score = 3
  self.level = 2
end

function ChoseState:update(dt)
  if love.keyboard.waspressed('right') and self.score < 21 then
    self.score = (self.score + 1)
  end
  if love.keyboard.waspressed('left') and self.score > 3 then
    self.score = (self.score - 1)
  end
  if self.mode == 0 then
      if love.keyboard.waspressed('down') then
        self.level = (self.level + 1) % 3
      end
      if love.keyboard.waspressed('up') then
        self.level = (self.level - 1) % 3
      end
  end 
  if love.keyboard.waspressed('escape') then
    gStateMachine:change('start')
  end
  if love.keyboard.waspressed('return') then
    gStateMachine:change('play',{score = self.score,
                                 level = self.level,
                                 mode = self.mode})
  end
end

function ChoseState:render ()
  love.graphics.setFont(gFonts['medium'])
  love.graphics.printf("Select Game Point",0,VIRTUAL_HEIGHT/5  , VIRTUAL_WIDTH , 'center')
  love.graphics.setColor(0, 0, 255)
  love.graphics.printf(self.score ,0,VIRTUAL_HEIGHT/5 + 25 , VIRTUAL_WIDTH , 'center')
  love.graphics.setColor(255, 255, 255)
  if self.mode == 0 then
    love.graphics.printf("Select Game Level",0,VIRTUAL_HEIGHT/4 + 50 , VIRTUAL_WIDTH , 'center')
    if self.level == 0 then
      love.graphics.setColor(0, 0, 255)
    end
    love.graphics.printf("Easy",0,VIRTUAL_HEIGHT/4 + 75 , VIRTUAL_WIDTH , 'center')
    love.graphics.setColor(255, 255, 255)
    if self.level == 1 then
      love.graphics.setColor(0, 0, 255)
    end
    love.graphics.printf("Medium",0,VIRTUAL_HEIGHT/4 + 100 , VIRTUAL_WIDTH , 'center')
    love.graphics.setColor(255, 255, 255)
    if self.level == 2 then
      love.graphics.setColor(0, 0, 255)
    end
    love.graphics.printf("Hard",0,VIRTUAL_HEIGHT/4 + 125 , VIRTUAL_WIDTH , 'center')
    love.graphics.setColor(255, 255, 255)
  end
  love.graphics.setFont(gFonts['small'])
  love.graphics.printf("CONTROLS: ARROW KEYS", 0, VIRTUAL_HEIGHT - 15, VIRTUAL_WIDTH , 'center')
end

function ChoseState:exit()

end
