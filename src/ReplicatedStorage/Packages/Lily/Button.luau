--!strict
--!native

const Types: boolean = require("./Types")

export type ButtonProps = {
	Text: string?,
	Size: UDim2?,
	BackgroundColor3: Color3?,
}

return function(props: ButtonProps): Types.Element
	return {
		kind = "TextButton",
		props = props,
	}
end
