--! file: gamestate.lua

GameState = Object:extend()

function GameState:new()
	self.active_difficulty_level = 2

	-- If seed game, then the seed is the difficulty level followed by the seed.
	-- If not, difficulty is the seed followed by a random integer
	self.seed_game = false
	self.game_seed = 2
end

function GameState:update(dt)

end