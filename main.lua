debug = true  -- mudar pra false no release


player = {x = 200, y = 710, speed = 150, img = nil}


function love.load(arg)
  player.img = love.graphics.newImage('assets/plane.png')
end
function love.update(dt)
  --saindo do jogo quando o player apertar esc
    if love.keyboard.isDown('escape') then
      love.event.push('quit')
    end
    --movimentação lateral do player
    if love.keyboard.isDown('left','a') then
      --limitação lateral a esquerda dentro da área da janela
      if player.x > 0 then
      player.x = player.x - (player.speed*dt)
    end
  elseif love.keyboard.isDown('right','d') then
    --limitação lateral a direita dentro da area da janela
      --diminui a area total da janela pela area da img do player
    if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
      player.x = player.x + (player.speed*dt)
    end
    
  end
    
end

function love.draw(dt)
  --Desenha a hit box do player (um retângulo no modo fill
  --love.graphics.rectangle("fill",player.x,player.y,50,50)
  --desenha o player
  love.graphics.draw(player.img, player.x, player.y)
end
