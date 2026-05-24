local facingIndex = 1

--- movement enums wish version
MovementUp = 1
MovementDown = 2
MovementForward = 3
MovementBackwards = 4
local movementDirection = {
  ["Up"] =  function() turtle.up() end,
  ["Down"] = function() turtle.down() end,
  ["Forward"] = function() turtle.forward() end,
  ["Backwards"] = function() turtle.back() end
}
-- dig enums wish version 
DigUp = 1
DigDown = 2
DigForward = 3
local digDirection = {
  ["Up"] =  function() turtle.digUp() end,
  ["Down"] = function() turtle.digDown() end,
  ["Forward"] = function() turtle.dig() end,
}
-- inspect enums wish version
InspectFound = false 
InspectResults = nil
InspectUp = 1
InspectDown = 2
InspectForward = 3
local inspectDirection = {
  ["Up"] =  function() return turtle.inspectUp() end,
  ["Down"] = function() return turtle.inspectDown() end,
  ["Forward"] = function() return turtle.inspect() end,
}
--- facing  enums wish version
FacingFront = 1
FacingLeft = 2
FacingBack = 3 
FacingRight = 4
local FacingDirections = {"forward", "left", "back", "right"}
-- movement based commands 
function TurnLeft()
  facingIndex = CalculateValidFacingIndex(facingIndex + 1)
  turtle.turnLeft()
end 

function TurnRight()
  facingIndex = CalculateValidFacingIndex(facingIndex - 1)
  turtle.turnRight()
end

function CalculateValidFacingIndex(index)
  if (index == 5) then
    return 1
  end
  if (index == 0) then
    return 4
  end
  return index
end

function FaceDirection(faceIndex)
  if (faceIndex == CalculateValidFacingIndex(faceIndex + 1)) then
    while (facingIndex == faceIndex) do 
      TurnLeft()
    end
  else 
    while (facingIndex == faceIndex) do 
      TurnRight()
    end
  end
end

function MoveBot(direction, times)
    for execute = 1, times do
      movementDirection[direction]();
      CheckFuelLevel()
    end 
end 
-- basics 
function CheckFuelLevel()
  local currentFuelLevel = turtle.getFuelLevel()
  if (currentFuelLevel < 50) then 
    while (turtle.detectDown() == false) do 
      turtle.down()
    end 
    while (turtle.getFuelLevel() < 50) do 
      print("Fuel needed to refuel")
      local pauser = read()
      turtle.refuel()
    end 
  end
end 

function Dig(digIndex)
  digDirection[digIndex]()
  CheckFuelLevel()
end
-- use enum
function CheckForBlock(inspectIndex)
  InspectFound,InspectResults = inspectDirection[inspectIndex]
end