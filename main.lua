local RPG_local = require "RPG_Full_Logo/RPG_Logo"

local state

function love.load()
  RPG_Logo.load(1.5,1.5,1.5)
  state = RPG_Logo
  player.load()
  
end
function love.update(dt)
  state.update(dt)
  player.update(dt)
end
function love.draw()
  state.draw()
  player.draw()
end
function love.keypressed(key)
  state.keypressed(key)
end
function love.gamepadpressed(joystick,button)
  state.gamepadpressed(joystick,button)
end