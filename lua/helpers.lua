local M = {}
local curl = require("plenary.curl")

function M.getBootstrapCssFile(url)
	local response = curl.get(url)
	if not response then
		print("curl ne radi")
		return nil, {}
	end

	return response.body
end

function M.isClassOrClassNameProperty()
	local line = vim.api.nvim_get_current_line()

	if line:match('class%s-=%s-".-"') or line:match('className%s-=%s-".-"') then
		local cursor_pos = vim.api.nvim_win_get_cursor(0)
		local class_start_pos, class_end_pos = line:find('class%s-=%s-".-"')
		local className_start_pos, className_end_pos = line:find('className%s-=%s-".-"')

		if
			(class_start_pos and class_end_pos and cursor_pos[2] > class_start_pos and cursor_pos[2] <= class_end_pos)
			or (
				className_start_pos
				and className_end_pos
				and cursor_pos[2] > className_start_pos
				and cursor_pos[2] <= className_end_pos
			)
		then
			return true
		else
			return false
		end
	end
end

function M.remove_duplicates(t)
	local seen = {}
	local result = {}

	for _, value in ipairs(t) do
		if not seen[value] then
			table.insert(result, value)
			seen[value] = true
		end
	end

	return result
end

return M
