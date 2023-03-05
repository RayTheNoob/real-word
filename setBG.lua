function setBG () 
  local seed = os.date('*t')
  math.random(seed.sec+2)
  
  local bgPick = math.random (1,3)
  
  bgPick = 2
  
  if bgPick == 1 then
    bg = love.graphics.newImage("assets/trees.jpg")
  elseif bgPick == 2 then
    bg = love.graphics.newImage("assets/road.jpg")
  elseif bgPick == 3 then
    bg = love.graphics.newImage("assets/sea.jpg")
  end
end