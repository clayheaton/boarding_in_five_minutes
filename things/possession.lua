-- file: possession.lua
-- This is an abstract parent class for something that can be owned by somebody else

Possession = Object:extend()

function Possession:new(owner)
    self.owner = owner
end

function Possession:update(dt)
    
end
