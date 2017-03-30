function love.load()
    -- print(luaInfo())

    -- Creates an object model for OOP
    Object = require "classic"


    require "colors"
    require "oscillator"
    require "game"
    require "gamesettings"
    require "ui.screen_mainmenu"
    require "ui.screen_loadingscreen"
    require "scenes.TestScene"
    require "scenes.PlayScene"

    game     = Game()
    settings = GameSettings()

    -- More info here: https://love2d.org/wiki/love.window.setMode
    -- TODO: Reconcile with the conf.lua settings
    love.window.setMode(settings.winW,settings.winH,{msaa=4})

    -- Causes the math.random function to actually be random
    math.randomseed(os.time())

    -- Create Font objects
    main_title_font = love.graphics.newFont("fonts/Skia.ttf", 48)
    sub_title_font  = love.graphics.newFont("fonts/SFNSText.ttf", 24)
    loading_font    = love.graphics.newFont("fonts/SFNSText.ttf", 16)

    -- Establish the initial screen that will appear
    active_scene = MainMenu() 
end

function love.update(dt)
    -- TODO: Figure out how to send through any key
    if love.keyboard.isDown('w', 'a', 's', 'd', 'q', 'e') then
        -- Tell the active scene that one of these buttons is down
        active_scene:checkKeyDown()
    end

    active_scene:update(dt)
end


function love.draw()
    active_scene:draw()
end

-- Starting a new game
-- Called when clicking on the Start button
function startNewGame()
    active_scene = LoadingScreen()
    game:init(active_scene)
    
    active_scene = PlayScene()
end

-- Quit the game
-- Perform any necessary prompting or cleanup here.
-- Called when clicking on the Quit button
function quitGame()
    love.event.quit()
end

-- Called to change the difficulty of the game
function changeDifficulty()
    print("changeDifficulty() in main.lua")
end



function love.keypressed( key, scancode, isrepeat )
    active_scene:keypressed(key, scancode, isrepeat)
end

function love.mousepressed(x, y, button, istouch)
    active_scene:mousepressed(x, y, button, istouch)
end


-- Debug info

function luaInfo()
    local info = "Lua version: " .. _VERSION .. "\n"
    info = info .. "LuaJIT version: "

    if (jit) then
        info = info .. jit.version
    else
        info = info .. "this is not LuaJIT"
    end

    return info
end
