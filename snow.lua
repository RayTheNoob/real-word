function snowUpdate(dt)
  stimer = stimer - 1
  if stimer == 0 then
    stimer = 1
    print(#snow)
    
    snow[#snow+1] = {math.random(0,love.graphics.getWidth()),-20}
  end
  
  for i = 1, #snow do
    local x, y = (snow[i])[1], (snow[i])[2]
    
    y = y + 1
    
    snow[i] = {x,y}
    
    if y > love.graphics.getHeight() then
      --snow[i] = nil
      table.remove(snow,2)
    end
  end
end

function snowDraw()
  for i = 1, #snow do
    local x = (snow[i])[1]
    local y = (snow[i])[2]
    
    love.graphics.circle("fill",x,y,5)
  end
end