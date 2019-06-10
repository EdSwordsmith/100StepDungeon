local M = {}

function M.new(cooldown)
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

	object.move = function(dir)
		if object.can_move then
			local pos = go.get_position()
			local to = pos + dir * 16
			local ray = physics.raycast(pos, to, { hash("default") })

			if ray == nil then
				go.animate(".", "position", go.PLAYBACK_ONCE_FORWARD, to, go.EASING_OUTSINE, cooldown)
			end
			object.timer = cooldown
			object.can_move = false
		end
	end

	return object
end

return M