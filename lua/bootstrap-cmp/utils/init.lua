local M = {}
local curl = require("plenary.curl")

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


-- CSS properties from the Bootstrap css file is minified, they look like this:
-- display:flex!important;justify-content:center!important;align-items:center!important;
--
-- This function "beautify" them, into this:
-- display: flex !important;
-- justify-content: center !important;
-- align-items: center !important;
local function beautify_css_properties(p)
  return p:gsub('[:!;]', function(match)
    if match == '!' then
      return ' !'
    elseif match == ':' then
      return ': '
    elseif match == ';' then
      return ';\n'
    else
      return '%1'
    end
  end)
end


function M.extract_rules(tbl)
  local rules_pattern = "%.([a-zA-Z_][%w-]*){(.-)}"
  local rules = {}

  for class_name, properties in tbl:gmatch(rules_pattern) do
    table.insert(rules, { class_name = class_name, css_properties = beautify_css_properties(properties) })
  end

  return rules
end

function M.remove_duplicates(t)
  local seen = {}
  local result = {}

  for _, value in ipairs(t) do
    if not seen[value['class_name']] then
      table.insert(result, value)
      seen[value['class_name']] = true
    end
  end

  return result
end

return M
