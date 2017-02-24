--! file: mainmenu.lua

require "colors"
-- This is the menu you see at the beginning of the game.

MainMenu = Object:extend()

function MainMenu:new()

end

function MainMenu:update(dt)

end

function MainMenu:draw()
	local winW = settings.winW
	local winH = settings.winH
	
	setColor({255,255,255})
	love.graphics.rectangle("fill",0,0,winW,winH)

	-- Start Button
	setColor({80,80,255})
	love.graphics.rectangle("fill",winW*0.75,winH*0.85,winW*0.2,winH*0.1)

	-- Quit Button
	setColor({255,80,80})
	love.graphics.rectangle("fill",winW*0.25 - winW*0.2,winH*0.85,winW*0.2,winH*0.1)

	-- Difficulty Button
	setColor({80,200,80})
	love.graphics.rectangle("fill",winW*0.5 - winW*0.1,winH*0.85,winW*0.2,winH*0.1)
end