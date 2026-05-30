--!strict
--!native

const Types: boolean = require("./Types")

type Element = Types.Element
type Props = Types.Props
type ComponentFunction = Types.ComponentFunction

return function(kind: ComponentFunction) : ComponentFunction
	return function(props: Props) : Element
		return {
			kind = kind,
			props = props
		}
	end
end