--!strict

export type InternalChunk = {
	new: (x: number, y: number, gridSize: number) -> Chunk,
}

export type Chunk = {
	__x: number,
	__y: number,
	
	__gridSize: number,
	__instances: {},
	
	new: (x: number, y: number, gridSize: number) -> Chunk,
	
	render: (self: Chunk) -> Chunk,
	Destroy: (self: Chunk) -> (),
} & InternalChunk

export type Chunker = {
	__lastPoint: Vector3,
	__lastRenderPoint: Vector2,
	
	__radius: number,
	__gridSize: number,
	
	__chunks: {Chunk},
	__chunkTemplate: Chunk,
	
	new: (radius: number, gridSize: number, chunkTemplate: Chunk) -> Chunker,
	
	drawAround: (self: Chunker, point: Vector3) -> (),
	
	Destroy: (self: Chunker) -> (),
	
	__destroyOutOfBoundChunks: (self: Chunker) -> (),
	__isChunkOutOfRange: (self: Chunker, x: number, y: number) -> boolean,
	__doesChunkExist: (self: Chunker, x: number, y: number) -> Chunk?,
}

return table.freeze({})