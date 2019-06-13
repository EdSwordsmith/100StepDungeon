local function Event(callback)
	local object = {}
	object.callback = callback

	function object:handle_messages(message_id, message, sender)
		if message_id == hash("handle_event") then
			self.callback()
		end
	end

	return object
end

return Event