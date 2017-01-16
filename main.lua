
function love.load()
    math.randomseed(os.time())
    
    -- Reference lookups
    require "colors"

    Object = require "classic"
    require "shape"
    require "rectangle"
    require "circle"
    require "head"

    -- r1 = Rectangle(100,100,100,75,100)
    -- r2 = Rectangle(100,300,75,125,25)
    -- c1 = Circle(100,500,50)

    head = Head(400,400)
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
    head:draw("left")
end