--!strict

local Types = require("../Types")

local terrain: Terrain? = workspace.Terrain

local Chunk = {}
Chunk.__index = Chunk

function Chunk.new(x: number, y: number, gridSize: number) : Types.Chunk
	local self = setmetatable({
		__x = x,
		__y = y,
		
		__gridSize = gridSize,
		__instances = {},
	}, Chunk) :: any
	
	return self
end

function Chunk:render() : Types.Chunk
	local x: number = self.__x
	local y: number = self.__y
	local gridSize: number = self.__gridSize
	
	if terrain then
		terrain:FillBlock(
			CFrame.new(x * gridSize, 1, y * gridSize),
			Vector3.new(gridSize, 1.5, gridSize),
			Enum.Material.Water
		)
	end
	
	
	return self
end

function Chunk:Destroy() : ()
	local x: number = self.__x
	local y: number = self.__y
	local gridSize: number = self.__gridSize
	
	if terrain then
		terrain:FillBlock(
			CFrame.new(x * gridSize, 1, y * gridSize),
			Vector3.new(gridSize, 1.5, gridSize),
			Enum.Material.Air
		)
	end
end

return Chunk