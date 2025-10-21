require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
  },
  sections = {
    lualine_a = {},
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {},
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})
