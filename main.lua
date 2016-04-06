require "level_manager"
require "player"
require "enemy"

debug = true  -- mudar pra false no release

lm = LevelManager:new({level = 1})

function love.load(arg) 
  lm:loadAgents()
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
  
  lm:moveEnemies(dt)
end


function love.draw()
  player:draw()
  player:drawShotsFired()
  
  lm:drawEnemies()
  
  lm:detectCollision()
end