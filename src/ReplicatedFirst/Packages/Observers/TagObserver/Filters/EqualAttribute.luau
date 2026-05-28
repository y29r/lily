--!strict
-- Auth: @bytenand (Roblox) @y29r (Github)
-- Date: November 25th, 2025
-- Deps: []

--[[
	
	
]]
return function(attributeName: string, expectedValue: any) : (instance: Instance) -> (boolean)
	return function(instance: Instance)
		return instance:GetAttribute(attributeName) == expectedValue
	end
end