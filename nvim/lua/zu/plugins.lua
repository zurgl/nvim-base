local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	Packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd([[packadd packer.nvim]])
end

-- Autocomand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have a packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugin here
return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")

	-- Colorscheme
	use("gruvbox-community/gruvbox")
	use("sainnhe/gruvbox-material")
	use("sainnhe/everforest")
	use("arcticicestudio/nord-vim")
	use("folke/tokyonight.nvim")
	use("Shatur/neovim-ayu")
	use("psliwka/vim-smoothie")

	-- Parenthesis stuff
	use("windwp/nvim-autopairs")
	use("p00f/nvim-ts-rainbow")

	-- Comment stuff
	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- Nvim Tree
	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")

	-- Bufferline
	use("akinsho/bufferline.nvim")
	use("moll/vim-bbye")

	-- Git
	use("lewis6991/gitsigns.nvim")

	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					theme = "tokyonight",
				},
			})
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				show_current_context = true,
				show_current_context_start = true,
			})
		end,
	})
	use({
		"goolord/alpha-nvim",
		config = function()
			require("alpha").setup(require("alpha.themes.startify").opts)
			local startify = require("alpha.themes.startify")
			startify.section.bottom_buttons.val = {
				startify.button("e", "new file", ":ene <bar> startinsert <cr>"),
				startify.button("v", "neovim config", ":e ~/.config/nvim/init.lua<cr>"),
				startify.button("q", "quit nvim", ":qa<cr>"),
			}
			vim.api.nvim_set_keymap("n", "<c-n>", ":Alpha<cr>", { noremap = true })
		end,
	})

	-- autocompletion plugins
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use{"f3fora/cmp-spell"}

	-- Snippet engine
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- rust specific
	use({
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		config = function()
			require("crates").setup()
		end,
	})
	use("simrat39/rust-tools.nvim")
	use("neovim/nvim-lspconfig") -- enable LSP

	-- to migrate to mason.vim
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })

	-- Telescope
	use("nvim-telescope/telescope.nvim")

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	-- toggle term
	use("akinsho/toggleterm.nvim")

	-- debugger
	use("mfussenegger/nvim-dap")
	use({ "nvim-telescope/telescope-dap.nvim" })

	if Packer_bootstrap then
		require("packer").sync()
	end
end)
