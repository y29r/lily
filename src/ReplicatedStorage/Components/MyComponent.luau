--!strict
--!native

const Lily = require("../Packages/Lily/Lily")

export type Props = {
	Style: "Primary" | "Secondary",
}

local function MyComponent(props: Props): Lily.Element
	const clicks: number, setClicks: Lily.SetState<number> = Lily.useState(1)
	const hovering: boolean, setHovering: Lily.SetState<boolean> = Lily.useState(false)
	
	Lily.useEffect(function() : ()
		print("Clicks has updated!")
		print(string.format("Now at %* clicks!", clicks))
	end, {clicks})
	
	return Lily.Button({
		Text = string.format("Clicks: %*", clicks),
		Size = UDim2.fromOffset(175, 200),
		BackgroundColor3 = hovering and Color3.fromRGB(52, 192, 173) or Color3.fromRGB(67, 103, 98),
		
		AnotherButton = Lily.Button {
			Text = "Hello",
			Size = UDim2.fromOffset(50, 50),
		},
		
		[Lily.Events] = {
			Activated = function(reference: TextButton) : ()
				setClicks(function(currentClicks: number)
					return currentClicks + 1
				end)
			end,
			MouseEnter = function(reference: TextButton) : ()
				setHovering(true)
			end,
			MouseLeave = function(reference: TextButton) : ()
				setHovering(false)
			end,
		}
	})
end

return Lily.createElement(MyComponent)