function love.load()
    -- Creates an object model for OOP
    Object = require "classic"

    -- Load the game settings
    require "gamesettings"
    settings = GameSettings()

    -- More info here: https://love2d.org/wiki/love.window.setMode
    -- TODO: Reconcile with the conf.lua settings
    love.window.setMode(settings.winW,settings.winH,{msaa=4})

    -- Causes the math.random function to actually be random
    math.randomseed(os.time())

    -- Reference lookups
    require "colors"
    require "actors.person"
    require "oscillator"

    -- For the map
    require "map.playfield"

    -- Instantiate the Menus
    require "menus.mainmenu"
    mainmenu = MainMenu()

    -- Tests
    if settings.test_characterGrid then
        test_characterGridSetup()
    end

end

function love.update(dt)
    if settings.test_characterGrid then
        for i=1,#people do
            local person = people[i]
            person:update(dt)
        end  
    end
end


function love.draw()
    -- love.graphics.setBackgroundColor( 0,0,0 )

    if settings.show_MainMenu then
        mainmenu:draw()
    end

    -- Tests
    if settings.test_characterGrid then
        test_characterGridDraw()
    end
end









-- TESTS

function love.keypressed( key, scancode, isrepeat )
    if key == "space" then
        if settings.test_characterGrid then
            for i=1,#people do
                local person = people[i]

                local ani_idx   = math.random(1,table.getn(settings.test_animationStates))
                local ani_state = settings.test_animationStates[ani_idx]
                person:setAnimationState(ani_state)

                local dir_idx   = math.random(1,table.getn(settings.test_directions))
                local dir_state = settings.test_directions[dir_idx]
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
    love.graphics.setBackgroundColor( 255,255,255 )
    for i=1,#people do
        local person = people[i]
        person:draw()
    end
end