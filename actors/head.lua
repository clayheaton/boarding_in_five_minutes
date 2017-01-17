--! file: head.lua
require "colors"

require "actors.eye"
require "actors.nose"
require "actors.eyebrow"
require "actors.ear"
require "actors.mouth"
require "actors.hair"

Head   = Object:extend()

function Head:new()
    self.width   = math.random(40,60)
    self.height  = math.random(40,80)
    self.color   = random_skin_color()

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
    love.graphics.rectangle("fill",0, 0, self.width, self.height)

    -- Draw an eye on the head
    love.graphics.push()
    if direction == "left" then
        love.graphics.translate(self.width * 0.22 - self.eye.width, self.height * 0.3)
    else
        love.graphics.translate(self.width * 0.8,self.height * 0.3)
    end
    self.eye:draw(direction)
    love.graphics.pop()

    -- Draw a nose on the head
    love.graphics.push()
    if direction == "left" then
        love.graphics.translate(-1 * self.nose.width + 1, self.height * 0.5)
    else
        love.graphics.translate(self.width - 1, self.height * 0.5)
    end
    self.nose:draw(direction)
    love.graphics.pop()

    -- Draw an eyebrow on the head
    love.graphics.push()
    if direction == "left" then
        love.graphics.translate(self.width * 0.25 - self.eyebrow.width, self.height * 0.20)
    else
        love.graphics.translate(self.width * 0.75, self.height * 0.20)
    end
    
    self.eyebrow:draw(direction)
    love.graphics.pop()

    -- Draw an ear on the head. Right-direction handled in the class
    love.graphics.push()
    if direction == "left" then
        love.graphics.translate(self.width * 0.7 - self.ear.width, self.height * 0.5)
    else
        love.graphics.translate(self.width * 0.3, self.height * 0.5)
    end
    self.ear:draw(direction)
    love.graphics.pop()

    -- Draw the mouth. May change with mood.
    love.graphics.push()
    if direction == "left" then
        love.graphics.translate(1,self.height * 0.5 + self.mouth_offset)
    else
        love.graphics.translate(self.width - self.mouth.width - 1,self.height * 0.5 + self.mouth_offset)
    end
    self.mouth:draw(direction)
    love.graphics.pop()

    -- Draw the hair
    love.graphics.push()
    love.graphics.translate(-3,0)
    self.hair:draw(direction)
    love.graphics.pop()

end
