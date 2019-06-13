local function Event(callback, instance)
	local object = {}
	object.callback = callback
	object.instance = instance

	function object:handle_messages(message_id, message, sender)
		if message_id == hash("handle_event") then
			if instance ~= nil then
				self.callback(instance)
			else
				self.callback()
			end
		end
	end

	return object
end

return Event