local facingIndex = 1

--- movement enums wish version
MovementUp = 1
MovementDown = 2
MovementForward = 3
MovementBackwards = 4
local movementdirection = {
  ["Up"] =  function() turtle.up() end,
  ["Down"] = function() turtle.down() end,
  ["Forward"] = function() turtle.forward() end,
  ["Backwards"] = function() turtle.back() end
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
      movementdirection[direction]();
    end 
end 
-- basics 
function CheckFuelLevel()
  local currentFuelLevel = turtle.getFuelLevel()
  if (currentFuelLevel < 50) then 

  end
end 
function GoBackToStart()

end
function Dig()
  turtle.()
end