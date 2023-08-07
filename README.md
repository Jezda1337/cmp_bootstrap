### ⚠️ The cmp_bootstrap project has been abandoned for [nvim-html-css](https://github.com/Jezda1337/nvim-html-css)

# cmp_bootstrap

Bootstrap source for [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)

# Install

## Using plugin manager

Using [Lazy](https://github.com/folke/lazy.nvim/):

```lua
return require("lazy").setup({
 { "Jezda1337/cmp_bootstrap" }
})
```

# Setup

## Enable plugin

```lua
require'cmp'.setup {
	sources = {
		{ name = 'bootstrap' },
	},
}
```

## Configuration

```lua
require("bootstrap-cmp.config"):setup({
    file_types = { ... },
    url = "..."
})

```
