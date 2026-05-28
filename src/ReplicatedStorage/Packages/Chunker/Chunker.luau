--!strict

local Types = require("./Types")

local Chunker = {}
Chunker.__index = Chunker

function Chunker.new(radius: number, gridSize: number, chunkTemplate: Types.InternalChunk) : Types.Chunker
	local self = setmetatable({
		__lastPoint = Vector3.zero,
		__lastRenderPoint = Vector2.zero,
		
		__radius = radius,
		__gridSize = gridSize,
		
		__chunks = {},
		__chunkTemplate = chunkTemplate,
	}, Chunker) :: any
	
	return self
end

function Chunker:__destroyOutOfBoundChunks() : ()
	for index: number, chunk: Types.Chunk in self.__chunks do
		if not self:__isChunkOutOfRange(chunk.__x, chunk.__y) then
			continue
		end
		
		chunk:Destroy()
		
		table.remove(self.__chunks, index)
	end
end

function Chunker:__isChunkOutOfRange(x: number, y: number) : boolean
	local gridSize: number = self.__gridSize
	local halfGridSize = gridSize / 2
	
	local radius: number = self.__radius
	local lastPoint: Vector3 = self.__lastPoint
	
	local offsetX: number = x * gridSize
	local offsetY: number = y * gridSize
	
	local distanceX: number = math.abs(offsetX + halfGridSize - lastPoint.X)
	local distanceY: number = math.abs(offsetY + halfGridSize - lastPoint.Z)
	
	return math.sqrt(distanceX * distanceX + distanceY * distanceY)
		> radius * gridSize
end

function Chunker:__doesChunkExist(x: number, y: number) : Types.Chunk?
	for _: number, chunk: Types.Chunk in self.__chunks do
		if chunk.__x == x and chunk.__y == y then
			return chunk
		end
	end
	
	return
end

function Chunker:drawAround(point: Vector3) : ()
	local radius: number = self.__radius
	local gridSize: number = self.__gridSize
	
	local halfGridSize: number = gridSize / 2
	
	local lastRenderPoint: Vector2 = Vector2.new(
		math.floor(point.X / gridSize),
		math.floor(point.Z / gridSize)
	)
	
	self.__lastRenderPoint = lastRenderPoint
	self.__lastPoint = point
	
	self:__destroyOutOfBoundChunks()
	
	local chunkTemplate: Types.Chunk = self.__chunkTemplate
	
	local x0: number, x1: number = lastRenderPoint.X - radius, lastRenderPoint.X + radius
	local y0: number, y1: number = lastRenderPoint.Y - radius, lastRenderPoint.Y + radius
	
	for x: number = x0, x1 do
		for y: number = y0, y1 do
			local offsetX: number = x * gridSize
			local offsetY: number = y * gridSize
			
			local distanceX: number = math.abs(offsetX + halfGridSize - point.X)
			local distanceY: number = math.abs(offsetY + halfGridSize - point.Z)
			
			if not (math.sqrt(
				distanceX * distanceX +
				distanceY * distanceY
			) <= radius * gridSize) then
				continue
			end
			
			if self:__doesChunkExist(x, y) then
				continue
			end
			
			local chunk: Types.Chunk = chunkTemplate.new(x, y, gridSize)
			chunk:render()
			
			table.insert(self.__chunks, chunk)
		end
	end
end

function Chunker:Destroy() : ()
	for _: number, chunk: Types.Chunk in self.__chunks do
		chunk:Destroy()
	end
	
	table.clear(self.__chunks)
end

return Chunker