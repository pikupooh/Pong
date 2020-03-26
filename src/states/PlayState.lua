PlayState = class{__includes = Basestate}

function PlayState:enter (params)
  self.level = params.level
  self.maxscore = params.score
  self.mode = params.mode
end

function PlayState:init ()
  player1 = Paddle(5, VIRTUAL_HEIGHT/2 -10, 5, 20)
  player2 = Paddle(VIRTUAL_WIDTH-10, VIRTUAL_HEIGHT/2 -10 , 5, 20)
  player2_speed = 200
  player1_speed = 200
  player1_score = 0
  player2_score = 0
  servingplayer = 1

  ball = Ball(VIRTUAL_WIDTH/2- 2 , VIRTUAL_HEIGHT/2 -2, 6, 6)
  win = 0
  gameState = 'start'
  pause = false
end

function PlayState:update(dt)
  if love.keyboard.waspressed('p') then
    if pause == false then
      pause = true
    else
      pause = false
    end
  end
  if pause == false then
        if self.mode == 0 then
          if self.level == 0 then
            player2_speed = 50
          elseif self.level == 1 then
            player2_speed = 70
          elseif self.level == 2 then
            player2_speed = 100
          end
        end
        if gameState == 'serve' then
          ball.dy = math.random(-50, 50)
          if servingplayer == 1 then
            ball.dx = math.random(140, 200)
          else
            ball.dx = -math.random(140,200)
          end
        end

        if gameState == 'play' then
          if ball:collide(player1) then
            ball.dx = -ball.dx * 1.05
            ball.x = player1.x + 5

            if ball.dy < 0 then
                ball.dy = -math.random(10, 50)
              else
                ball.dy = math.random(10, 50)
            end

            Sounds['paddle_hit']:play()
          end

          if ball:collide(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x -4

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
              else
                ball.dy = math.random(10, 150)
            end

              Sounds['paddle_hit']:play()
          end

       end

       if ball.y <= 0 then
         ball.y = 0
         ball.dy = -ball.dy
         Sounds['wall_hit']:play()
       end

       if ball.y >= VIRTUAL_HEIGHT - 4 then
         ball.y = VIRTUAL_HEIGHT - 4
         ball.dy = -ball.dy
         Sounds['wall_hit']:play()
       end

       if ball.x < 0 then
         servingplayer = 1
         player2_score = player2_score + 1

         if player2_score == self.maxscore then
           win = 2
           gameState = 'done'
         else
           gameState = 'start'
         end
         Sounds['score']:play()
          ball:reset()
       end

       if ball.x > VIRTUAL_WIDTH then
         servingplayer = 2
         player1_score = player1_score + 1
         ball:reset()
         if player1_score == self.maxscore then
           win = 1
           gameState = 'done'
         else
           gameState = 'start'
         end
         Sounds['score']:play()
       end

        if love.keyboard.isDown('w') then
          player1.dy = -player1_speed
        elseif love.keyboard.isDown('s') then
          player1.dy = player1_speed
        else
          player1.dy = 0
        end

        if self.mode == 0 then
          player2:auto(ball, player2_speed, dt)
        else
          if love.keyboard.isDown('up') then
            player2.dy = -player2_speed
          elseif love.keyboard.isDown('down') then
            player2.dy = player2_speed
          else
            player2.dy = 0
          end
            player2:update(dt)
        end

        if gameState == 'play' then
          ball:update(dt)
        end
        if gameState == 'done' then
          ball:reset()
          player1_score = 0
          player2_score = 0
        end
        player1:update(dt)

          if love.keyboard.waspressed('escape') then
            gStateMachine:change('chose', {mode = self.mode})
          elseif love.keyboard.waspressed('return')  then
            if gameState == 'done' then
              gameState = 'start'
            elseif gameState == 'start' then
              gameState = 'serve'
            elseif gameState == 'serve' then
              gameState = 'play'
            else
              gameState = 'start'
              ball:reset()
            end
          end
        end
end



function PlayState:render ()
  love.graphics.setFont(gFonts['medium'])
  if gameState == 'start' then
    love.graphics.print(tostring(player1_score), VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 4)
    love.graphics.print(tostring(player2_score), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 4)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('PRESS ENTER', 0, 20, VIRTUAL_WIDTH, 'center')
  end
  if gameState == 'serve' then
     if servingplayer == 1 then
       love.graphics.setFont(gFonts['medium'])
       love.graphics.printf('PLAYER 1 SERVE', 0, 20, VIRTUAL_WIDTH, 'center')
     else
       love.graphics.setFont(gFonts['medium'])
       love.graphics.printf('PLAYER 2 SERVE', 0, 20, VIRTUAL_WIDTH, 'center')
     end
   end
  if gameState == 'done' then
     love.graphics.printf('PLAYER ' .. tostring(win) .. ' WINS', 0, 20, VIRTUAL_WIDTH, 'center')
  end
  player1:render()
  player2:render()
  ball:render()
  if pause == true then
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("Game Paused", 0, VIRTUAL_HEIGHT/2, VIRTUAL_WIDTH, 'center')
  end
end

function PlayState:exit()

end
