--Configuração
function love.conf(t)
  
  
    t.title = "PUC INVADERS" 
    t.version  = "0.10.1"
    --definiçao da area da janela
    t.window.width = 800
    t.window.height = 800
    
    
    --para debugging do Windows lembrar de mudar para false para o release
    t.console = true
  end
