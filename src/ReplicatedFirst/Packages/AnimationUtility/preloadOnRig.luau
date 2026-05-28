--!strict
-- Auth: @bytenand (Roblox) @y29r (Github)
-- Date: November 25th, 2025
-- Deps: []

local Players = game:GetService("Players")

local createAndLoadAnimation = require("./createAndLoadAnimation")

return function(animationIds: {string}) : {[string]: number}
	local rig: Model = Players:CreateHumanoidModelFromUserId(1);
	(rig:WaitForChild("HumanoidRootPart") :: BasePart).Anchored = true
	rig:PivotTo(CFrame.new(0, 0, 0))
	rig.Parent = workspace
	
	local animators: {Instance} = rig:QueryDescendants("Animator")
	local animator: Instance = animators[1]
	if not (animator and animator:IsA("Animator")) then
		return {}
	end
	
	local lengths: {[string]: number} = {}
	local loadedAnimationIds: number = 0
	
	local currentThread: thread = coroutine.running()
	
	for index: number, animationId: string in animationIds do
		task.spawn(function()
			local track: AnimationTrack? = createAndLoadAnimation(rig, animationId)
			if track then
				track:Play(0, 1, 1)
				
				-- TODO: Something more robust down the line
				repeat
					task.wait()
				until track.Length > 0
				
				lengths[animationId] = track.Length
				loadedAnimationIds += 1
				
				if loadedAnimationIds == #animationIds then
					coroutine.resume(currentThread)
				end
			end
		end)
	end
	
	-- sometimes animations can fail completely, this is a fallback to ensure the game at least loads
	task.delay(15, function()
		coroutine.resume(currentThread)
	end)
	
	coroutine.yield()
	
	rig:Destroy()
	
	return lengths
end