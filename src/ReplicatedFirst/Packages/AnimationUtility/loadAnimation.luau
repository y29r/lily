--!strict
-- Auth: @bytenand (Roblox) @y29r (Github)
-- Date: November 25th, 2025
-- Deps: []

return function(toAnimate: Instance, animation: Animation) : AnimationTrack?
	-- TODO: Replace with correct type casting when the beta version of casting gets fixed
	local animators: {Animator} = toAnimate:QueryDescendants("Animator") :: any
	
	local animator: Animator = animators[1]
	if not animator then
		warn("Bad toAnimate #1 argument. Expected an Instance containing an 'Animator' object")
		return
	end
	
	return animator:LoadAnimation(animation)
end