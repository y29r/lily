--!strict
-- Auth: @bytenand (Roblox) @y29r (Github)
-- Date: November 25th, 2025
-- Deps: []

--[[
	
	
]]
return function(parent: Instance?) : (instance: Instance) -> (boolean)
	if not parent then
		return function(instance: Instance)
			return false
		end
	end
	
	return function(instance: Instance)
		return instance:IsDescendantOf(parent)
	end
end