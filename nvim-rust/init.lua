local base_dir = vim.fs.normalize(vim.fs.joinpath(vim.fn.stdpath("config"), "..", "nvim"))
vim.opt.runtimepath:prepend(base_dir)

local lsps = require("shared.lsps")
local treesitters = require("shared.treesitters")

vim.list_extend(treesitters, { "rust", "toml" }) -- treesitter parsers to install

vim.list_extend(lsps, {
  {
    name = "rust_analyzer",
    config = {
      settings = {
        ["rust-analyzer"] = {
          check = { command = "clippy" },
          cargo = { allFeatures = true },
        },
      },
    },
  },
  {
    name = "tombi", -- toml lsp/linter/formatter, for Cargo.toml
    config = {},
  },
  {
    tools = {
      mason = { "codelldb" }, -- debug adapter
      formatters = {
        by_ft = {
          rust = { "rustfmt" }, -- ships with the rust toolchain (rustup component add rustfmt)
        },
      },
      linters = {
        by_ft = {},
      },
    },
  },
})

dofile(vim.fs.joinpath(base_dir, "init.lua"))
