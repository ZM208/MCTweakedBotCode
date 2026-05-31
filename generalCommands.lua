local facingIndex = 1

--- movement enums wish version
MovementUp = 1
MovementDown = 2
MovementForward = 3
MovementBackwards = 4
local movementDirection = {
  [1] =  function() turtle.up() end,
  [2] = function() turtle.down() end,
  [3] = function() turtle.forward() end,
  [4] = function() turtle.back() end
}

--- place enums wish version
PlaceUp = 1
PlaceDown = 2
PlaceForward = 3
local placeDirection = {
  [1] =  function() turtle.placeUp() end,
  [2] = function() turtle.placeDown() end,
  [3] = function() turtle.place() end,
}

--- drop enums wish version
DropUp = 1
DropDown = 2
DropForward = 3
local dropDirection = {
  [1] =  function() turtle.dropUp() end,
  [2] = function() turtle.dropDown() end,
  [3] = function() turtle.drop() end,
}
-- dig enums wish version 
DigUp = 1
DigDown = 2
DigForward = 3
local digDirection = {
  [1] =  function() turtle.digUp() end,
  [2] = function() turtle.digDown() end,
  [3] = function() turtle.dig() end,
}
-- inspect enums wish version
InspectFound = false 
InspectResults = nil
InspectUp = 1
InspectDown = 2
InspectForward = 3
local inspectDirection = {
  [1] =  function() return turtle.inspectUp() end,
  [2] = function() return turtle.inspectDown() end,
  [3] = function() return turtle.inspect() end,
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
  if (faceIndex == CalculateValidFacingIndex(facingIndex + 1)) then
    while (facingIndex ~= faceIndex) do 
      TurnLeft()
    end
  else 
    while (facingIndex ~= faceIndex) do 
      TurnRight()
    end
  end
end

function MoveBot(direction, times)
  if (times == nil) then 
    times = 1
  end 
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
  InspectFound,InspectResults = inspectDirection[inspectIndex]()
  if (InspectResults == nil) then 
    print("not found")
    InspectFound = false
    InspectResults = ""
  else 
    InspectResults = InspectResults.name
  end
  print(InspectResults)
end

function FindItem(itemToFind)
  for loop = 1, 16 do 
    local itemDetail = turtle.getItemDetail(loop)
    if (itemDetail ~= nil and string.match(itemDetail.name, itemToFind)) then 
      return loop
    end
  end
  print("not found")
  return nil
end

function SafePlace(itemName,placeIndex)
   local slot = FindItem(itemName)
   if (slot == nil) then 
    return false;
   end
   Place(slot, placeIndex)
end

function Place(itemSlot,placeIndex )
  turtle.select(itemSlot)
  placeDirection[placeIndex]()
end 

function EmptyInv(dropIndex)
  for loop = 1,16 do 
    dropItem(loop, dropIndex)
  end
end

function dropItem(itemSlot, dropIndex)
  turtle.select(itemSlot)
  local itemDetails = turtle.getItemDetail()
  if (itemDetails == nil) then 
    return nil
  end
  dropDirection[dropIndex]()
end

function SuckAround()
  for loop = 1,4 do 
    turtle.suck()
    TurnLeft()
  end 
end 