do
  local util = vim.lsp.util
  local original = util.open_floating_preview

  local function normalize_hover(lines)
    local text = table.concat(lines, "\n")

    text = text:gsub("<code>%s*(.-)%s*</code>", function(code)
      -- Convert Markdown links to their display text.
      -- [From](https://...) -> From
      code = code:gsub("%[([^%]]+)%]%([^%)]+%)", "%1")

      -- Decode HTML entities.
      code = code
        :gsub("&lt;", "<")
        :gsub("&gt;", ">")
        :gsub("&quot;", '"')
        :gsub("&amp;", "&")

      -- Remove Markdown escaping.
      code = code:gsub("\\([<>])", "%1")

      -- Collapse multiline code into a single line.
      code = code:gsub("%s+", " ")
      code = vim.trim(code)

      -- Use enough backticks to avoid delimiter conflicts.
      local count = 1
      for run in code:gmatch("`+") do
        count = math.max(count, #run + 1)
      end

      local ticks = string.rep("`", count)

      if code:find("`", 1, true) then
        return ticks .. " " .. code .. " " .. ticks
      end

      return ticks .. code .. ticks
    end)

    return vim.split(text, "\n", { plain = true })
  end

  util.open_floating_preview = function(lines, syntax, opts, ...)
    if syntax == "markdown"
        and opts
        and opts.focus_id == "textDocument/hover" then
      lines = normalize_hover(lines)
    end

    return original(lines, syntax, opts, ...)
  end
end
