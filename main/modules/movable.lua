local function Movable(cooldown)
	local object = {}
	object.timer = cooldown
	object.can_move = true

	object.update = function(dt)
		if object.can_move == false then
			object.timer = object.timer - dt
		end

		if object.timer <= 0 then
			object.can_move = true
		end
	end

	object.move = function(dir, g)
		local groups = g
		
		if g == nil then
			groups = { hash("tiles"), hash("objects"), hash("enemy") }
		end
		
		if object.can_move and vmath.length_sqr(dir) == 1 then
			local pos = go.get_position()
			local to = pos + dir * 16
			local ray = physics.raycast(pos, to, groups)
			
			object.timer = cooldown
			object.can_move = false

			if ray == nil then
				go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, to, go.EASING_OUTSINE, cooldown)
				return true
			end
		end
		return false
	end

	return object
end

return Movable