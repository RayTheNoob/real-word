-- this is satire of bad games
-- i couldn't bring myself to make it as bad as mobile games
-- started on March 4, 2023
-- my first ever game finished in one day
-- although it is an extemly simple project (finished before midnight)
-- maybe i will try a game jam soon

function love.load()
  require "letters"
  setUpLetters()
  
  require "setBG"
  setBG()
  
  require "snow"
  stimer = 1
  
  love.window.setTitle("Real Word learning game!")
  love.window.setMode(800, 600, {resizable=true, vsync=0, minwidth=400, minheight=300})
  
  snow = {}
  
  love.keyboard.setKeyRepeat(false)
  
  Flight = love.graphics.newFont("assets/Inter/Inter-Regular.ttf", 20, "normal", 1)
  Btext = love.graphics.newFont("assets/Inter/Inter-SemiBold.ttf", 85, "normal", 1)
  
  
  scg = love.graphics.newImage("assets/scg.png")
  title = love.graphics.newImage("assets/title.png")
  
  --bgm = love.audio.newSource("assets/Space Sprinkles.mp3", "stream")
  bgm = love.audio.newSource("assets/snow.ogg", "stream")
  bell = love.audio.newSource("assets/bell.ogg", "static")
  bellPlace = 0
  bellNotes = {1,2,1,1,2.3,1,1,1.8,0.9,0.95,1,0.8,1,1.5,2.5,2.6,0.75,1,3,3,3,3,3,2,1,3,3,3,3,1,0.85}
  
  state = "menu"
end

function love.update(dt)
  --snowUpdate(dt)
  if state == "menu" then
    local trash = math.random(1,100)
    
    if love.keyboard.isDown("escape") then love.event.quit() end
    
    if not bell:isPlaying() then
      bellPlace = bellPlace + 1
      if bellPlace > #bellNotes then bellPlace = 1 end
      bell:setPitch(bellNotes[bellPlace])
      bell:play()
    end
    
    if love.keyboard.isDown("space") then
      state = "game"
      
      letterBank = {}
      letterOut = {"-","-","-","-"}
      
      for i=1, 6 do
        letterBank[i] = letter[math.random(1,#letter)]
        --print(letterBank[i])
      end
      --letterBank = {"1", "2", "3", "4", "5", "6"}
    end
    
    pointerPos = 1
    letterOutPos = 1
    
    keyCanBePressed = false
    
    gameOverTimer = 0
  end
  
  if state == "game" then
    if not bgm:isPlaying() then bgm:play() end
    
    if love.keyboard.isDown("right") and keyCanBePressed and pointerPos < 6 then pointerPos = pointerPos + 1; keyCanBePressed = false end
    if love.keyboard.isDown("left") and keyCanBePressed and pointerPos > 1 then pointerPos = pointerPos - 1; keyCanBePressed = false end
    
    if love.keyboard.isDown("space") and keyCanBePressed then letterOut[letterOutPos] = letterBank[pointerPos]; letterOutPos = letterOutPos + 1; keyCanBePressed = false end
    end
  
  if not love.keyboard.isDown("right","space", "left") then keyCanBePressed = true end
  
  if letterOutPos > 4 then
    gameOverTimer = gameOverTimer + 1
      if gameOverTimer > 1700 then state = "menu"; bgm:stop(); bellPlace = 0; love.audio.setVolume(1) end
  end
  
end

function love.draw()
  love.graphics.draw(bg, 0, 0, 0, love.graphics.getWidth()/bg:getWidth(), love.graphics.getHeight()/bg:getHeight())
  --snowDraw()
  if state == "menu" then
    love.graphics.setColor(1,1,1,0.3)
    love.graphics.print(text[1], Flight, love.graphics.getWidth()/2-Flight:getWidth(text[1])/2, love.graphics.getHeight()/2)
    love.graphics.print(text[2], Flight, love.graphics.getWidth()/2-Flight:getWidth(text[2])/2, love.graphics.getHeight()/2+25)
    love.graphics.print(text[7], Flight, love.graphics.getWidth()/2-Flight:getWidth(text[7])/2, love.graphics.getHeight()-100)
    love.graphics.print(text[8], Flight, love.graphics.getWidth()/2-Flight:getWidth(text[8])/2, love.graphics.getHeight()-75)
    love.graphics.print(text[9], Flight, love.graphics.getWidth()/2-Flight:getWidth(text[9])/2, love.graphics.getHeight()-50)
    love.graphics.print(text[10], Flight, love.graphics.getWidth()/2-Flight:getWidth(text[10])/2, love.graphics.getHeight()-25)
    
    love.graphics.setColor(1,1,1)
    
    love.graphics.print(text[3], Flight, love.graphics.getWidth()/2-Flight:getWidth(text[3])/2, love.graphics.getHeight()/2+50)
    
    love.graphics.draw(scg,love.graphics.getWidth()-scg:getWidth()/2,love.graphics.getHeight()-scg:getHeight()/2,0,0.5)
    love.graphics.draw(title,love.graphics.getWidth()/2-title:getWidth(),10,0,2)
  end
  
  if state == "game" then
    love.graphics.setColor(0,0,0,0.5)
    love.graphics.rectangle("fill",0, love.graphics.getHeight()/2, love.graphics.getWidth(),love.graphics.getHeight()/2)
    love.graphics.setColor(1,1,1)
    
    for i = 1, 6 do
      local y = love.graphics.getHeight()/2
      if i == pointerPos then y = y - 20 end
      
      love.graphics.print(letterBank[i], Btext,love.graphics.getWidth()/6*(i-1),y)
    end
    
    --love.graphics.print("_", Btext,love.graphics.getWidth()/6*(pointerPos-1),love.graphics.getHeight()/2)
    
    for i = 1, 4 do
      love.graphics.print(letterOut[i], Btext,love.graphics.getWidth()/4*(i-1),love.graphics.getHeight()/4)
    end
    
    love.graphics.print(text[6], Flight, love.graphics.getWidth()/2-Flight:getWidth(text[6])/2, love.graphics.getHeight()-25)
    love.graphics.print(text[5], Flight, love.graphics.getWidth()/2-Flight:getWidth(text[5])/2, love.graphics.getHeight()-75)

  end
  

  
  if gameOverTimer > 1 then
    love.graphics.setColor(gameOverTimer/3000,0,0,gameOverTimer/1000)
    love.graphics.rectangle("fill", 0,0,love.graphics.getWidth(),love.graphics.getHeight())
    love.graphics.setColor(1,1,1,gameOverTimer/1000)
    love.graphics.print(text[4], Flight, love.graphics.getWidth()/2-Flight:getWidth(text[4])/2, love.graphics.getHeight()/2)
    love.graphics.setColor(1,1,1)
  end
end