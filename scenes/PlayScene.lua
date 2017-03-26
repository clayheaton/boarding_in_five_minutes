--! file: PlayScene.lua
require("colors")
require("map.terminal")


PlayScene = Object:extend()

function PlayScene:new()
    self.terminal       = Terminal()
    self.move_map_up    = false
    self.move_map_down  = false
    self.move_map_right = false
    self.move_map_left  = false
end


function PlayScene:update(dt)

end

function PlayScene:keypressed(key,scancode,isreapeat)
    if key == "w" then

    end
end

function PlayScene:checkKeyDown()
    if love.keyboard.isDown("w") then
        -- print("w is being held down")
        self.terminal.offsetY = self.terminal.offsetY - 4
    end
    if love.keyboard.isDown("a") then
        self.terminal.offsetX = self.terminal.offsetX - 4
    end
    if love.keyboard.isDown("s") then
        -- print("s is being held down")
        self.terminal.offsetY = self.terminal.offsetY + 4
    end
    if love.keyboard.isDown("d") then
        self.terminal.offsetX = self.terminal.offsetX + 4
    end
end 

function PlayScene:mousepressed(x, y, button, istouch)
    print("PlayScene mousepressed: " .. tostring(x) .. ", " .. tostring(y))

    -- Pass through clicks to the Terminal if they do not hit on UI managed here.
    self.terminal:mousepressed(x,y,button,istouch)
end

function PlayScene:draw()
    love.graphics.setBackgroundColor( 19, 38, 55 )
    self.terminal:draw()
end