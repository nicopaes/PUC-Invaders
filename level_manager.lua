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
  
  enemyList = {}
  for i = 1,5 do
    enemy = Enemy:new({
                       speed = 200
                      })
                      
    enemy.x = 50 + (i-1) * (enemy.img:getWidth() * enemy.scaleX + 20)
    
    table.insert(enemyList, enemy)
  end
end

function LevelManager:moveEnemies(dt)
  for i,enemy in ipairs(enemyList) do
    enemy:move(enemy.speed*dt)
    
    enemy:shoot()
    
    if enemy.y > 710 then
      love.graphics.print("GAME OVER", love.graphics.getWidth()/2,love.graphics.getHeight()/2)
    end
  end
end

function LevelManager:drawEnemies()
  for i,enemy in ipairs(enemyList) do
    enemy:draw()
    enemy:drawShotsFired()
  end
end

function LevelManager:detectCollision()
  
  for i,s in ipairs(player.shotsFired) do
    for j,enemy in ipairs(enemyList) do
      if s:left() < enemy:right() and s:right() > enemy:left() and
        s:top() < enemy:bottom() and s:bottom() > enemy:top() then
          table.remove(player.shotsFired, i)
          
          table.remove(enemyList, j)
          
          if table.getn(enemyList) == 0 then
            print "YOU WIN"
          end
      end
    end
  end
end