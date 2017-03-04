--! file: button.lua

require "colors"
require "convenience"

Button = Object:extend()

function Button:new(name,label,color,text_color,action_function,x,y,w,h)
	self.name            = name
	self.label           = label
	self.color           = color 
	self.text_color      = text_color
	self.action_function = action_function
	self.x = x
	self.y = y
	self.w = w
	self.h = h

	self.x2 = self.x + self.w 
	self.y2 = self.y + self.h 
end

function Button:update(dt)

end

function Button:draw()
	rectFill(self.x,self.y,self.w,self.h,self.color)
end

function Button:catchMousePressedEvent(x,y)
	if x >= self.x and x <= self.x2 and y >= self.y and y <= self.y2 then
		print(self.name,"clicked")
		self.action_function()
		return true
	end
	return false
end