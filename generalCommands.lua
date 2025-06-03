function MoveBot(direction, times)
print("IM GOING TO MOVE NOW "..direction.." "..times)
local switch = {
  ["Up"] =  function() turtle.up() end,
  ["Down"] = function() turtle.down() end,
  ["Left"] = function() turtle.turnLeft() end,
  ["Right"] = function() turtle.turnRight() end,
  ["Forward"] = function() turtle.forward() end
}
for execute = 0, times do
  switch[direction]();
end 
end 
