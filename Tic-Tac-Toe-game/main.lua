
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
  love.graphics.print("O for me, X for you.", 280, 440, 0, 2, 2)
end
function printFinalMessage()
  love.graphics.print(finalMessage, 325, 480, 0, 2, 2)
end

function initMatrix()
  for i=1, 3 do
    matrix[i] = {}
    for j=1, 3 do
      matrix[i][j] = {}
      matrix[i][j].x = 200 + 100 * j
      matrix[i][j].y = 100 * i
      matrix[i][j].sym = '.'
    end
  end
end

function matrixIsFull()
  for i=1, 3 do
    for j=1, 3 do
      if matrix[i][j].sym == '.' then
        return false
      end
    end
  end
  return true
end

function checkRow(i)
  local o, x
  o = 0 x = 0
  for j=1, 3 do
    if matrix[i][j].sym == 'X' then 
      x = x + 1
    elseif matrix[i][j].sym == 'O' then
      o = o + 1
    end
  end
  return o, x
end

function checkCol(j)
  local o, x
  o = 0 x = 0
  for i=1, 3 do
    if matrix[i][j].sym == 'X' then
      x = x + 1
    elseif matrix[i][j].sym == 'O' then
      o = o + 1
    end
  end
  return o, x
end

function checkDiag()
  local o1, o2, x1, x2
  o1 = 0 o2 = 0 x1 = 0 x2 = 0
  for i=1, 3 do
    if matrix[i][i].sym == 'X' then x1 = x1 + 1
    elseif matrix[i][i].sym == 'O' then o1 = o1 + 1
    end
  end
  
  if matrix[1][3].sym == 'X' then x2 = x2 + 1 elseif matrix[1][3].sym == 'O' then o2 = o2 + 1 end
  if matrix[2][2].sym == 'X' then x2 = x2 + 1 elseif matrix[2][2].sym == 'O' then o2 = o2 + 1 end
  if matrix[3][1].sym == 'X' then x2 = x2 + 1 elseif matrix[3][1].sym == 'O' then o2 = o2 +1 end
  
  return o1, x1, o2, x2
end

function gameCompleted()
  local o1, x1, o2, x2 = checkDiag()
  if o1==3 or o2==3 then return 'O' end
  if x1==3 or x2==3 then return 'X' end

  for i=1, 3 do
    o1, x1 = checkRow(i)
    if o1==3 then return 'O' elseif x1==3 then return 'X' end
    o1, x1 = checkCol(i)
    if o1==3 then return 'O' elseif x1==3 then return 'X' end
  end

  return '.'
end

function checkThreatAndChance()
  local o, x
  for i=1, 3 do
    o, x = checkRow(i)
    if x == 2 or o == 2 then
      for j=1, 3 do
        if matrix[i][j].sym == '.' then 
          matrix[i][j].sym = 'O'
          return true
        end
      end
    end
    
    o, x = checkCol(i)
    if x == 2 or o == 2 then
      for j=1, 3 do
        if matrix[j][i].sym == '.' then
          matrix[j][i].sym = 'O'
          return true
        end
      end
    end
  end
  
  o1, x1, o2, x2 = checkDiag()
  if x1==2 or o1==2 then
    for i=1, 3 do
      if matrix[i][j].sym == '.' then
        matrix[i][j].sym = 'O'
        return true
      end
    end
  end

  if x2==2 or o2==2 then
    if matrix[1][3].sym == '.' then matrix[1][3].sym = 'O' end
    if matrix[2][2].sym == '.' then matrix[2][2].sym = 'O' end
    if matrix[3][1].sym == '.' then matrix[3][1].sym = 'O' end
    return true
  end
  return false
end

function love.mousepressed(x, y, button, istouch,presses)
  -- 50, 250 --> 50, 550
  -- 350, 250--> 350, 550
  if gameEnded then return end

  if x <= 250 or x >= 550 then return end
  if y <= 50  or y >= 350 then return end 

  local I = 0
  local J = 0

  if x < 350 then J = 1
  elseif x < 450 then J = 2
  else J = 3 end

  if y < 150 then I = 1
  elseif y < 250 then I = 2
  else I = 3 end

  if matrix[I][J].sym == '.' then
    matrix[I][J].sym = 'X'
    userPlayed = true
  end
end

function love.load()
  math.randomseed(os.time())
  matrix = {}
  initMatrix(matrix)

  local firstTurn = math.random(1,2)
  gameEnded = false
  userPlayed = false

  initialMessage = ""
  finalMessage = " "

  if firstTurn == 1 then
    initialMessage = "I start first"
    matrix[math.random(1,3)][math.random(1,3)].sym = 'O'
  else
    initialMessage = "You start first"
  end
end

function love.update()
  local char = gameCompleted()
  if char ~= '.' then
    gameEnded = true
    if char == 'X' then 
      finalMessage = "You win!"
    else finalMessage = "You loose!"
    end
  elseif matrixIsFull() then
    finalMessage = "Draw!"
  else
    if userPlayed then
      local done = checkThreatAndChance()
      while not done do
        local I, J
        I = math.random(1,3)
        J = math.random(1,3)
        if matrix[I][J].sym == '.' then
          matrix[I][J].sym = 'O'
          done = true
        end
      end
      userPlayed = false
    end
  end
end

function love.draw()
  -- Draw the board
  drawBoard()
  printInitialMessage()
  for i=1, 3 do
    for j=1, 3 do
      if matrix[i][j].sym ~= '.' then
        love.graphics.print(matrix[i][j].sym, matrix[i][j].x-20, matrix[i][j].y-30, 0, 4, 4)
      end
    end
  end

  if gameEnded then
    printFinalMessage()
  end
end
