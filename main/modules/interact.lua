local function Interact(cooldown)
	local object = {}
	object.timer = cooldown
	object.can_interact = true

	object.update = function(dt)
		if object.can_interact == false then
			object.timer = object.timer - dt
		end

		if object.timer <= 0 then
			object.can_interact = true
		end
	end

	object.interact = function(dir)
		if object.can_interact and vmath.length_sqr(dir) == 1 then
			local pos = go.get_position()
			local to = pos + dir * 16
			local ray = physics.raycast(pos, to, { hash("objects") })

			object.timer = cooldown
			object.can_interact = false

			if ray ~= nil then
				msg.post(ray.id, "interact")
				return true
			end
		end
		return false
	end

	return object
end

return Interact