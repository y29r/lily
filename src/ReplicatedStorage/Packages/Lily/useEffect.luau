--!strict
--!native

const HookContext = require("./HookContext")

return function(callback: () -> (() -> ()?), dependencies: { any }): ()
	const index: number, slots: {any} = HookContext.nextSlot()
	
	if not slots[index] then
		slots[index] = { deps = nil, cleanup = nil }
	end
	
	const slot: any = slots[index]
	local changed: boolean = slot.deps == nil
	
	if not changed then
		for pindex: number, dependency: any in dependencies do
			if dependency ~= slot.deps[pindex] then
				changed = true
				
				break
			end
		end
	end
	
	if changed then
		if slot.cleanup then
			slot.cleanup()
			slot.cleanup = nil
		end
		
		const result: () -> ()? = callback()
		
		if type(result) == "function" then
			slot.cleanup = result
		end
		
		slot.deps = table.clone(dependencies)
	end
end