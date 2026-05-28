--!strict
-- Auth: @bytenand (Roblox) @y29r (Github)
-- Date: November 25th, 2025
-- Deps: []

local loadAnimation = require("./loadAnimation")
local createAnimation = require("./createAnimation")

return function(toAnimate: Instance, animationId: string) : AnimationTrack?
	return loadAnimation(toAnimate, createAnimation(animationId))
end