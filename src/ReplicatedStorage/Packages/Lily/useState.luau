--!strict
--!native

const Types: boolean = require("./Types")
const HookContext = require("./HookContext")

export type SetState<Generic> = Types.SetState<Generic>

return function<Generic>(initialState: Generic): (Generic, SetState<Generic>)
	const index: number, slots: {any} = HookContext.nextSlot()
	const rerender: () -> () = HookContext.getRerender()
	
	if not slots[index] then
		slots[index] = { value = initialState }
	end
	
	const slot: any = slots[index]
	
	const function setter(newValue: ((Generic) -> Generic) | Generic) : Generic
		if type(newValue) == "function" then
			slot.value = newValue(slot.value)
		else
			slot.value = newValue
		end
		
		rerender()
		
		return slot.value
	end

	return slot.value, setter
end