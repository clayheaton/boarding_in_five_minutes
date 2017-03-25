--! file: scene_terminal.lua
require("colors")
require("map.terminal")


SceneTerminal = Object:extend()

function SceneTerminal:new()
    self.terminal       = Terminal()
    self.move_map_up    = false
    self.move_map_down  = false
    self.move_map_right = false
    self.move_map_left  = false
end


function SceneTerminal:update(dt)

end

function SceneTerminal:keypressed(key,scancode,isreapeat)
    if key == "w" then

    end
end

function SceneTerminal:checkKeyDown()
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

function SceneTerminal:mousepressed(x, y, button, istouch)
    print("SceneTerminal processing mousepressed")
    print(x)
    print(y)
    print(istouch)
end

function SceneTerminal:draw()
    love.graphics.setBackgroundColor( 19, 38, 55 )
    self.terminal:draw()
end