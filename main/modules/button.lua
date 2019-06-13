local function Button(texture, event)
	local object = {}
	object.on = false
	object.event = event

	function object:get_animation()
		local name = texture .. "-"
		if self.on then
			name = name .. "on"
		else
			name = name .. "off"
		end
		return hash(name)
	end

	function object:handle_messages(message_id, message, sender)
		if message_id == hash("interact") then
			self.on = not self.on
			msg.post("#sprite", "play_animation", { id = self:get_animation() })
			msg.post(event, "handle_event")
		end
	end

	return object
end

return Button