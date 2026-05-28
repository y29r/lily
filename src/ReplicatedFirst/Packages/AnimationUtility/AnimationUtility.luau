--!strict
-- Auth: @bytenand (Roblox) @y29r (Github)
-- Date: November 25th, 2025
-- Deps: []

local loadAnimation = require("./loadAnimation")
local createAnimation = require("./createAnimation")
local createAndLoadAnimation = require("./createAndLoadAnimation")
local preloadOnRig = require("./preloadOnRig")

local AnimationUtility = {
	loadAnimation = loadAnimation,
	createAnimation = createAnimation,
	createAndLoadAnimation = createAndLoadAnimation,
	preloadOnRig = preloadOnRig,
}

return AnimationUtility