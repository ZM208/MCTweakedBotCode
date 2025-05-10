function MineArea(length, height, width, up, right)
    length = length - 1
    for hei = 1, height do 
        for wid = 1, width do 
            for len = 1, length do 
                turtle.dig();
                turtle.forward()
            end 
            if right then 
                turtle.turnRight()
                if (wid) ~= width then  
                    turtle.dig()
                    turtle.forward()
                    turtle.turnRight()
                    right = false
                end
            else 
                turtle.turnLeft()
                if (wid) ~= width then
                    turtle.dig()
                    turtle.forward()
                    turtle.turnLeft()
                    right = true
                end 
            end 
        end 
        
        if (right) then 
            turtle.turnRight()
        else 
            turtle.turnLeft()
        end 
        if hei ~= height then 
        print(hei)
            if (up) then 
                turtle.digUp()
                turtle.up()
            else 
                turtle.digDown()
                turtle.down()
            --right = false
            end 
        end 
    end 
    if (height % 2) == 1 then 
        moveForward(length)
    end  
    if right then 
        turtle.turnRight()
    else 
        turtle.turnLeft()
    end 
    if (height % 2) == 1 then
        moveForward(width - 1)
    end 
    for move = 1, height - 1 do 
        if up then 
            turtle.down()
        else 
            turtle.up()
        end 
    end 
end
function moveForward(forwardAmount)
    for move = 1, forwardAmount do 
        turtle.forward()
    end
end

