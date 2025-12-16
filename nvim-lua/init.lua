local base_dir = vim.fs.normalize(vim.fs.joinpath(vim.fn.stdpath("config"), "..", "nvim"))
vim.opt.runtimepath:prepend(base_dir)

local lsps = require("shared.lsps")

vim.list_extend(lsps, {
  {
    name = "lua_ls",
    config = {
      settings = {
        Lua = {
          format = {
            enable = true,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    },
  },
  {
    tools = {
      mason = { "luacheck", "stylua" },
      formatters = {
        by_ft = {
          lua = { "stylua" },
        },
      },
      linters = {
        by_ft = {
          lua = { "luacheck" },
        },
      },
    },
  },
})

dofile(vim.fs.joinpath(base_dir, "init.lua"))
