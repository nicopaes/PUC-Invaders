require "player"
require "enemy"

debug = true  -- mudar pra false no release

function love.load(arg) 
  player:setImage('assets/plane.png')
  enemy:setImage('assets/Invader1.png')
end

function love.update(dt)
  -- ESC: Sai do jogo
  if love.keyboard.isDown('escape') then
    love.event.push('quit')
  end

  -- Left Arrow ou A: Move para a esquerda
  if love.keyboard.isDown('left','a') then
    player:move(-player.speed*dt)
  -- Right Arrow ou D: Move para a direita
  elseif love.keyboard.isDown('right','d') then
    player:move(player.speed*dt)
  end

  -- Up Arrow or W: Shoot
  if love.keyboard.isDown('up','w') then
    player:shoot()
  end
  
  enemy:move(enemy.speed*dt)
  
  
  
end


function love.draw()
  player:draw()
  player:drawShotsFired()
  enemy:draw()
  
end
