
directions      = {"left","right"}
animationStates = {"sitting","walking","standing"}

function love.load()
    -- More info here: https://love2d.org/wiki/love.window.setMode
    -- TODO: Reconcile with the conf.lua settings
    love.window.setMode(1280,1000,{msaa=4})

    math.randomseed(os.time())
    test_characterGrid = true

    -- require "example_code.shape"
    -- require "example_code.rectangle"
    -- require "example_code.circle"

    -- Reference lookups
    require "colors"

    Object = require "classic"
    require "actors.person"
    require "oscillator"

    -- For the map
    require "map.playfield"


    -- Tests
    if test_characterGrid then
        test_characterGridSetup()
    end

    -- r1 = Rectangle(100,100,100,75,100)
    -- r2 = Rectangle(100,300,75,125,25)
    -- c1 = Circle(100,500,50)

    -- head = Head(400,400)
end

function love.update(dt)
    if test_characterGrid then
        for i=1,#people do
            local person = people[i]
            person:update(dt)
        end  
    end
end


function love.draw()
    love.graphics.setBackgroundColor( 255,255,255 )

    -- Tests
    if test_characterGrid then
        test_characterGridDraw()
    end
end


-- TESTS

function love.keypressed( key, scancode, isrepeat )
    if key == "space" then
        if test_characterGrid then
            for i=1,#people do
                local person = people[i]

                local ani_idx   = math.random(1,table.getn(animationStates))
                local ani_state = animationStates[ani_idx]
                person:setAnimationState(ani_state)

                local dir_idx   = math.random(1,table.getn(directions))
                local dir_state = directions[dir_idx]
                person:setDirection(dir_state)
            end  
        end
    end
end

function test_characterGridSetup()
    people = {}

    for i=1,3 do
        for j=1,3 do
            local x = 300 + (i-1) * 300
            local y = 300 + (j-1) * 300
            local person = Person()
            person.x = x
            person.y = y
            table.insert(people,person)
        end
    end
end

function test_characterGridDraw()
    for i=1,#people do
        local person = people[i]
        person:draw()
    end
end