--! file: face.lua
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

--

Mouth = Object:extend()

function Mouth:new()
    self.width = 12
end

function Mouth:draw(direction)
    love.graphics.setLineWidth(2)
    love.graphics.setColor(142,23,21)
    love.graphics.line(0,0,self.width,0)
end

--

Ear = Object:extend()

function Ear:new()
    self.height = math.random(10,15)
    self.width  = math.random(6,10)
end

function Ear:draw(direction)
    if direction == "left" then
        love.graphics.setColor(0,0,0)
        love.graphics.setLineWidth(2)
        love.graphics.line(0,0,self.width,0,self.width,self.height,0,self.height)
        love.graphics.setLineWidth(1)
        love.graphics.line(3,self.height/2 - 2,3,self.height/2 + 2)
    else
        love.graphics.setColor(0,0,0)
        love.graphics.setLineWidth(2)
        love.graphics.line(self.width,0,0,0,0,self.height,self.width,self.height)
        love.graphics.setLineWidth(1)
        love.graphics.line(self.width-3,self.height/2 - 2,self.width-3,self.height/2 + 2)
    end
end

--

Eyebrow = Object:extend()

function Eyebrow:new()
    self.width  = 10
    self.height = math.random(2,4)
end

function Eyebrow:draw(direction)
    love.graphics.setColor(0,0,0)
    love.graphics.setLineWidth(self.height)
    love.graphics.line(0,0,self.width,0)
    love.graphics.setLineWidth(1)
end

--

Nose = Object:extend()

function Nose:new(color)
    self.width  = math.random(6,12)
    self.height = math.random(6,12)
    self.color  = color
end

function Nose:draw(direction)
    love.graphics.setColor(self.color[1],self.color[2],self.color[3])
    love.graphics.rectangle("fill", 0, 0, self.width, self.height)
end