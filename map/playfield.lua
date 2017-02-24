--! file: playfield.lua
-- The playfield consists of the Terminal and the Plane.  

require "colors"

Playfield = Object:extend()

function Playfield:new()
	self.terminal = Terminal()
end

function Playfield:update(dt)

end

function Playfield:draw()

end