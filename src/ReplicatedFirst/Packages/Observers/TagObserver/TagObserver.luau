--!strict
-- Auth: @bytenand
-- Date: October 28th, 2025
-- Deps: [Tome]

local createTagListener = require("./createTagListener")
local createFilter = require("./createFilter")
local getAll = require("./getAll")

local Enscope = require("./Filters/Enscope")
local HasTag = require("./Filters/HasTag")
local DoesntHaveTag = require("./Filters/DoesntHaveTag")
local EqualAttribute = require("./Filters/EqualAttribute")
local Character = require("./Filters/Character")

local Types = require("./Types")

export type Filter = Types.Filter
export type Filterer = Types.Filterer

local TagObserver = {
	getAll = getAll,
	observeAdd = createTagListener("GetInstanceAddedSignal", true),
	observeRemove = createTagListener("GetInstanceRemovedSignal", false),
	
	createTagListener = createTagListener,
	createFilter = createFilter,
	
	Enscope = Enscope,
	HasTag = HasTag,
	DoesntHaveTag = DoesntHaveTag,
	EqualAttribute = EqualAttribute,
	Character = Character,
}

return TagObserver