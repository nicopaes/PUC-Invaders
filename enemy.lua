enemy = {
          x = 50,
          y = 50, 
          speed = 400, -- Está alta, para faciolitar os testes (ideal +- 50)
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