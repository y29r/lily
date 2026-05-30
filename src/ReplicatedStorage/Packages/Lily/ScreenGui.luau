--!strict
--!native

const Types: boolean = require("./Types")

export type ScreenGuiProps = {
	
}

return function(props: ScreenGuiProps): Types.Element
	return {
		kind = "ScreenGui",
		props = props,
	}
end
