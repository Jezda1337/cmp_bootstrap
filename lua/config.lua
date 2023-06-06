local M = {}

local default_config = {
	file_types = {
		"html",
	},
}

function M:setup(user_config)
	if not user_config then
		print("user_config je prazan ili ne radi kako treba")
		user_config = self or {}
	end

	for k, v in pairs(user_config or {}) do
		default_config[k] = v
	end
end

function M:get(what)
	return default_config[what]
end

return M
