local gc = require("generalCommands")
local treeLog = "menril_log"
function MainFunction()
  while true do 
    MoveBot(MovementForward, 1)
    CheckForBlock(InspectForward)
    if (InspectFound and string.match(InspectResults, treeLog)) then 
      ChopTreeRoot()
      BeginLevelLogChecks()
      while (InspectFound) do 
        BeginLevelLogChecks()
        CheckForBlock(InspectUp)
      end 
    end 
  end
end

function ChopTreeRoot() 
  Dig(DigForward)
  MoveBot(MovementForward)
  TurnRight()
  Dig(DigForward)
  MoveBot(MovementForward)
end 

function BeginLevelLogChecks()
  for loop = 1, 4 do 
    CheckForBlock(InspectForward)
    if (InspectFound) then 
      BreakLevelLog()
    end
    TurnRight()
  end 
end 
function BreakLevelLog()
  Dig(DigForward)
  MoveBot(MovementForward)
  TurnLeft()
  CheckForBlock(InspectForward)
  if (InspectFound) then 
    Dig(DigForward)
  end 
  TurnLeft()
  TurnLeft()
  CheckForBlock(InspectForward)
  if (InspectFound) then 
    Dig(DigForward)
  end 
  TurnRight()
  MoveBot(MovementForward)
  TurnRight()
  TurnRight()
end 
MainFunction()