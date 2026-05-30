--!strict
-- Auth: @y29r (Github)
-- Date: 28th May, 2026
-- Deps: []

const Lily = require("../Packages/Lily/Lily")
const Players = require("../Packages/Players/Players")

const MyComponent = require("../Components/MyComponent")

const Controller = {}

function Controller.init() : ()
	const root: Lily.Root = Lily.createRoot(Players.Local.PlayerGui)
	
	root:render(Lily.ScreenGui {
		MyComponent {
			Style = "Primary",
		}
	})
end

return Controller