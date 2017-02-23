--! file: arms.lua
require "colors"

Arms = Object:extend()
Arm = Object:extend()

function Arms:new(person)
    self.p = person

    self.length = self.p.torso_length * 0.9
    self.width  = math.random(10,20)

    self.armL = Arm(self.p,self.width,self.length,"LeftArm")
    self.armR = Arm(self.p,self.width,self.length,"RightArm")

end

function Arms:update(dt)
end

-- This is more complicated than it seems it should be due to the fact that the arm
-- that is not facing the player may be holding an object that is partially occluded by the torso.

function Arms:drawFirst(direction,animationState,holding_ticket,holding_suitcase)
    -- animationState might be 'sitting'
    if animationState == "sitting" then
        local draw_straps = false
        if holding_suitcase == true and self.p.suitcase_type == "backpack" then
            draw_straps = true
        end

        -- Draw arms at side
        self:drawRightArm(direction,animationState,holding_ticket,holding_suitcase,draw_straps)
        self:drawLeftArm(direction,animationState,holding_ticket,holding_suitcase,draw_straps)
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

    local draw_straps = false
    if holding_suitcase == true and self.p.suitcase_type == "backpack" then
        draw_straps = true
    end

    if direction == "right" then
        self:drawRightArm(direction,animationState,holding_ticket,holding_suitcase,draw_straps)
    else
        self:drawLeftArm(direction,animationState,holding_ticket,holding_suitcase,draw_straps)
    end
end

function Arms:drawRightArm(direction,animationState,holding_ticket,holding_suitcase,draw_straps)

    local draw_ticket   = false
    local draw_suitcase = false


    if self.p.right_handed == true then
        if holding_suitcase == true then
            draw_suitcase = true
        end
    else
        if holding_ticket == true then
            draw_ticket = true
        end
    end

    self.armR:draw(direction,animationState,draw_ticket,draw_suitcase,draw_straps)
end

function Arms:drawLeftArm(direction,animationState,holding_ticket,holding_suitcase,draw_straps)

    local draw_ticket   = false
    local draw_suitcase = false

    if self.p.right_handed == false then
        if holding_suitcase == true then
            draw_suitcase = true
        end
    else
        if holding_ticket == true then
            draw_ticket = true
        end
    end

    self.armL:draw(direction,animationState,draw_ticket,draw_suitcase,draw_straps)
end



----------------------- ARM -------------------------------



function Arm:new(person,width,length,arm_side)
    self.p              = person
    self.width          = width
    self.length         = length
    self.color          = self.p.color_torso
    self.hand_color     = self.p.color_skin
    self.arm_side       = arm_side
    self.torso_width    = self.p.torso_width
    self.suitcase_color = self.p.suitcase_color
    self.suitcase_type  = self.p.suitcase_type
end

function Arm:draw(direction,animationState,holding_ticket,holding_suitcase,draw_straps)
    setColor(self.color)

    -- Person is seated
    if animationState == "sitting" then
        -- draw sitting
        if self.arm_side == "RightArm" then
            love.graphics.rectangle("fill",-self.torso_width/2 - self.width - 2,0,self.width,self.length)
            love.graphics.rectangle("fill",-self.torso_width/2 - self.width/2,0,self.width,20)
            self:drawHand(direction,animationState,holding_ticket,holding_suitcase)

            -- Backpack strap for RightArm
            if self.suitcase_type == "backpack" and self.p.holding_suitcase == true then
                setColor(self.suitcase_color)
                love.graphics.rectangle("fill",-self.torso_width/2 - 2,-2,6,self.length*0.6)
            end

            if self.suitcase_type == "rollerboard" and holding_suitcase == true then
                love.graphics.push()
                love.graphics.translate(-self.torso_width,-15)
                setColor(self.suitcase_color)
                love.graphics.rectangle("fill",-self.width,self.length*1.1,self.width*2,8)
                setColor({0,0,0})
                love.graphics.rectangle("fill",-2,self.length*1.1 + 8,4,15)
                setColor(self.suitcase_color)
                love.graphics.rectangle("fill",-self.width*0.8,self.length*1.1 + 23,self.width*1.6,self.length*0.8)
                setColor(darker_shade(self.suitcase_color,75))
                love.graphics.setLineWidth(1)
                love.graphics.rectangle("line",-self.width*0.8,self.length*1.1 + 23,self.width*1.6,self.length*0.8)
                setColor({0,0,0})
                -- Rollerboard wheel
                love.graphics.circle("fill",-self.width*0.8,self.length*1.1 + 23 + self.length*0.8,8) 
                love.graphics.pop()
            end

            if self.suitcase_type == "duffelbag" and holding_suitcase == true then
                love.graphics.push()
                love.graphics.translate(-self.torso_width,self.length*0.4)
                -- bag
                setColor(self.suitcase_color)
                love.graphics.rectangle("fill",-self.width*3,self.length*1.1+10,self.width*6,self.length*0.5 - 5)
                setColor(darker_shade(self.suitcase_color,75))
                love.graphics.setLineWidth(1)
                love.graphics.rectangle("line",-self.width*3,self.length*1.1+10,self.width*6,self.length*0.5 - 5)
                -- handle
                setColor({0,0,0})
                love.graphics.rectangle("fill",-self.width*1.5,self.length*1.1,self.width*3,5)
                love.graphics.rectangle("fill",-self.width*1.5,self.length*1.1 + 5,5,self.length*0.5)
                love.graphics.rectangle("fill",self.width*1.5 -5,self.length*1.1 + 5,5,self.length*0.5)
                love.graphics.pop()
            end

        else
            love.graphics.rectangle("fill", self.torso_width/2 + 2,0,self.width,self.length)
            love.graphics.rectangle("fill", self.torso_width/2 - self.width/2,0,self.width,20)
            self:drawHand(direction,animationState,holding_ticket,holding_suitcase)

            -- Backpack strap for LeftArm
            if self.suitcase_type == "backpack" and self.p.holding_suitcase == true then
                setColor(self.suitcase_color)
                love.graphics.rectangle("fill", self.torso_width/2 - 2,-2,6,self.length*0.6)
            end

            if self.suitcase_type == "rollerboard" and holding_suitcase == true then
                love.graphics.push()
                love.graphics.translate(self.torso_width,-15)
                setColor(self.suitcase_color)
                love.graphics.rectangle("fill",-self.width,self.length*1.1,self.width*2,8)
                setColor({0,0,0})
                love.graphics.rectangle("fill",-2,self.length*1.1 + 8,4,15)
                setColor(self.suitcase_color)
                love.graphics.rectangle("fill",-self.width*0.8,self.length*1.1 + 23,self.width*1.6,self.length*0.8)
                setColor(darker_shade(self.suitcase_color,75))
                love.graphics.setLineWidth(1)
                love.graphics.rectangle("line",-self.width*0.8,self.length*1.1 + 23,self.width*1.6,self.length*0.8)
                setColor({0,0,0})
                -- Rollerboard wheel
                love.graphics.circle("fill",self.width*0.8,self.length*1.1 + 23 + self.length*0.8,8) 
                love.graphics.pop()
            end

            if self.suitcase_type == "duffelbag" and holding_suitcase == true then
                love.graphics.push()
                love.graphics.translate(self.torso_width,self.length*0.4)
                -- bag
                setColor(self.suitcase_color)
                love.graphics.rectangle("fill",-self.width*3,self.length*1.1+10,self.width*6,self.length*0.5 - 5)
                setColor(darker_shade(self.suitcase_color,75))
                love.graphics.setLineWidth(1)
                love.graphics.rectangle("line",-self.width*3,self.length*1.1+10,self.width*6,self.length*0.5 - 5)
                -- handle
                setColor({0,0,0})
                love.graphics.rectangle("fill",-self.width*1.5,self.length*1.1,self.width*3,5)
                love.graphics.rectangle("fill",-self.width*1.5,self.length*1.1 + 5,5,self.length*0.5)
                love.graphics.rectangle("fill",self.width*1.5 -5,self.length*1.1 + 5,5,self.length*0.5)
                love.graphics.pop()
            end
        end
        return


    else 
        -- Standing or walking
        if self.arm_side == "RightArm" then
            if holding_ticket == true then
                -- Right Arm should be angled out and bend upwards holding ticket
                if direction == "right" then
                    -- backpack straps?
                    if draw_straps == true then
                        setColor(self.suitcase_color)
                        love.graphics.polygon("fill",self.torso_width/2,0,
                                                     self.torso_width/4 ,self.length*0.5,
                                                     self.torso_width/4 - 6,self.length*0.5,
                                                     self.torso_width/2 - 6,0,
                                                     self.torso_width/2,0)
                        setColor({0,0,0})
                        love.graphics.rectangle("fill",-self.torso_width/2,self.length*0.5 - 4,self.torso_width*0.75,4)
                    end

                    setColor(self.color)
                    -- in front of body
                    love.graphics.push()
                    love.graphics.rotate(-math.pi/6)
                    love.graphics.rectangle("fill",-self.width/2,1,self.width,self.length)
                    self:drawHand(direction,animationState,holding_ticket,holding_suitcase)
                    setColor(lighter_shade(self.color,30))
                    love.graphics.setLineWidth(0.5)
                    love.graphics.rectangle("line",-self.width/2,1,self.width,self.length)
                    love.graphics.pop()   

                    if draw_straps == true then
                        setColor(self.suitcase_color)
                        love.graphics.rectangle("fill",-self.torso_width/2,0,self.torso_width,6)       
                    end
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
                    -- backpack straps
                    if draw_straps == true then
                        setColor(self.suitcase_color)
                        love.graphics.polygon("fill",self.torso_width/2,0,
                                                     self.torso_width/4 ,self.length*0.5,
                                                     self.torso_width/4 - 6,self.length*0.5,
                                                     self.torso_width/2 - 6,0,
                                                     self.torso_width/2,0)
                        setColor({0,0,0})
                        love.graphics.rectangle("fill",-self.torso_width/2,self.length*0.5 - 4,self.torso_width*0.75,4)
                    end

                    -- right arm, headed right, holding suitcase
                    setColor(self.color)
                    love.graphics.push()
                    if self.suitcase_type == "rollerboard" then
                        love.graphics.rotate(math.pi/6)
                    end
                    love.graphics.rectangle("fill",-self.width/2,1,self.width,self.length)
                    self:drawHand(direction,animationState,holding_ticket,holding_suitcase)
                    setColor(lighter_shade(self.color,30))
                    love.graphics.setLineWidth(0.5)
                    love.graphics.rectangle("line",-self.width/2,1,self.width,self.length)
                    love.graphics.pop()

                    if draw_straps == true then
                        setColor(self.suitcase_color)
                        love.graphics.rectangle("fill",-self.torso_width/2,0,self.torso_width,6)
                    end
                else
                    -- right arm, headed left, holding suitcase
                    love.graphics.push()
                    if self.suitcase_type == "rollerboard" then
                        love.graphics.rotate(-math.pi/6)
                    end
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
                    -- Backpack straps
                    if draw_straps == true then
                        setColor(self.suitcase_color)
                        love.graphics.polygon("fill",-self.torso_width/2,0,
                                                     -self.torso_width/4 ,self.length*0.5,
                                                     -self.torso_width/4 + 6,self.length*0.5,
                                                     -self.torso_width/2 + 6,0,
                                                     -self.torso_width/2,0)
                        setColor({0,0,0})
                        love.graphics.rectangle("fill",self.torso_width/2,self.length*0.5 - 4,-self.torso_width*0.75,4)
                    end

                    setColor(self.color)
                    -- in front of body, holding ticket
                    love.graphics.push()
                    love.graphics.rotate(math.pi/6)
                    love.graphics.rectangle("fill",-self.width/2,1,self.width,self.length)
                    self:drawHand(direction,animationState,holding_ticket,holding_suitcase)
                    setColor(lighter_shade(self.color,30))
                    love.graphics.setLineWidth(0.5)
                    love.graphics.rectangle("line",-self.width/2,1,self.width,self.length)
                    love.graphics.pop()

                    if draw_straps == true then
                        setColor(self.suitcase_color)
                        love.graphics.rectangle("fill",-self.torso_width/2,0,self.torso_width,6)
                    end
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
                    if self.suitcase_type == "rollerboard" then
                        love.graphics.rotate(math.pi/6)
                    end
                    love.graphics.rectangle("fill",-self.width/2,1,self.width,self.length)
                    self:drawHand(direction,animationState,holding_ticket,holding_suitcase)
                    setColor(lighter_shade(self.color,30))
                    love.graphics.setLineWidth(0.5)
                    love.graphics.rectangle("line",-self.width/2,1,self.width,self.length)
                    love.graphics.pop()
                else
                    -- Backpack straps
                    if draw_straps == true then
                        setColor(self.suitcase_color)
                        love.graphics.polygon("fill",-self.torso_width/2,0,
                                                     -self.torso_width/4 ,self.length*0.5,
                                                     -self.torso_width/4 + 6,self.length*0.5,
                                                     -self.torso_width/2 + 6,0,
                                                     -self.torso_width/2,0)
                        setColor({0,0,0})
                        love.graphics.rectangle("fill",self.torso_width/2,self.length*0.5 - 4,-self.torso_width*0.75,4)
                    end
                    setColor(self.color)
                    love.graphics.push()
                    if self.suitcase_type == "rollerboard" then
                        love.graphics.rotate(math.pi/-6)
                    end
                    love.graphics.rectangle("fill",-self.width/2,1,self.width,self.length)
                    self:drawHand(direction,animationState,holding_ticket,holding_suitcase)
                    setColor(lighter_shade(self.color,30))
                    love.graphics.setLineWidth(0.5)
                    love.graphics.rectangle("line",-self.width/2,1,self.width,self.length)
                    love.graphics.pop()

                    -- Backpack straps
                    if draw_straps == true then
                        setColor(self.suitcase_color)
                        love.graphics.rectangle("fill",-self.torso_width/2,0,self.torso_width,6)
                    end
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
end

function Arm:drawHand(direction,animationState,holding_ticket,holding_suitcase)
    setColor(self.hand_color)
    if animationState == "sitting" then
        -- draw sitting
        if self.arm_side == "RightArm" then
            if holding_ticket == true then
                -- DRAW THE TICKET
                local xa = -self.torso_width/2 - self.width - 20
                local xb = 40
                setColor(self.p.ticket_color)
                love.graphics.rectangle("fill",xa, self.length+3,xb,18)
                love.graphics.setLineWidth(0.5)
                setColor(darker_shade(self.p.ticket_color,50))
                love.graphics.rectangle("line",xa, self.length+3,xb,18)
            end
            setColor(self.hand_color)
            love.graphics.rectangle("fill",-self.torso_width/2 - self.width,self.length,self.width-4,self.length*0.15)
        else
            if holding_ticket == true then
                -- DRAW THE TICKET
                local xa = self.torso_width/2 + self.width - 20
                local xb = 40
                setColor(self.p.ticket_color)
                love.graphics.rectangle("fill",xa, self.length+3,xb,18)
                love.graphics.setLineWidth(0.5)
                setColor(darker_shade(self.p.ticket_color,50))
                love.graphics.rectangle("line",xa, self.length+3,xb,18)
            end
            setColor(self.hand_color)
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
                setColor(self.p.ticket_color)
                love.graphics.rectangle("fill",xa, self.length+3,xb,18)
                love.graphics.setLineWidth(0.5)
                setColor(darker_shade(self.p.ticket_color,50))
                love.graphics.rectangle("line",xa, self.length+3,xb,18)

                -- Arm should be angled out to hold a ticket
                setColor(self.hand_color)
                love.graphics.rectangle("fill",-self.width/2 + 2,self.length,self.width-4,self.length*0.15)

            elseif holding_suitcase == true then
                -- DRAW THE SUITCASE
                -- Standing, Right arm
                if self.suitcase_type == "rollerboard" then
                    setColor(self.suitcase_color)
                    love.graphics.rectangle("fill",-self.width,self.length*1.1,self.width*2,8)
                    setColor({0,0,0})
                    love.graphics.rectangle("fill",-2,self.length*1.1 + 8,4,15)
                    setColor(self.suitcase_color)
                    love.graphics.rectangle("fill",-self.width*0.8,self.length*1.1 + 23,self.width*1.6,self.length*0.8)
                    setColor(darker_shade(self.suitcase_color,75))
                    love.graphics.setLineWidth(1)
                    love.graphics.rectangle("line",-self.width*0.8,self.length*1.1 + 23,self.width*1.6,self.length*0.8)
                    setColor({0,0,0})
                    if direction == "left" then
                        -- Rollerboard wheel
                        love.graphics.circle("fill",-self.width*0.8,self.length*1.1 + 23 + self.length*0.8,8)
                    else
                        love.graphics.circle("fill",self.width*0.8,self.length*1.1 + 23 + self.length*0.8,8)
                    end
                elseif self.suitcase_type == "duffelbag" then
                    -- bag
                    setColor(self.suitcase_color)
                    love.graphics.rectangle("fill",-self.width*3,self.length*1.1+10,self.width*6,self.length*0.5 - 5)
                    setColor(darker_shade(self.suitcase_color,75))
                    love.graphics.setLineWidth(1)
                    love.graphics.rectangle("line",-self.width*3,self.length*1.1+10,self.width*6,self.length*0.5 - 5)
                    -- handle
                    setColor({0,0,0})
                    love.graphics.rectangle("fill",-self.width*1.5,self.length*1.1,self.width*3,5)
                    love.graphics.rectangle("fill",-self.width*1.5,self.length*1.1 + 5,5,self.length*0.5)
                    love.graphics.rectangle("fill",self.width*1.5 -5,self.length*1.1 + 5,5,self.length*0.5)
                elseif self.suitcase_type == "backpack" then
                    if direction == "left" then
                        -- This is drawn before the torso, so the straps need to be drawn with the other arm
                        setColor(self.suitcase_color)
                        love.graphics.polygon("fill",self.torso_width/2,0,
                                                     self.torso_width/2 + 15,self.length*0.2,
                                                     self.torso_width/2 + 25,self.length*0.4,
                                                     self.torso_width/2 + 30,self.length*0.7,
                                                     self.torso_width/2,self.length*0.72,
                                                     self.torso_width/2,0)
                    elseif direction == "right" then
                        setColor(self.suitcase_color)
                        love.graphics.polygon("fill",-self.torso_width/2,0,
                                                     -self.torso_width/2 - 15,self.length*0.2,
                                                     -self.torso_width/2 - 25,self.length*0.4,
                                                     -self.torso_width/2 - 30,self.length*0.7,
                                                     -self.torso_width/2,self.length*0.72,
                                                     -self.torso_width/2,0)
                    end

                end
                -- Arm angled out dragging or holding suitcase
                setColor(self.hand_color)
                love.graphics.rectangle("fill",-self.width/2 + 2,self.length,self.width-4,self.length*0.15)

            else
                -- Arm at side
                if direction == "left" then
                    -- Don't need to draw the left hand if the person is facing right and not holding anything
                    return
                else
                    setColor(self.hand_color)
                    love.graphics.rectangle("fill", -self.width/2 + 2,self.length,self.width - 4,self.length*0.15)
                end
            end


        else -- LEFT ARM
            if holding_ticket == true then
                -- DRAW THE TICKET
                local xa = -10
                local xb = 40
                if direction == "left" then
                    xa = -30
                    xb = 40
                end
                setColor(self.p.ticket_color)
                love.graphics.rectangle("fill",xa, self.length+3,xb,18)
                love.graphics.setLineWidth(0.5)
                setColor(darker_shade(self.p.ticket_color,50))
                love.graphics.rectangle("line",xa, self.length+3,xb,18)

                setColor(self.hand_color)
                -- left hand holding ticket
                love.graphics.rectangle("fill",-self.width/2 + 2,self.length,self.width-4,self.length*0.15)

            elseif holding_suitcase == true then
                -- TODO: Fix
                if self.suitcase_type == "rollerboard" then
                    setColor(self.suitcase_color)
                    love.graphics.rectangle("fill",-self.width,self.length*1.1,self.width*2,8)
                    setColor({0,0,0})
                    love.graphics.rectangle("fill",-2,self.length*1.1 + 8,4,15)
                    setColor(self.suitcase_color)
                    love.graphics.rectangle("fill",-self.width*0.8,self.length*1.1 + 23,self.width*1.6,self.length*0.8)
                    setColor(darker_shade(self.suitcase_color,75))
                    love.graphics.setLineWidth(1)
                    love.graphics.rectangle("line",-self.width*0.8,self.length*1.1 + 23,self.width*1.6,self.length*0.8)
                    setColor({0,0,0})
                    if direction == "left" then
                        -- Rollerboard wheel
                        love.graphics.circle("fill",-self.width*0.8,self.length*1.1 + 23 + self.length*0.8,8)
                    else
                        love.graphics.circle("fill",self.width*0.8,self.length*1.1 + 23 + self.length*0.8,8)
                    end
                elseif self.suitcase_type == "duffelbag" then
                    -- bag
                    setColor(self.suitcase_color)
                    love.graphics.rectangle("fill",-self.width*3,self.length*1.1+10,self.width*6,self.length*0.5 - 5)
                    setColor(darker_shade(self.suitcase_color,75))
                    love.graphics.setLineWidth(1)
                    love.graphics.rectangle("line",-self.width*3,self.length*1.1+10,self.width*6,self.length*0.5 - 5)
                    -- handle
                    setColor({0,0,0})
                    love.graphics.rectangle("fill",-self.width*1.5,self.length*1.1,self.width*3,5)
                    love.graphics.rectangle("fill",-self.width*1.5,self.length*1.1 + 5,5,self.length*0.5)
                    love.graphics.rectangle("fill",self.width*1.5 -5,self.length*1.1 + 5,5,self.length*0.5)
                elseif self.suitcase_type == "backpack" then
                    if direction == "left" then
                        -- This is drawn before the torso, so the straps need to be drawn with the other arm
                        setColor(self.suitcase_color)
                        love.graphics.polygon("fill",self.torso_width/2,0,
                                                     self.torso_width/2 + 15,self.length*0.2,
                                                     self.torso_width/2 + 25,self.length*0.4,
                                                     self.torso_width/2 + 30,self.length*0.7,
                                                     self.torso_width/2,self.length*0.72,
                                                     self.torso_width/2,0)
                    elseif direction == "right" then
                        setColor(self.suitcase_color)
                        --love.graphics.rectangle("fill",-self.torso_width/2 - 30,0,30,self.length*0.7)
                        love.graphics.polygon("fill",-self.torso_width/2,0,
                                                     -self.torso_width/2 - 15,self.length*0.2,
                                                     -self.torso_width/2 - 25,self.length*0.4,
                                                     -self.torso_width/2 - 30,self.length*0.7,
                                                     -self.torso_width/2,self.length*0.72,
                                                     -self.torso_width/2,0)
                    end
                end

                -- Arm angled out dragging or holding suitcase
                setColor(self.hand_color)
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