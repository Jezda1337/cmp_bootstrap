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
{} -- need to implement configuration

```

# Todo

- [ ] cmp documentation should contain css code for selected class.
- [ ] default config for filetypes and for max_count is needed.
- [ ] user should have ability to chage config.
- [ ] finish readme file.
- [ ] detect style or src links in html file for bootstrap.
- [ ] user should put he's version of bootstrap url.
