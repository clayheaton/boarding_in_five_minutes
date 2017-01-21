-- file: oscillator.lua

Oscillator = Object:extend()

function Oscillator:new(init_angle,speed)
    self.value = 0
    self.speed = speed
    self.angle = init_angle
end

function Oscillator:update(dt)
    self.angle = self.angle + self.speed * dt
    self.value = math.cos(self.angle)
end