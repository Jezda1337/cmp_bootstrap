local cmp = require("cmp")
local cmp_config = require("cmp.config")
local utils = require("helpers")
-- local default_config = require("config")

local default_config = {
	file_types = {
		"html",
	},
}
local Source = {
	config = default_config,
}

function Source:new()
	self.items = {}
	self.cache = {}
	self.classes = {}
	self.class_pattern = "%.[a-zA-Z_][%w-]*"
	local url = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.css"
	self.file = utils.getBootstrapCssFile(url)

	for class in self.file:gmatch(self.class_pattern) do
		local class_name = string.sub(class, 2)
		table.insert(self.classes, class_name)
	end

	self.filtered_table = utils.remove_duplicates(self.classes)

	for _, class in ipairs(self.filtered_table) do
		table.insert(self.items, {
			label = class,
			kind = cmp.lsp.CompletionItemKind.Class,
			documentation = "Bootstrap class",
			-- documentation = {
			-- 	kind = "markdown",
			-- 	value = string.format("# %s\n\n%s", class, class),
			-- },
		})
	end

	return self
end

function Source:is_available()
	return utils.isClassOrClassNameProperty()
end

function Source:complete(_, callback)
	local bufnr = vim.api.nvim_get_current_buf()

	if not self.cache[bufnr] then
		callback({ items = self.items, isIncomplete = false })
		self.cache[bufnr] = self.items
	else
		callback({ items = self.cache[bufnr], isIncomplete = false })
	end
end

function Source:setup()
	require("cmp").register_source("bootstrap", Source)
end

return Source:new()
