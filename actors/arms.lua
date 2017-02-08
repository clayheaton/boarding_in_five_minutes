--! file: arms.lua
require "colors"

Arm = Object:extend()

function Arm:new(width,length,torso_color,skin_color,arm_side,torso_width,suitcase_color)
    self.width      = width
    self.length     = length
    self.color      = torso_color
    self.hand_color = skin_color
    self.arm_side   = arm_side
    self.torso_width = torso_width
    self.suitcase_color = suitcase_color
end

function Arm:draw(direction,animationState,holding_ticket,holding_suitcase)
    setColor(self.color)

    -- Person is seated
    if animationState == "sitting" then
        -- draw sitting
        if self.arm_side == "RightArm" then
            love.graphics.rectangle("fill",-self.torso_width/2 - self.width - 2,0,self.width,self.length)
            love.graphics.rectangle("fill",-self.torso_width/2 - self.width/2,0,self.width,20)
            self:drawHand(direction,animationState,holding_ticket,holding_suitcase)
        else
            love.graphics.rectangle("fill", self.torso_width/2 + 2,0,self.width,self.length)
            love.graphics.rectangle("fill", self.torso_width/2 - self.width/2,0,self.width,20)
            self:drawHand(direction,animationState,holding_ticket,holding_suitcase)
        end
        return


    else 
        -- Standing or walking
        if self.arm_side == "RightArm" then
            if holding_ticket == true then
                -- Right Arm should be angled out and bend upwards holding ticket
                if direction == "right" then
                    -- in front of body
                    love.graphics.push()
                    love.graphics.rotate(-math.pi/6)
                    love.graphics.rectangle("fill",-self.width/2,1,self.width,self.length)
                    self:drawHand(direction,animationState,holding_ticket,holding_suitcase)
                    setColor(lighter_shade(self.color,30))
                    love.graphics.setLineWidth(0.5)
                    love.graphics.rectangle("line",-self.width/2,1,self.width,self.length)
                    love.graphics.pop()   
                else
                    -- behind body
                    love.graphics.push()
                    love.graphics.rotate(math.pi/6)
                    love.graphics.rectangle("fill",-self.width/2,1,self.width,self.length)
                    self:drawHand(direction,animationState,holding_ticket,holding_suitcase)
                    setColor(lighter_shade(self.color,30))
                    love.graphics.setLineWidth(0.5)
                    love.graphics.rectangle("line",-self.width/2,1,self.width,self.length)
                    love.graphics.pop()
                end
            elseif holding_suitcase == true then
                -- Arm angled out dragging or holding suitcase
                if direction == "right" then
                    -- right arm, headed right, holding suitcase
                    love.graphics.push()
                    love.graphics.rotate(math.pi/6)
                    love.graphics.rectangle("fill",-self.width/2,1,self.width,self.length)
                    self:drawHand(direction,animationState,holding_ticket,holding_suitcase)
                    setColor(lighter_shade(self.color,30))
                    love.graphics.setLineWidth(0.5)
                    love.graphics.rectangle("line",-self.width/2,1,self.width,self.length)
                    love.graphics.pop()
                else
                    -- right arm, headed left, holding suitcase
                    love.graphics.push()
                    love.graphics.rotate(-math.pi/6)
                    love.graphics.rectangle("fill",-self.width/2,1,self.width,self.length)
                    self:drawHand(direction,animationState,holding_ticket,holding_suitcase)
                    setColor(lighter_shade(self.color,30))
                    love.graphics.setLineWidth(0.5)
                    love.graphics.rectangle("line",-self.width/2,1,self.width,self.length)
                    love.graphics.pop()  
                end
            else
                -- Arm at side
                if direction == "left" then
                    -- Don't need to draw the left arm if the person is facing right and not holding anything
                    return
                else
                    love.graphics.rectangle("fill",-self.width/2,1,self.width,self.length)
                    self:drawHand(direction,animationState,holding_ticket,holding_suitcase)
                    setColor(lighter_shade(self.color,30))
                    love.graphics.setLineWidth(0.5)
                    love.graphics.rectangle("line",-self.width/2,1,self.width,self.length)
                end
            end


        else
            if holding_ticket == true then
                -- Left arm should be angled out and bend upwards holding ticket
                if direction == "left" then
                    -- in front of body, holding ticket
                    love.graphics.push()
                    love.graphics.rotate(math.pi/6)
                    love.graphics.rectangle("fill",-self.width/2,1,self.width,self.length)
                    self:drawHand(direction,animationState,holding_ticket,holding_suitcase)
                    setColor(lighter_shade(self.color,30))
                    love.graphics.setLineWidth(0.5)
                    love.graphics.rectangle("line",-self.width/2,1,self.width,self.length)
                    love.graphics.pop()
                else
                    -- behind body holding ticket
                    love.graphics.push()
                    love.graphics.rotate(math.pi/-6)
                    love.graphics.rectangle("fill",-self.width/2,1,self.width,self.length)
                    self:drawHand(direction,animationState,holding_ticket,holding_suitcase)
                    setColor(lighter_shade(self.color,30))
                    love.graphics.setLineWidth(0.5)
                    love.graphics.rectangle("line",-self.width/2,1,self.width,self.length)
                    love.graphics.pop()
                end

            elseif holding_suitcase == true then
                -- Arm angled out dragging or holding suitcase
                if direction == "right" then
                    -- left arm holding suitcase facing right
                    love.graphics.push()
                    love.graphics.rotate(math.pi/-6)
                    love.graphics.rectangle("fill",-self.width/2,1,self.width,self.length)
                    self:drawHand(direction,animationState,holding_ticket,holding_suitcase)
                    setColor(lighter_shade(self.color,30))
                    love.graphics.setLineWidth(0.5)
                    love.graphics.rectangle("line",-self.width/2,1,self.width,self.length)
                    love.graphics.pop()
                else
                    love.graphics.push()
                    love.graphics.rotate(math.pi/6)
                    love.graphics.rectangle("fill",-self.width/2,1,self.width,self.length)
                    self:drawHand(direction,animationState,holding_ticket,holding_suitcase)
                    setColor(lighter_shade(self.color,30))
                    love.graphics.setLineWidth(0.5)
                    love.graphics.rectangle("line",-self.width/2,1,self.width,self.length)
                    love.graphics.pop()
                end
            else
                -- Arm at side
                if direction == "right" then
                    -- Don't need to draw the right arm if the person is facing left and not holding anything
                    return
                else
                    love.graphics.rectangle("fill",-self.width/2,1,self.width,self.length)
                    self:drawHand(direction,animationState,holding_ticket,holding_suitcase)
                    setColor(lighter_shade(self.color,30))
                    love.graphics.setLineWidth(0.5)
                    love.graphics.rectangle("line",-self.width/2,1,self.width,self.length)
                end
            end
        end
    end
    
    -- Person is standing or walking
end

function Arm:drawHand(direction,animationState,holding_ticket,holding_suitcase)
    setColor(self.hand_color)
    if animationState == "sitting" then
        -- draw sitting
        if self.arm_side == "RightArm" then
            love.graphics.rectangle("fill",-self.torso_width/2 - self.width,self.length,self.width-4,self.length*0.15)
        else
            love.graphics.rectangle("fill", self.torso_width/2 + 4,self.length,self.width - 4,self.length*0.15)
        end
        return
    else
        -- Standing or walking
        if self.arm_side == "RightArm" then
            if holding_ticket == true then
                -- DRAW THE TICKET
                local xa = -10
                local xb = 40
                if direction == "left" then
                    xa = -30
                    xb = 40
                end
                setColor(ticket_color)
                love.graphics.rectangle("fill",xa, self.length+3,xb,18)
                love.graphics.setLineWidth(0.5)
                setColor(darker_shade(ticket_color,50))
                love.graphics.rectangle("line",xa, self.length+3,xb,18)

                setColor(self.hand_color)
                -- Arm should be angled out to hold a ticket
                love.graphics.rectangle("fill",-self.width/2 + 2,self.length,self.width-4,self.length*0.15)

            elseif holding_suitcase == true then
                -- Arm angled out dragging or holding suitcase
                love.graphics.rectangle("fill",-self.width/2 + 2,self.length,self.width-4,self.length*0.15)
                -- DRAW THE SUITCASE
            else
                -- Arm at side
                if direction == "left" then
                    -- Don't need to draw the left hand if the person is facing right and not holding anything
                    return
                else
                    love.graphics.rectangle("fill", -self.width/2 + 2,self.length,self.width - 4,self.length*0.15)
                end
            end


        else
            if holding_ticket == true then
                -- DRAW THE TICKET
                local xa = -10
                local xb = 40
                if direction == "left" then
                    xa = -30
                    xb = 40
                end
                setColor(ticket_color)
                love.graphics.rectangle("fill",xa, self.length+3,xb,18)
                love.graphics.setLineWidth(0.5)
                setColor(darker_shade(ticket_color,50))
                love.graphics.rectangle("line",xa, self.length+3,xb,18)

                setColor(self.hand_color)
                -- left hand holding ticket
                love.graphics.rectangle("fill",-self.width/2 + 2,self.length,self.width-4,self.length*0.15)

            elseif holding_suitcase == true then
                -- Arm angled out dragging or holding suitcase
                love.graphics.rectangle("fill",-self.width/2 + 2,self.length,self.width-4,self.length*0.15)
                -- DRAW SUITCASE
            else
                -- Arm at side
                if direction == "right" then
                    -- Don't need to draw the right hand if the person is facing left and not holding anything
                    return
                else
                    love.graphics.rectangle("fill", -self.width/2 + 2,self.length,self.width - 4,self.length*0.15)
                end
            end
        end
    end
end


Arms = Object:extend()

function Arms:new(torso_color,skin_color,suitcase_color,right_handed,torso_width,torso_length)
    self.length     = torso_length * 0.9
    self.width      = math.random(10,20)

    self.right_handed = right_handed
    self.torso_width  = torso_width
    self.torso_length = torso_length

    self.suitcase_color = suitcase_color

    self.armL       = Arm(self.width,self.length,torso_color,skin_color, "LeftArm",torso_width,suitcase_color)
    self.armR       = Arm(self.width,self.length,torso_color,skin_color, "RightArm",torso_width,suitcase_color)

    self.holding_ticket   = false
    self.holding_suitcase = false

end

function Arms:update(dt)
end

function Arms:drawFirst(direction,animationState,holding_ticket,holding_suitcase)
    -- animationState might be 'sitting'
    if animationState == "sitting" then
        -- Draw arms at side
        self:drawRightArm(direction,animationState,holding_ticket,holding_suitcase)
        self:drawLeftArm(direction,animationState,holding_ticket,holding_suitcase)
        return
    end

    if direction == "right" then
        self:drawLeftArm(direction,animationState,holding_ticket,holding_suitcase)
    else
        self:drawRightArm(direction,animationState,holding_ticket,holding_suitcase)
    end
end

function Arms:drawLast(direction,animationState,holding_ticket,holding_suitcase)
    -- animationState might be 'sitting'
    if animationState == "sitting" then
        return
    end

    if direction == "right" then
        self:drawRightArm(direction,animationState,holding_ticket,holding_suitcase)
    else
        self:drawLeftArm(direction,animationState,holding_ticket,holding_suitcase)
    end
end

function Arms:drawRightArm(direction,animationState,holding_ticket,holding_suitcase)

    local draw_ticket   = false
    local draw_suitcase = false


    if self.right_handed == true then
        if holding_suitcase == true then
            draw_suitcase = true
        end
    else
        if holding_ticket == true then
            draw_ticket = true
        end
    end

    self.armR:draw(direction,animationState,draw_ticket,draw_suitcase)
end

function Arms:drawLeftArm(direction,animationState,holding_ticket,holding_suitcase)

    local draw_ticket   = false
    local draw_suitcase = false

    if self.right_handed == false then
        if holding_suitcase == true then
            draw_suitcase = true
        end
    else
        if holding_ticket == true then
            draw_ticket = true
        end
    end

    self.armL:draw(direction,animationState,draw_ticket,draw_suitcase)
end