local base_dir = vim.fs.normalize(vim.fs.joinpath(vim.fn.stdpath("config"), "..", "nvim"))
vim.opt.runtimepath:prepend(base_dir)

local lsps = require("shared.lsps")
local treesitters = require("shared.treesitters")

vim.list_extend(treesitters, { "markdown", "lua" })

vim.list_extend(lsps, {
  {
    name = "lua_ls",
    config = {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = {
            globals = { "vim" }, -- ← fixes “(global) vim: unknown”
          },
          workspace = {
            checkThirdParty = false,
            library = { vim.env.VIMRUNTIME }, -- if you want stdlib defs
          },
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
})

dofile(vim.fs.joinpath(base_dir, "init.lua"))
