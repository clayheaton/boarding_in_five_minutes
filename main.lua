
function love.load()
    math.randomseed(os.time())
    
    -- require "example_code.shape"
    -- require "example_code.rectangle"
    -- require "example_code.circle"
    
    -- Reference lookups
    require "colors"

    Object = require "classic"
    require "actors.head"

    heads = {}

    for i=1,12 do
        for j=1,12 do
            local x = 50 + (i-1) * 100
            local y = 50 + (j-1) * 120
            local head = Head(x,y)
            table.insert(heads,head)
        end
    end

    -- r1 = Rectangle(100,100,100,75,100)
    -- r2 = Rectangle(100,300,75,125,25)
    -- c1 = Circle(100,500,50)

    -- head = Head(400,400)
end

function love.update(dt)
    -- r1:update(dt)
    -- r2:update(dt)
    -- c1:update(dt)
end


function love.draw()
    love.graphics.setBackgroundColor( 255,255,255 )
    -- r1:draw()
    -- r2:draw()
    -- c1:draw()
    -- head:draw("left")
    for i=1,#heads do
        local head = heads[i]
        head:draw("left")
    end
end


