--!strict
-- Auth: @bytenand (Roblox) @y29r (Github)
-- Date: November 25th, 2025
-- Deps: []

--[[
	
	
]]
return function(player: Player) : (instance: Instance) -> (boolean)
	return function(instance: Instance)
		local character: Model? = player.Character
		if character then
			return instance:IsDescendantOf(character)
		end
		
		return false
	end
end