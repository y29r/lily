--!strict
--!native

const Types: boolean = require("./Types")

export type ButtonProps = {}

return function(props: ButtonProps): Types.Element
	return {
		kind = "TextButton",
		props = props,
	}
end
