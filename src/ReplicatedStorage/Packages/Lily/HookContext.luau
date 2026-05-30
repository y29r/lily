--!strict
--!native

const Types: boolean = require("./Types")

local current: Types.HookContext? = nil

const HookContext = {}

function HookContext.begin(slots: {any}, rerender: () -> ()) : ()
	current = { slots = slots, index = 0, rerender = rerender }
end

function HookContext.finish() : ()
	current = nil
end

function HookContext.nextSlot() : (number, {any})
	assert(current ~= nil, "Hooks can only be called inside a component function")
		
	current.index += 1
	
	return current.index, current.slots
end

function HookContext.getRerender() : () -> ()
	assert(current ~= nil, "Hooks can only be called inside a component function")
	
	return current.rerender
end

return HookContext