Shoot = {
          x = 0,
          y = 0,
          speed = 400,
          img = love.graphics.newImage('assets/shoot.png')
       }

function Shoot:new()
  ---- Aloca um novo objeto do tipo Shoot
  
  -- O conceito de classe não existe em Lua, portanto não temos como utilizar o construtor "new" nativamente.
  -- Porém, não é difícil de emular classes em Lua, graças às metatables.
  -- A metatable de um objeto é uma table onde serão procuradas ações não definidas no objeto em si.
  -- Por exemplo, nesse caso estamos instanciando um objeto "obj" vazio.
  obj = {}
  
  -- Ao executar "obj:draw()", o interpretador vai procurar uma função draw dentro de "obj" e descobrir que a mesma não existe.
  -- Nesse caso, o interpretador irá seguir para a metatable de "obj". Que nesse caso estamos setando como "self", ou seja "Shoot".
  -- Na metatable de "obj", o interpretador procurará pelo metamethod "__index", que estamos definindo como o próprio "self" ("Shoot").
  -- Como "draw()" é uma função definida em "Shoot", essa função será executada.
  -- Da mesma forma, todo atributo de Shoot pode ser acessado seguindo esse fluxo
  setmetatable(obj, self)
  self.__index = self
  
  return obj
end

function Shoot:draw()
  ---- Desenha o tiro
  
  love.graphics.draw(self.img, self.x, self.y)
end

function Shoot:updatePosition(dt)
  ---- Atualiza a posição do tiro
  
  self.y = self.y - self.speed * dt
end