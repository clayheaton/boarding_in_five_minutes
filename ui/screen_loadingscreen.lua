--! file: screen_loadingscreen.lua

require "colors"
-- This is the menu you see at the beginning of the game.

LoadingScreen = Object:extend()

function LoadingScreen:new()
	self.main_title   = "Creating a New Game"
	self.sub_title    = "One moment please..."
	self.loading_text = "..."

end

function LoadingScreen:update(dt)

end

function LoadingScreen:draw()
	love.graphics.setBackgroundColor( 200,200,220 )

	setColor(color_black)
	love.graphics.setFont(main_title_font);
	love.graphics.printf( self.main_title, settings.winW*0.5 - 400, 200, 800, "center" )

	love.graphics.setFont(sub_title_font)
	love.graphics.printf( self.sub_title, settings.winW*0.5 - 400, 400, 800, "center" )

	love.graphics.setFont(loading_font)
	love.graphics.printf( self.loading_text, settings.winW*0.5 - 400, 600, 800, "center" )
end

function LoadingScreen:displayText(text_to_display)
	self.loading_text = text_to_display
end

function LoadingScreen:checkKeyDown()
    print("Caught checkKeyDown() in LoadingScreen")
end 

function LoadingScreen:keypressed(key,scancode,isreapeat)

end

function LoadingScreen:mousepressed(x, y, button, istouch)
	print("LoadingScreen clicked.")
end