--!strict
--!native

const Types: boolean = require("../Types")

const renderNode = require("./renderNode")

const Tokens = require("../Tokens")
const Events = Tokens.Events

type Element = Types.Element
type Node = Types.Node

const Reconciler = {
	Events = Events,
}

function Reconciler.createRoot(parent: Instance): Types.Root
	local currentNode: Node? = nil
	
	const root = {}
	
	function root:render(element: Types.Element): ()
		if currentNode then
			currentNode = currentNode.update(element)
		else
			currentNode = renderNode(element, parent)
		end
	end
	
	function root:unmount(): ()
		if currentNode then
			currentNode.cleanup()
			currentNode = nil
		end
	end
	
	return root
end

return Reconciler