local base_dir = vim.fs.normalize(vim.fs.joinpath(vim.fn.stdpath("config"), "..", "nvim"))
vim.opt.runtimepath:prepend(base_dir)

local lsps = require("shared.lsps")

vim.list_extend(lsps, {
  {
    name = "basedpyright",
    config = {},
    tools = {
      -- configure ruff with .ruff.toml or pyproject.toml file in project repo
      mason = { "ruff" },
      formatters = {
        by_ft = {
          python = { "ruff_fix", "ruff_format" },
        },
      },
      linters = {
        by_ft = {
          python = { "ruff" },
        },
      },
    },
  },
})

dofile(vim.fs.joinpath(base_dir, "init.lua"))
