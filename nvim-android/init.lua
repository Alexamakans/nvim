local base_dir = vim.fs.normalize(vim.fs.joinpath(vim.fn.stdpath("config"), "..", "nvim"))

vim.opt.runtimepath:prepend(base_dir)

local lsps = require("shared.lsps")
local treesitters = require("shared.treesitters")

vim.list_extend(treesitters, {
  "java",
  "kotlin",
  "xml",
  "groovy",
  "toml",
})

vim.list_extend(lsps, {
  {
    name = "lua_ls",
    config = {},
  },
  {
    name = "jdtls",
    config = {},
  },
  {
    name = "kotlin_lsp",
    config = {},
  },
  {
    name = "gradle_ls",
    config = {},
  },
  {
    name = "lemminx",
    config = {},
  },
  {
    name = "tombi",
    config = {},
  },
  {
    tools = {
      mason = {
        "google-java-format",
        "ktlint",
        "xmlformatter",
      },

      formatters = {
        by_ft = {
          java = { "google-java-format-aosp" },
          kotlin = { "ktlint-android" },
          xml = { "xmlformatter" },
          toml = { "tombi" },
        },
      },

      linters = {
        by_ft = {
          kotlin = { "ktlint" },
          toml = { "tombi" },
        },
      },
    },
  },
})

dofile(vim.fs.joinpath(base_dir, "init.lua"))

-- google-java-format defaults to two spaces. The --aosp variant uses four.
local conform = require("conform")

conform.formatters["google-java-format-aosp"] = {
  inherit = "google-java-format",
  prepend_args = { "--aosp" },
}

-- Conform's built-in ktlint formatter uses stdin without supplying the actual
-- filename. Supplying it allows ktlint to resolve the correct .editorconfig
-- sections for *.kt and *.kts.
conform.formatters["ktlint-android"] = {
  inherit = "ktlint",
  args = {
    "--format",
    "--stdin",
    "--stdin-path",
    "$FILENAME",
    "--log-level=none",
  },
}

-- Apply the overrides explicitly in case init.lua already initialized Conform.
conform.formatters_by_ft.java = { "google-java-format-aosp" }
conform.formatters_by_ft.kotlin = { "ktlint-android" }

-- Make nvim-lint's ktlint invocation resolve the same .editorconfig file and
-- filename-specific section as the formatter.
local lint = require("lint")

lint.linters.ktlint.args = {
  "--reporter=json",
  "--stdin",
  "--stdin-path",
  function()
    return vim.api.nvim_buf_get_name(0)
  end,
}
