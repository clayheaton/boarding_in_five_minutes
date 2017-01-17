--! file: hair.lua
Hair = Object:extend()

function Hair:new(color,head_height,head_width)
    self.color      = color
    self.height     = math.random(head_height*0.3,head_height*1.7)
    self.head_width = head_width
    self.hair_height_multiplier = self.height * (math.random(40,100)/100)
    self.bald    = false
    self.balding = false
    local bald_test = math.random(0,100)
    if bald_test < 20 then
        self.bald = true
        if math.random(0,100) < 50 then
            self.balding = true
        end
    end
end

function Hair:draw(direction)
    love.graphics.setColor(self.color)

    if self.bald then
        if self.balding then
            if direction == "left" then
                love.graphics.rectangle("fill",self.head_width+6,self.height * 0.2,-1*self.head_width*0.3,self.height * 0.1)
            else
                love.graphics.rectangle("fill",-1,self.height * 0.2,self.head_width*0.3,self.height * 0.1)
            end
        end
        return
    end

    love.graphics.rectangle("fill",0,-5,self.head_width+6,7)

    if direction == "left" then
        love.graphics.rectangle("fill",self.head_width-3,-3,9,self.height)
        love.graphics.polygon("fill",self.head_width,-3,self.head_width,self.hair_height_multiplier,self.head_width*0.2,-3)
    else
        love.graphics.rectangle("fill",0,-3,9,self.height)
        love.graphics.polygon("fill",0,-3,0,self.hair_height_multiplier,self.head_width*0.8,-3)
    end
end