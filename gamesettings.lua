--! file: gamesettings.lua

GameSettings = Object:extend()

function GameSettings:new()
    -- Development and Testing
    self.test_characterGrid   = true
    self.test_directions      = {"left","right"}
    self.test_animationStates = {"sitting","walking","standing"}

    -- Global Parameters
    self.winW = 1280
    self.winH = 1000

    self.difficulty_levels = {"easy","normal","difficult","747-400"}
end

function GameSettings:update(dt)

end