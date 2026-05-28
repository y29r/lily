--!strict
-- Auth: @bytenand (Roblox) @y29r (Github)
-- Date: November 25th, 2025
-- Deps: []

--[[
	
	
]]
return function(tag: string) : (instance: Instance) -> (boolean)
	return function(instance: Instance)
		return instance:HasTag(tag)
	end
end