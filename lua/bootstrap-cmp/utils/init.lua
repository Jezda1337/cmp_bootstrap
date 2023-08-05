local M = {}
local curl = require("plenary.curl")

local VALID_PREFIXES = { 'class', 'className' }
local VALID_QUOTES = { [["]], [[']]}

function M.getBootstrapCssFile(url)
	local response = curl.get(url)
	if not response then
		print("curl ne radi")
		return nil, {}
	end

	return response.status, response.body
end

function M.isClassOrClassNameProperty()
  local line = vim.api.nvim_get_current_line()

  for _, prefix in pairs(VALID_PREFIXES) do
    local quotes_alternation = '([' .. table.concat(VALID_QUOTES) .. '])'
    -- Full pattern: class%s-=%s-(["']).-%1
    local pattern = prefix .. '%s-=%s-' .. quotes_alternation .. '.-%1'

    local start_pos, end_pos = line:find(pattern)
    local cursor_pos = vim.api.nvim_win_get_cursor(0)

    if (start_pos and end_pos and cursor_pos[2] > start_pos and cursor_pos[2] <= end_pos) then
      return true
    end
  end

  return false
end

function M.extract_selectors(tbl)
	local selectors_pattern = "%.[a-zA-Z_][%w-]*"
	local selectors = {}

	for class in tbl:gmatch(selectors_pattern) do
		local class_name = string.sub(class, 2)
		table.insert(selectors, class_name)
	end

	return selectors
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
