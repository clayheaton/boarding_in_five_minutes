--! file: eye.lua
require "colors"

Eye = Object:extend()

function Eye:new()
    self.width  = 8
    self.height = 8
    self.color  = random_eye_color()
end

function Eye:draw(direction)
    -- The white of the eye
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("line",0,0,self.width,self.height)

    -- The eye color
    love.graphics.setColor(self.color[1],self.color[2],self.color[3])
    love.graphics.rectangle("fill", 0, 0, self.width, self.height)

    -- The pupil color
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill",3,3,2,2)
end