function CheckCollision(ax1,ay1,aw,ah, bx1,by1,bw,bh)
  ---- Checa colisão entre dois objetos (retângulo).

  -- Calcula as bordas dos objetos (retângulo) e compara os valores para checar se eles se sobrepõem.
  -- Retorna verdadeiro ou falso.
  local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
  return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end