--! file: mainmenu.lua

require "main"
require "colors"
require "ui.button"
require "actors.person"
-- This is the menu you see at the beginning of the game.

MainMenu = Object:extend()

function MainMenu:new()
	self.buttons = {}

	self.main_title   = "Boarding in Five Minutes"

	local winW = settings.winW
	local winH = settings.winH

	-- Start Button name,label,color,text_color,x,y,w,h
	local button_start = Button("button_start","Play",{80,80,255},color_white,startNewGame,winW*0.75,winH*0.85,winW*0.2,winH*0.1)
	local button_quit  = Button("button_quit","Quit",{255,80,80},color_white,quitGame,winW*0.25 - winW*0.2,winH*0.85,winW*0.2,winH*0.1)
	local button_diff  = Button("button_diff","Difficulty",{80,200,80},color_white,changeDifficulty,winW*0.5 - winW*0.1,winH*0.85,winW*0.2,winH*0.1)

	table.insert(self.buttons,button_start)
	table.insert(self.buttons,button_quit)
	table.insert(self.buttons,button_diff)

	self.people = self:generatePeople()

end

function MainMenu:generatePeople()
    local newpeople = {}
    for i=1,20 do

    	local person = Person()
    	person:setDirection("right")
    	person:setAnimationState("walking")
    	person:normalizeSpeedVariation()

    	person.y          = 600
    	person.x          = (i-1)*175 - 20*175
    	person.targetX    = 1500
    	person.has_target = true
    	

    	table.insert(newpeople,person)

    end
    return newpeople
end

function MainMenu:update(dt)
    for i=1,#self.people do
        local person = self.people[i]
        person:update(dt)

        -- If off screen, move back to the left
        if person.x > settings.winW + 175 then
        	person.x = person.x - (20 * 175)
        end
    end  
end

function MainMenu:draw()
	love.graphics.setBackgroundColor( 255,255,255 )

	setColor(color_black)
	love.graphics.setFont(main_title_font);
	love.graphics.printf( self.main_title, settings.winW*0.5 - 400, 200, 800, "center" )

	love.graphics.setFont(sub_title_font);
	for i=1,#self.buttons do
		self.buttons[i]:draw()
	end

	love.graphics.push()
	love.graphics.scale(1.75,1.75)
	love.graphics.translate(0,-150)
	for i=1,#self.people do
		self.people[i]:draw()
	end
	love.graphics.pop()
end

function MainMenu:keypressed(key,scancode,isreapeat)

end

function MainMenu:checkKeyDown()
    print("Caught checkKeyDown() in MainMenu")
end 

function MainMenu:mousepressed(x, y, button, istouch)
	if button == 1 then
		for i=1,#self.buttons do
			local hit = self.buttons[i]:catchMousePressedEvent(x,y)
			if hit then
				return
			end
		end
	end
end

function MainMenu:displayText(text_to_display)

end