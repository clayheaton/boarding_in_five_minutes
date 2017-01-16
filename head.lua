--! file: head.lua
require "face_parts"

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

end