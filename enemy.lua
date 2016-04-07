require "shoot"

Enemy = {
          x = 50,
          y = 50, 
          speed = 20, -- Está alta, para faciolitar os testes (ideal +- 50)
          shotsFired = {},
          lastShoot = -1,
          rechargeTime = 500, -- Tempo para o próximo tiro, em milisegundos
          img = love.graphics.newImage('Assets/Invader1.png'),
          scaleX = 0.2, -- Escala (X) da imagem relacionada ao inimigo
          scaleY = 0.2, -- Escala (Y) da imagem relacionada ao inimigo
          hitWall = 0, -- Booleana que verifica quando o inimigo bateu em uma parede
          HP = 1 
        }
        
function Enemy:new(obj)
  obj = obj or {}
  
  setmetatable(obj, self)
  self.__index = self
  
  return obj
end

function Enemy:setImage(directory)
  ---- Seta o sprite da nave
  
  self.img = love.graphics.newImage(directory)
end

function Enemy:draw()
  ---- Desenha o inimigo
  
  love.graphics.draw(self.img, self.x, self.y,0,self.scaleX,self.scaleY)
end

function Enemy:move(dt)
  ---- Move o inimigo
  
  self.x = self.x + self.speed * dt
end

function Enemy:moveDown()
  ---- Move inimido para baixo
  
  self.y = self.y + self.img:getHeight() * self.scaleY + 2
end

function Enemy:shoot()
  ---- Função que aloca um novo tiro dado pelo enemy

  -- Calcula a tempo que se passou desde o último tiro e transforma o tempo de recarga para segundos
  timeElapsed = os.clock() - self.lastShoot
  rechargeTimeInSeconds = self.rechargeTime / 1000
  
  -- Atira apenas se passou o tempo de recarga
  if timeElapsed >= rechargeTimeInSeconds then
    -- Aloca um novo tiro e seta a posição dele acima e no centro da nave
    newShoot = Shoot:new()
    newShoot.x = self.x + newShoot.img:getWidth() * 3.5
    newShoot.y = self.y + newShoot.img:getHeight() * 1.5
    newShoot.speed = -400
    
    -- Insere o novo tiro no final da table de tiros dados
    table.insert(self.shotsFired, newShoot)
    
    -- Atualiza o tempo do último tiro
    self.lastShoot = os.clock()
  end
end

function Enemy:drawShotsFired()
  ---- Função que desenha todos os tiros dados pelo enemy 
  
  i = 1
  while self.shotsFired[i] do
    self.shotsFired[i]:draw()
    
    -- Assumindo que a função de desenho vai ser chamada 30 vezes por segundo (30 fps)
    -- atualizo 1/30 vezes a velocidade do tiro por vez.
    self.shotsFired[i]:updatePosition(1/30)
    
    -- Removemos os tiros que já sairam da tela
    if self.shotsFired[i].y > 800 then
      table.remove(self.shotsFired, i)
    end
    
    -- TODO : remover os tiros que atingiram o player
    
    i = i + 1
  end
end

function Enemy:top()
  return self.y
end

function Enemy:bottom()
  return self.y + self.img:getHeight() * self.scaleY
end

function Enemy:left()
  return self.x
end

function Enemy:right()
  return self.x + self.img:getWidth() * self.scaleX
end