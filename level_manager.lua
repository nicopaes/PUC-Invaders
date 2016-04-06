require "player"
require "enemy"
require "shoot"

LevelManager = {
            level = 1
          }
 
function LevelManager:new(obj)
  obj = obj or {}
  
  setmetatable(obj, self)
  self.__index = self
  
  return obj
end
 
function LevelManager:loadAgents()
	player:setImage('assets/plane.png')
  
  enemy = Enemy:new({speed = 200})
  enemy:setImage('assets/Invader1.png')
end

function LevelManager:moveEnemies(dt)
  enemy:move(enemy.speed*dt)
  enemy:shoot()
end

function LevelManager:drawEnemies()
  enemy:draw()
  enemy:drawShotsFired()
end

function LevelManager:detectCollision()
  
  for i,s in ipairs(player.shotsFired) do
    if s:left() < enemy:right() and s:right() > enemy:left() and
      s:top() < enemy:bottom() and s:bottom() > enemy:top() then
        table.remove(player.shotsFired, i)
    end
  end
end