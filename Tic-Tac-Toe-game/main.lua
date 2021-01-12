
love.window.setTitle("Tic Tac Toe Game")

function drawBoard()
  love.graphics.rectangle("line", 250, 50, 300, 300)

  love.graphics.line(350, 50, 350, 350)
  love.graphics.line(450, 50, 450, 350)
  love.graphics.line(550, 50, 550, 350)

  love.graphics.line(250, 150, 550, 150)
  love.graphics.line(250, 250, 550, 250)
  love.graphics.line(250, 350, 550, 350)
end

function printInitialMessage()
  love.graphics.print(initialMessage, 325, 400, 0, 2, 2)
end

function love.mousepressed(x, y, button, istouch,presses)
  -- 50, 250 --> 50, 550
  -- 350, 250--> 350, 550
  if x <= 250 or x >= 250 then return
  if y <= 50  or y >= 350 then return 
end

function love.load()
  math.randomseed(os.time())
  local firstTurn = math.random(1,2)
  initialMessage = ""
  if firstTurn == 1 then
    initialMessage = "I start first"
  else
    initialMessage = "You start first"
  end

end

function love.update()
end

function love.draw()
  -- Draw the board
  drawBoard()
  printInitialMessage()
end
