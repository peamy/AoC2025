state = 50
input = {}
processing = false
total = 0
done = false

center_x = 400
center_y = 300
radius = 100

function love.draw()
    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill", center_x, center_y, radius, 100)
    love.graphics.print("0", center_x - 5, center_y - (radius * 1.3))
    love.graphics.print("50", center_x - 5, center_y + (radius * 1.2))
    love.graphics.print("25", center_x + (radius * 1.2), center_y )
    love.graphics.print("75", center_x - (radius * 1.2), center_y )

    love.graphics.setColor(0,0,0)
    love.graphics.line(center_x,center_y,center_x,center_y - radius)


    love.graphics.setColor(1,0,0)
    if #input <= 0 then
        love.graphics.setColor(0,1,0)        
    end

    love.graphics.print(total, center_x - 5, center_y - (radius * 1.5))
    
    local s = math.sin(math.rad(state * 3.6)) * radius
    local c = math.cos(math.rad(state * 3.6)) * -radius

    love.graphics.line(center_x,center_y,center_x + s,center_y + c)
end


function love.load()
    for line in love.filesystem.lines("input.txt") do
        value = tonumber(line:sub(2))
        if line:sub(1,1) == "L" then
            value = -value
        end
        table.insert(input, value)
    end
end

function love.keyreleased(key)
    if key == "space" then
        processing = true
    end
end

function love.update()
    if not processing or done then
        return
    end

    if #input <= 0 then
        print("done")
        done = true
        processing = false
        print(total)
       return 
    end

    movement = table.remove(input, 1)
    newstate = (100 + state + movement) % 100
    state = newstate
    if state == 0 then
        total = total + 1
    end
    --  processing = false
end