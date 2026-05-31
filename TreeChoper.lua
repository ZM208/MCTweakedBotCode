local gc = require("generalCommands")
local treeLog = "menril_log"
local endOfLine = "cobblestone"
local menrilSampling = "menril_sapling"
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
      Replant()
    elseif (InspectFound and string.match(InspectResults, endOfLine)) then
      EndOfLine()
    end 
  end
  
end
function EndOfLine()
  MoveBot(MovementUp)
  FaceDirection(FacingBack)
  CheckForBlock(InspectForward)
  while InspectFound == false do 
    MoveBot(MovementForward)
    CheckForBlock(InspectForward)
  end
  Reset()
end
function Reset()
  FaceDirection(FacingFront)
  MoveBot(MovementDown)
  EmptyInv(DropDown)
end
function Replant()
  FaceDirection(FacingRight)
  SafePlace(menrilSampling, PlaceForward)
  FaceDirection(FacingFront)
end
function ReturnBackToLine()
  ReturnToRoot()
  SuckAround()
  FaceDirection(FacingLeft)
  MoveBot(MovementForward) 
  FaceDirection(FacingFront)
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