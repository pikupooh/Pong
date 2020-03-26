Ball = class{}

function  Ball:init(x, y, width, height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height

  self.dx = math.random(-50,50)
  self.dy = math.random(2) == 1 and 100 or -100
end

function Ball:reset()
  self.x = VIRTUAL_WIDTH/2 - self.width/2
  self.y = VIRTUAL_HEIGHT/2 - self.width/2
  self.dy = math.random(-50,50)
  self.dx = math.random(2) == 1 and 100 or -100
end

function Ball:update(dt)
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
end

function Ball:render()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

    if self.x < 0 or self.x > VIRTUAL_WIDTH then
      love.graphics.setFont(gFonts['small'])
        love.graphics.printf('PRESS ENTER TO CONTINUE', 0, 20, VIRTUAL_WIDTH, 'center')
      end
end

function Ball:collide(Paddle)
  if self.x > Paddle.x + Paddle.width or Paddle.x > self.x + self.width then
    return false
  end

  if self.y > Paddle.y + Paddle.height or Paddle.y > self.y + self.height then
    return false
  end

  return true
end
