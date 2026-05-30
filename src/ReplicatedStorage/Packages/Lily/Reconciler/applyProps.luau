--!strict
--!native

const Types: boolean = require("../Types")

const isElement: (object: any) -> boolean = require("./isElement")

const Tokens = require("../Tokens")
const Events = Tokens.Events

type Props = Types.Props
type PropKey = Types.PropKey

return function(instance: Instance, props: Props): () -> ()
	const connections: {RBXScriptConnection} = {}
	
	for key: PropKey, value: any in props do
		if isElement(value) then
			continue
		elseif key == Events then
			for eventName: string, handler: (reference: Instance) -> () in value do
				table.insert(connections, (instance :: any)[eventName]:Connect(handler))
			end
		else
			(instance :: any)[key] = value
		end
	end
	
	return function()
		for index: number, connection: RBXScriptConnection in connections do
			connection:Disconnect()
		end
	end
end