--!strict
-- Auth: @bytenand
-- Date: October 28th, 2025
-- Deps: [Tome]

local CollectionService = game:GetService("CollectionService")

local Types = require("./Types")

--[[
	
	Test
	
]]
return function(filters: {Types.Filter}) : Types.Filterer
	return function(instance: Instance)
		for index: number, filter: Types.Filter in filters do
			if not filter(instance) then
				return false
			end
		end
		
		return true
	end
end