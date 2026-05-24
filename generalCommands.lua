FacingIndex = 1
FacingDirections = {"forward", "left", "back", "right"}

local movementdirection = {
  ["Up"] =  function() turtle.up() end,
  ["Down"] = function() turtle.down() end,
  ["Forward"] = function() turtle.forward() end,
  ["Backwards"] = function() turtle.back() end
}

Front = 1
Left = 2
Back = 3 
Right = 4
function TurnLeft()
  FacingIndex = CalculateValidFacingIndex(FacingIndex + 1)
  turtle.turnLeft()
end 

function TurnRight()
  FacingIndex = CalculateValidFacingIndex(FacingIndex - 1)
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
    while (FacingIndex == faceIndex) do 
      TurnLeft()
    end
  else 
    while (FacingIndex == faceIndex) do 
      TurnRight()
    end
  end
end

function MoveBot(direction, times)
  print("IM GOING TO MOVE NOW "..direction.." "..times)
    for execute = 1, times do
      movementdirection[direction]();
    end 
end 
