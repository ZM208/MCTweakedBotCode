local positionlist = {}

MineArea(length, height, width)

function MineArea(length, height, width, up, right)
    for hei = 0, hei < height do 
        for wid = 0, wid < width do 
            for len = 0, len < length do 
                turtle.dig();
                turtle.forward()
            end 
            if right then 
                turtle.turnright()
                turtle.dig()
                turtle.forward()
                turtle.turnright()
                right = false
            else 
                turtle.turnleft()
                turtle.dig()
                turtle.forward()
                turtle.turnleft()
                right = true
            end 
        end 
        turtle.digUp()
        turtle.turnleft()
        turtle.down()
    end 
end