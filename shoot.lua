Shoot = {
          x = 0,
          y = 0,
          speed = 400,
          img = love.graphics.newImage('assets/shoot.png')
       }

function Shoot:new()
  obj = {}
  setmetatable(obj, self)
  self.__index = self
  return obj
end

function Shoot:draw()
  love.graphics.draw(self.img, self.x, self.y)
end

function Shoot:updatePosition(dt)
  self.y = self.y - self.speed * dt
end