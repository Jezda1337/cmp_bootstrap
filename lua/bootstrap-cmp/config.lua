local M = {}

local default_config = {
	file_types = {
		"html",
	},
	url = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
}

function M:setup(user_config)
	if not user_config then
		user_config = self or {}
	end

	for k, v in pairs(user_config or {}) do
		default_config[k] = v
	end
end

function M.get(what)
	return default_config[what]
end

return M
