local cmp = require("cmp")
local utils = require("bootstrap-cmp.utils.init")
local config = require("bootstrap-cmp.config")

local Source = {}

function Source:new()
	self.items = {}
	self.cache = {}
	self.classes = {}

	return self
end

function Source:is_available()
	if not vim.tbl_contains(config.get("file_types"), vim.bo.filetype) then
		return false
	end
	return utils.isClassOrClassNameProperty()
end

function Source:complete(_, callback)
	local bufnr = vim.api.nvim_get_current_buf()

	if not self.cache[bufnr] then
		self.status, self.file = utils.getBootstrapCssFile(config.get("url"))

		if self.status ~= 200 then
			vim.notify("Link to external source is not valid", "error", {
				title = "Source not found",
			})
			return
		end

		self.selectors = utils.extract_selectors(self.file)

		self.filtered_table = utils.remove_duplicates(self.selectors)

		for _, class in ipairs(self.filtered_table) do
			table.insert(self.items, {
				label = class,
				kind = cmp.lsp.CompletionItemKind.Enum,
			})
		end

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
