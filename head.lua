--! file: head.lua

Head   = Shape:extend()

function Head:new(x,y)
    Head.super.new(self,x,y)
    self.width   = math.random(40,60)
    self.height  = math.random(40,80)
    self.color   = random_face_color()

    -- Components on the head. They may change appearance with mood.
    self.eye     = Eye()
    self.nose    = Nose(self.color)
    self.eyebrow = Eyebrow()
    self.ear     = Ear()
    self.mouth   = Mouth()
    self.mouth_offset = self.nose.height + (self.height * (math.random(10,18)/100))

    -- Hair. Include logic so old people get grey hair, etc.
    self.hair_color = random_hair_color()
    self.hair       = Hair(self.hair_color,self.height,self.width)
end

function Head:draw(direction)
    -- love.graphics.setColor(224,172,105)
    -- love.graphics.rectangle("line", self.x, self.y, self.width, self.height)

    -- The actual head part
    love.graphics.setColor(self.color[1],self.color[2],self.color[3])
    love.graphics.rectangle("fill",self.x, self.y, self.width, self.height)

    -- Draw an eye on the head
    love.graphics.push()
    if direction == "left" then
        love.graphics.translate(self.x + (self.width * 0.22 - self.eye.width), self.y + (self.height * 0.3))
    else
        love.graphics.translate(self.x + (self.width * 0.8),self.y + (self.height * 0.3))
    end
    self.eye:draw(direction)
    love.graphics.pop()

    -- Draw a nose on the head
    love.graphics.push()
    if direction == "left" then
        love.graphics.translate(self.x - self.nose.width + 1, self.y + (self.height * 0.5))
    else
        love.graphics.translate(self.x + self.width - 1, self.y + (self.height * 0.5))
    end
    self.nose:draw(direction)
    love.graphics.pop()

    -- Draw an eyebrow on the head
    love.graphics.push()
    if direction == "left" then
        love.graphics.translate(self.x + (self.width * 0.25 - self.eyebrow.width), self.y + (self.height * 0.20))
    else
        love.graphics.translate(self.x + (self.width * 0.75), self.y + (self.height * 0.20))
    end
    
    self.eyebrow:draw(direction)
    love.graphics.pop()

    -- Draw an ear on the head. Right-direction handled in the class
    love.graphics.push()
    if direction == "left" then
        love.graphics.translate(self.x + (self.width * 0.7), self.y + (self.height * 0.5))
    else
        love.graphics.translate(self.x + (self.width * 0.3), self.y + (self.height * 0.5))
    end
    self.ear:draw(direction)
    love.graphics.pop()

    -- Draw the mouth. May change with mood.
    love.graphics.push()
    if direction == "left" then
        love.graphics.translate(self.x + 1,self.y + (self.height * 0.5) + self.mouth_offset)
    else
        love.graphics.translate(self.x + (self.width - self.mouth.width - 1),self.y + (self.height * 0.5) + self.mouth_offset)
    end
    self.mouth:draw(direction)
    love.graphics.pop()

    -- Draw the hair
    love.graphics.push()
    love.graphics.translate(self.x - 3,self.y)
    self.hair:draw(direction)
    love.graphics.pop()

end

--

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

--

Hair = Object:extend()

function Hair:new(color,head_height,head_width)
    self.color      = color
    self.height     = math.random(head_height,head_height*1.5)
    self.head_width = head_width
end

function Hair:draw(direction)
    love.graphics.setColor(self.color)

    love.graphics.rectangle("fill",0,-5,self.head_width+6,7)

    if direction == "left" then
        love.graphics.rectangle("fill",self.head_width-3,-3,9,self.height)
    else
        love.graphics.rectangle("fill",0,-3,6,self.height)
    end
end





