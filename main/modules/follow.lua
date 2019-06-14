local M = {}

function M.get_dir(pos, target, direction)
	local dir = direction
	local delta = target - pos
	if delta.x == 0 and delta.y == 0 then
		delta.x = -1
	end

	if math.abs(delta.x) > math.abs(delta.y) then
		dir.x = delta.x / math.abs(delta.x)
		dir.y = 0
	else
		dir.y = delta.y / math.abs(delta.y)
		dir.x = 0
	end

	local to = pos + dir * 16
	local ray = physics.raycast(pos, to, { hash("tiles"), hash("objects"), hash("enemy") })

	if ray ~= nil then
		if math.abs(dir.x) > math.abs(dir.y) then
			dir.y = math.random(-1,1)
			dir.x = 0
		else
			dir.x = math.random(-1, 1)
			dir.y = 0
		end
	end

	return dir
end

return M