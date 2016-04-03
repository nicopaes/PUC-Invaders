require "shoot"

player = {
          x = 400,
          y = 710, 
          speed = 400,
          shotsFired = {},
          lastShoot = -1,
          rechargeTime = 500, -- Tempo para o próximo tiro, em milisegundos
          img = nil
        }

function player:move(direction)
  newValue = self.x + direction
  if 0 < newValue and newValue < love.graphics.getWidth() - self.img:getWidth() then
    self.x = newValue
  end
end

function player:setImage(directory)
  self.img = love.graphics.newImage(directory)
end

function player:draw()
  love.graphics.draw(self.img, self.x, self.y)
end

function player:shoot()
  timeElapsed = os.clock() - self.lastShoot
  rechargeTimeInSeconds = self.rechargeTime / 1000
  
  -- Como lastShoot é inicializado com -1
  -- timeElapsed é garantidamente > 1 no início
  if timeElapsed >= rechargeTimeInSeconds then
    newShoot = Shoot:new()
    newShoot.x = self.x + (self.img:getWidth() - newShoot.img:getWidth()) / 2
    newShoot.y = self.y - newShoot.img:getHeight()
    
    table.insert(self.shotsFired, newShoot)
    
    self.lastShoot = os.clock()
  end
end

function player:drawShotsFired()
  i = 1
  while self.shotsFired[i] do
    self.shotsFired[i]:draw()
    
    -- Assumindo que a função de desenho vai ser chamada 30 vezes por segundo
    -- atualizo 1/30 vezes a velocidade do tiro por vez.
    self.shotsFired[i]:updatePosition(1/30)
    
    -- Removemos os tiros que já sairam da tela
    if self.shotsFired[i].y < 0 then
      table.remove(self.shotsFired, i)
    end
    
    -- TODO : remover os tiros que atingiram inimigos
    
    i = i + 1
  end
end