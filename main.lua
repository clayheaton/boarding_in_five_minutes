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
    require "scenes.scene_test"
    require "scenes.scene_terminal"

    game     = Game()
    settings = GameSettings()

    -- More info here: https://love2d.org/wiki/love.window.setMode
    -- TODO: Reconcile with the conf.lua settings
    love.window.setMode(settings.winW,settings.winH,{msaa=4})

    -- Causes the math.random function to actually be random
    math.randomseed(os.time())

    -- Create Font objects
    main_title_font = love.graphics.newFont("Skia.ttf", 48)
    sub_title_font  = love.graphics.newFont("SFNSText.ttf", 24)
    loading_font    = love.graphics.newFont("SFNSText.ttf", 16)

    -- Establish the initial screen that will appear
    active_scene = MainMenu() 
end

function love.update(dt)
    if love.keyboard.isDown('w', 'a', 's', 'd') then
        -- Tell the active scene that one of these buttons is down
        active_scene:checkKeyDown()
    end

    active_scene:update(dt)
end


function love.draw()
    active_scene:draw()
end

-- Starting a new game
function startNewGame()
    active_scene = LoadingScreen()
    game:init(active_scene)
    
    active_scene = SceneTerminal()
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
