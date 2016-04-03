require "player_shoot"

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
  ---- Move a nave
  
  newValue = self.x + direction
  
  -- Move apenas se não ultrapassar as bordas da tela
  if 0 < newValue and newValue < love.graphics.getWidth() - self.img:getWidth() then
    self.x = newValue
  end
end

function player:setImage(directory)
  ---- Seta o sprite da nave
  
  self.img = love.graphics.newImage(directory)
end

function player:draw()
  ---- Desenha a nave
  
  love.graphics.draw(self.img, self.x, self.y)
end

function player:shoot()
  ---- Função que aloca um novo tiro dado pelo player

  -- Calcula a tempo que se passou desde o último tiro e transforma o tempo de recarga para segundos
  timeElapsed = os.clock() - self.lastShoot
  rechargeTimeInSeconds = self.rechargeTime / 1000
  
  -- Atira apenas se passou o tempo de recarga
  if timeElapsed >= rechargeTimeInSeconds then
    -- Aloca um novo tiro e seta a posição dele acima e no centro da nave
    newShoot = Shoot:new()
    newShoot.x = self.x + (self.img:getWidth() - newShoot.img:getWidth()) / 2
    newShoot.y = self.y - newShoot.img:getHeight()
    
    -- Insere o novo tiro no final da table de tiros dados
    table.insert(self.shotsFired, newShoot)
    
    -- Atualiza o tempo do último tiro
    self.lastShoot = os.clock()
  end
end

function player:drawShotsFired()
  ---- Função que desenha todos os tiros dados pelo player
  
  i = 1
  while self.shotsFired[i] do
    self.shotsFired[i]:draw()
    
    -- Assumindo que a função de desenho vai ser chamada 30 vezes por segundo (30 fps)
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