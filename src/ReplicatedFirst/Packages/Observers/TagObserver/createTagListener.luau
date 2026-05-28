--!strict
-- Auth: @bytenand
-- Date: October 28th, 2025
-- Deps: [Tome]

local CollectionService = game:GetService("CollectionService")

local Tome = require("../../Tome/Tome")

local Types = require("./Types")

return function(
	signalName: string,
	includeExistingInstances: boolean
)
	return function<instance>(tag: string, callback: (instance: instance) -> (), middleware: ((instance: instance) -> boolean)?)
		local observerTome: Tome.Tome = Tome.new()
		
		local function instanceWithTagAdded(instance: instance)
			if middleware and not middleware(instance) then
				return
			end
			
			callback(instance)
		end
		
		if signalName == "GetInstanceAddedSignal" then
			observerTome:Connect(CollectionService:GetInstanceAddedSignal(tag), instanceWithTagAdded)
		elseif signalName == "GetInstanceRemovedSignal" then
			observerTome:Connect(CollectionService:GetInstanceRemovedSignal(tag), instanceWithTagAdded)
		end
		
		if includeExistingInstances then
			for index: number, instance: instance in CollectionService:GetTagged(tag) do
				task.spawn(instanceWithTagAdded, instance)
			end
		end
		
		return observerTome:WrapDestroy()
	end
end