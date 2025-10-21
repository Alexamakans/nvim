local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Install your plugins here
return packer.startup(function(use)
  use("wbthomason/packer.nvim") -- Have packer manage itself

  use({ "williamboman/mason.nvim" })
  use({ "WhoIsSethDaniel/mason-tool-installer.nvim" })
  use({ "mason-org/mason-lspconfig.nvim", requires = { "neovim/nvim-lspconfig" } })
  use({ "stevearc/conform.nvim" })
  use({ "mfussenegger/nvim-lint" })
  use({ "hrsh7th/nvim-cmp" })
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-buffer" })
  use({ "neovim/nvim-lspconfig" })
  use({ "hrsh7th/cmp-path" })
  use({ "hrsh7th/cmp-cmdline" })

  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    requires = { "nvim-lua/plenary.nvim" },
  })

  use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
  use("nvim-treesitter/playground")

  use({
    "ray-x/lsp_signature.nvim",
    tag = "v0.3.1",
  })

  use("APZelos/blamer.nvim")

  use({
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons" },
  })

  use({
    "HiPhish/rainbow-delimiters.nvim",
  })

  use({
    "ThePrimeagen/refactoring.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  })

  use({
    "mbbill/undotree",
  })

  use({
    "rose-pine/neovim",
    as = "rose-pine",
    config = function()
      vim.cmd("colorscheme rose-pine")
    end,
  })

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
