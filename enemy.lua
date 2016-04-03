require "enemy_shoot"

enemy = {
          x = 50,
          y = 50, 
          speed = 500, -- Está alta, para faciolitar os testes (ideal +- 50)
          shotsFired = {},
          lastShoot = -1,
          rechargeTime = 500, -- Tempo para o próximo tiro, em milisegundos
          img = nil,
          scaleX = 0.2, -- Escala (X) da imagem relacionada ao inimigo
          scaleY = 0.2, -- Escala (Y) da imagem relacionada ao inimigo
          hitWall = 0, -- Booleana que verifica quando o inimigo bateu em uma parede
          HP = 1 
        }
        


function enemy:setImage(directory)
  ---- Seta o sprite da nave
  
  self.img = love.graphics.newImage(directory)
end

function enemy:draw()
  ---- Desenha o inimigo
  
  love.graphics.draw(self.img, self.x, self.y,0,self.scaleX,self.scaleY)
  love.graphics.print(tostring(self.x),10,10) -- Printar a posição X do inimigo
  love.graphics.print(tostring(self.hitWall),10,20) -- Printar a varíavel de "bater na parede"
  if self.y > 710 then
    love.graphics.print("GAME OVER", love.graphics.getWidth()/2,love.graphics.getHeight()/2)
  end
  
end
function enemy:move(direction)
  ---- Move o inimigo
  -- Muda a direção dele caso ele tenha chegando em limites pré estabelecidos 
  if self.hitWall == 0 then
  newValue = self.x + direction
  
  else if self.hitWall == 1 then
  newValue = self.x - direction
end
end

if self.x > 700 then
  self.hitWall = 1
  self.y = self.y + 50 --faz o inimigo mover-se para baixo, o ideal eh +-10, ta 50 pra testar mais rapido
end
if self.hitWall and self.x < 10 then
  self.hitWall = 0 
  self.y = self.y + 50 --faz o inimigo mover-se para baixo, o ideal eh +-10, ta 50 pra testar mais rapido
end

  -- Move apenas se não ultrapassar as bordas da tela e muda de direção
  if 0 < newValue and newValue < love.graphics.getWidth() - self.img:getWidth()*self.scaleX  then
    self.x = newValue  
  end
  
end

function enemy:shoot()
  ---- Função que aloca um novo tiro dado pelo enemy

  -- Calcula a tempo que se passou desde o último tiro e transforma o tempo de recarga para segundos
  timeElapsed = os.clock() - self.lastShoot
  rechargeTimeInSeconds = self.rechargeTime / 1000
  
  -- Atira apenas se passou o tempo de recarga
  if timeElapsed >= rechargeTimeInSeconds then
    -- Aloca um novo tiro e seta a posição dele acima e no centro da nave
    newShoot = enemy_Shoot:new()
    newShoot.x = self.x + newShoot.img:getWidth() * 3.5
    newShoot.y = self.y + newShoot.img:getHeight() * 1.5
    
    -- Insere o novo tiro no final da table de tiros dados
    table.insert(self.shotsFired, newShoot)
    
    -- Atualiza o tempo do último tiro
    self.lastShoot = os.clock()
  end
end

function enemy:drawShotsFired()
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