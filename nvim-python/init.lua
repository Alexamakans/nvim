local base_dir = vim.fs.normalize(vim.fs.joinpath(vim.fn.stdpath("config"), "..", "nvim"))
vim.opt.runtimepath:prepend(base_dir)

local lsps = require("shared.lsps")

vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    require("nvim-treesitter.parsers")["xpath"] = {
      install_info = {
        path = vim.fn.stdpath("config") .. "/tree-sitter-xpath",
        files = { "src/parser.c" },
        queries = "queries",
      },
    }
  end,
})

-- Also register immediately for the first run
require("nvim-treesitter.parsers")["xpath"] = {
  install_info = {
    path = vim.fn.stdpath("config") .. "/tree-sitter-xpath",
    files = { "src/parser.c" },
    queries = "queries",
  },
}

local treesitters = require("shared.treesitters")
vim.list_extend(
  treesitters,
  { "python", "toml", "yaml", "json", "markdown", "bash", "html", "xpath", "xml" }
)

vim.list_extend(lsps, {
  {
    name = "basedpyright",
    config = {
      settings = {
        basedpyright = {
          analysis = {
            diagnosticSeverityOverrides = {
              reportUnknownMemberType = "none",
              reportUnknownParameterType = "none",
              reportUnknownArgumentType = "none",
              reportImplicitOverride = "none",
              reportUnannotatedClassAttribute = "none",
              reportMissingTypeArgument = "none",
            },
          },
        },
      },
    },
  },
  {
    name = "tombi", -- toml lsp/linter/formatter
    config = {},
  },
  {
    tools = {
      mason = { "ruff", "markdownlint", "prettierd", "xmlformatter" },
      formatters = {
        by_ft = {
          python = { "ruff_fix", "ruff_format" },
          markdown = { "markdownlint" },
          yaml = { "prettierd" },
          json = { "prettierd" },
          html = { "prettierd" },
          xml = { "xmlformatter" },
        },
      },
      linters = {
        by_ft = {
          python = { "ruff" },
          markdown = { "markdownlint" },
        },
      },
    },
  },
})

dofile(vim.fs.joinpath(base_dir, "init.lua"))
