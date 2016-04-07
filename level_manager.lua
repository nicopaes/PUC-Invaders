require "player"
require "enemy"
require "shoot"

aliveEnemies = {}
shootPossible = {}
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
    line = {}
    for j = 1,8 do
      enemy = Enemy:new({
                       speed = 50 + 10*(self.level-1)
                      })
                      
      enemy.x = 50 + (j-1) * (enemy.img:getWidth() * enemy.scaleX + 20)
      enemy.y = 50 + (i-1) * (enemy.img:getHeight() * enemy.scaleY + 10)
      
      table.insert(line, enemy)
      table.insert(aliveEnemies, enemy)
    end
    table.insert(enemyList, line)
  end
  for t=1,16,1 do
    shootPossible[t] = 1
  end
  for t=17,24,1 do
    shootPossible[t] = 0
   end
end

function LevelManager:moveEnemies(dt)
  for i,line in ipairs(enemyList) do
    for j,enemy in ipairs(line) do 
      enemy:move(dt)
      
      if enemy:right() >= love.graphics.getWidth() - 20 or
        enemy:left() <= 20 then
       
          for k,line in ipairs(enemyList) do
            for l,enemy in ipairs(line) do
              enemy.speed = -enemy.speed
              enemy:moveDown()
            end
          end
      end
      
      if enemy.y > 710 then
        love.graphics.print("GAME OVER", love.graphics.getWidth()/2, love.graphics.getHeight()/2)
      end
    end
  end
  
  
end

function LevelManager:drawEnemies()
  for i,line in ipairs(enemyList) do
    for j,enemy in ipairs(line) do
      enemy:draw()
      enemy:drawShotsFired()
    end
  end
end

function LevelManager:detectCollision()
  
  for i,s in ipairs(player.shotsFired) do
    for j,line in ipairs(enemyList) do
      for k,enemy in ipairs(line) do
      
        if s and s:left() < enemy:right() and s:right() > enemy:left() and
          s:top() < enemy:bottom() and s:bottom() > enemy:top() then
            table.remove(player.shotsFired, i)
            s = nil -- evita que um tiro elimine múltiplos inimigos
            
            table.remove(line, k)
            table.remove(aliveEnemies,k)
            
            if #aliveEnemies == 0 then
              love.graphics.print("YOU WIN",400,400)
            end
        end
        
      end
    end
  end
end
function LevelManager:enemyShoot()
  index = love.math.random(1,#aliveEnemies)
  
  foe = aliveEnemies[index]
  blockfoe = shootPossible[index+8]
  if blockfoe == 0 then
     
  foe:shoot()
  end
 
end 