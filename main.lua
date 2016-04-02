debug = true  -- mudar pra false no release

-------- BEGIN: Isso provavelmente deve virar uma classe em breve
player = {
          x = 200,
          y = 710, 
          speed = 400,
          img = nil
        }

function player:move(dir)
  newValue = self.x + dir
  if 0 < newValue and newValue < love.graphics.getWidth() - player.img:getWidth() then
    self.x = newValue
  end
end
---------- END

function love.load(arg) 
  player.img = love.graphics.newImage('assets/plane.png')
end

function love.update(dt)
  -- ESC: Sai do jogo
  if love.keyboard.isDown('escape') then
    love.event.push('quit')
  -- Left Arrow ou A: Move para a esquerda
  elseif love.keyboard.isDown('left','a') then
    player:move(-player.speed*dt)
  -- Right Arrow ou D: Move para a direita
  elseif love.keyboard.isDown('right','d') then
    player:move(player.speed*dt)
  end
end

function love.draw(dt)
  -- Desenha o player
  love.graphics.draw(player.img, player.x, player.y)
end
