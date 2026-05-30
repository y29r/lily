--!strict
--!native

const Types: boolean = require("../Types")

const isElement = require("./isElement")
const applyProps = require("./applyProps")

const HookContext = require("../HookContext")

type Element = Types.Element
type Node = Types.Node
type PropKey = Types.PropKey
type Kind = Types.Kind
type Props = Types.Props

function renderInstanceNode(element: Element, parent: Instance) : Node
	const kind: string = element.kind :: string
	local props: {[PropKey]: any} = element.props
	
	const instance: Instance = Instance.new(kind)
	local disconnectProps: () -> () = applyProps(instance, props)
	
	local childNodes: {[PropKey]: Node} = {}
	for key: PropKey, value in props do
		if isElement(value) then
			childNodes[key] = renderNode(value :: Element, instance)
		end
	end
	
	instance.Parent = parent
	
	local node: Node; node = {
		cleanup = function() : ()
			disconnectProps()
			
			for key: PropKey, childNode: Node in childNodes do
				childNode.cleanup()
			end
			
			instance:Destroy()
		end,
		
		update = function(newElement: Element) : Node
			if newElement.kind ~= kind then
				node.cleanup()
				
				return renderNode(newElement, parent)
			end
			
			disconnectProps()
			disconnectProps = applyProps(instance, newElement.props)
			
			const seen: {[PropKey]: boolean} = {}
			for key: PropKey, value: any in newElement.props do
				if isElement(value) then
					seen[key] = true
					
					childNodes[key] = childNodes[key] and childNodes[key].update(value) or renderNode(value, instance)
				end
			end
			
			for key: PropKey, childNode: Node in childNodes do
				if not seen[key] then
					childNode.cleanup()
					childNodes[key] = nil
				end
			end
			
			return node
		end
	}
	
	return node
end

function renderNode(element: Element, parent: Instance): Node
	const kind: Kind = element.kind
	local props: Props = element.props
	
	if type(kind) == "string" then
		return renderInstanceNode(element, parent)
	elseif type(kind) == "function" then
		local slots: {any} = {}
		
		local isUnmounted: boolean = false
		local currentNode: Node? = nil
		
		local node: Node = {} :: Node
		
		const function rerender() : ()
			if isUnmounted then
				return
			end
			
			HookContext.begin(slots, rerender)
			
			const childElement: Element = kind(props)
			
			HookContext.finish()
			
			currentNode = currentNode and currentNode.update(childElement) or renderNode(childElement, parent)
		end
		
		rerender()
		
		function node.cleanup() : ()
			isUnmounted = true
			
			if currentNode then
				currentNode.cleanup()
				currentNode = nil
			end
			
			for index: number, slot: any in slots do
				if type(slot) == "table" and type(slot.cleanup) == "function" then
					slot.cleanup()
				end
			end
		end
		
		function node.update(newElement: Element) : Node
			props = newElement.props
			
			rerender()
			
			return node
		end
		
		return node
	end
	
	return {
		cleanup = function() end,
		
		update = function(newElement: Element) : Node
			return renderNode(newElement, parent)
		end,
	}
end

return renderNode