local function Attack(cooldown)
	local object = {}
	object.timer = cooldown
	object.can_attack = true

	object.update = function(dt)
		if object.can_attack == false then
			object.timer = object.timer - dt
		end

		if object.timer <= 0 then
			object.can_attack = true
		end
	end

	object.attack = function(dir)
		if object.can_attack and vmath.length_sqr(dir) == 1 then
			local pos = go.get_position()
			local to = pos + dir * 16
			local ray = physics.raycast(pos, to, { hash("player") })

			if ray ~= nil then
				msg.post(hash("/level"), "action_use", { amount = 5 })
			end

			object.timer = cooldown
			object.can_attack = false
			return true
		end
		return false
	end

	return object
end

return Attack