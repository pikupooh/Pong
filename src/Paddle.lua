Paddle  = class{}

function Paddle:init(x, y, width, height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height

  self.dy = 0
end

function Paddle:update(dt)
    if self.y < 0 then
      self.y = math.max(0, self.y + self.dy * dt )
    else
      self.y = math.min(VIRTUAL_HEIGHT - self.height , self.y + self.dy * dt)
    end
end


function Paddle:auto(Ball,speed,dt)
  if Ball.y + Ball.height/2 < self.y or Ball.y > self.y + self.height then
    if Ball.dx > 0 and Ball.x >  30 then
        if Ball.y + Ball.height/2 > self.y then
          self.dy = speed
        elseif Ball.y  < self.y + self.height then
          self.dy = -speed
        end
        self.y = self.y + self.dy * dt
    end
  end
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
