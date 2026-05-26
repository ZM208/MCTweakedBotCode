local gc = require("generalCommands")
local treeLog = "menril_log"
function MainFunction()
  while true do 
    MoveBot(MovementForward, 1)
    CheckForBlock(InspectForward)
    if (InspectFound and string.match(InspectResults, treeLog)) then 
      ChopTreeRoot()
      CheckForBlock(InspectUp)
      while (InspectFound) do 
        Dig(DigUp)
        MoveBot(MovementUp)
        BeginLevelLogChecks()
        CheckForBlock(InspectUp)
      end 
      ReturnBackToLine()
    end 
  end
end
function PickUpItems()
end
function Replant()
  FaceDirection(FacingRight)
end
function ReturnBackToLine()
  ReturnToRoot()
  PickUpItems()
  FaceDirection(FacingLeft)
  MoveBot(MovementForward) 
end
function ReturnToRoot()
  repeat
    CheckForBlock(InspectDown)
    if (InspectFound == false) then
      MoveBot(MovementDown)
    end 
  until InspectFound == true
end

function ChopTreeRoot() 
  Dig(DigForward)
  MoveBot(MovementForward)
  TurnRight()
  Dig(DigForward)
  MoveBot(MovementForward)
  BeginLevelLogChecks()
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