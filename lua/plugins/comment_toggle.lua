-- Neovim: Command+/ で行コメントアウト（// を先頭に追加/削除）
-- lazy.nvimのプラグイン設定として読み込まれる

local M = {}

-- 言語ごとのコメント文字（行コメント）
local comment_prefix = {
  ["typescript"] = "//",
  ["typescriptreact"] = "//",
  ["javascript"] = "//",
  ["javascriptreact"] = "//",
  ["ts"] = "//",
  ["js"] = "//",
  ["lua"] = "--",
  ["vim"] = "\"",
  ["python"] = "#",
  ["sh"] = "#",
  ["bash"] = "#",
  ["go"] = "//",
  ["rust"] = "//",
  ["c"] = "//",
  ["cpp"] = "//",
  ["csharp"] = "//",
  ["java"] = "//",
  ["kotlin"] = "//",
  ["ruby"] = "#",
  ["yaml"] = "#",
  ["json"] = "//", -- json は本来コメント不可だが、一部ツールでは // を無視する
}

local function get_comment_prefix()
  local ft = vim.bo.filetype
  return comment_prefix[ft] or "//"
end

local function is_blank(s)
  return s:match("^%s*$") ~= nil
end

-- 行がすでにコメントかどうか（先頭の空白の後に prefix があるか）
local function line_is_commented(line, prefix)
  local trimmed = line:match("^%s*(.*)$")
  return trimmed:sub(1, #prefix) == prefix
end

-- 行の「実質の先頭」（空白を除いた最初の位置）に prefix を挿入
local function add_comment(line, prefix)
  if is_blank(line) then
    return prefix .. " "
  end
  local indent = line:match("^(%s*)")
  local rest = line:match("^%s*(.*)$")
  if line_is_commented(rest, prefix) then
    return line
  end
  return indent .. prefix .. " " .. rest
end

-- 行からコメント prefix を削除（先頭の空白 + prefix + 空白1文字 を削除）
local function remove_comment(line, prefix)
  if is_blank(line) then
    return line
  end
  local rest = line:match("^%s*" .. vim.pesc(prefix) .. "%s?(.*)$")
  if rest ~= nil then
    local indent = line:match("^(%s*)")
    return indent .. rest
  end
  return line
end

function M.toggle_line()
  local prefix = get_comment_prefix()
  local line = vim.api.nvim_get_current_line()
  local new_line
  if line_is_commented(line:match("^%s*(.*)$") or "", prefix) then
    new_line = remove_comment(line, prefix)
  else
    new_line = add_comment(line, prefix)
  end
  vim.api.nvim_set_current_line(new_line)
end

function M.toggle_visual()
  local prefix = get_comment_prefix()
  local start_row = vim.fn.line("'<")
  local end_row = vim.fn.line("'>")
  local all_commented = true
  for row = start_row, end_row do
    local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""
    if not is_blank(line) and not line_is_commented(line:match("^%s*(.*)$") or "", prefix) then
      all_commented = false
      break
    end
  end
  for row = start_row, end_row do
    local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""
    local new_line
    if all_commented then
      new_line = remove_comment(line, prefix)
    else
      new_line = add_comment(line, prefix)
    end
    vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
  end
end

-- キーマップを登録（Command+/ と Ctrl+/）
local function setup()
  -- Command + / (GUI Neovim や一部ターミナル)
  vim.keymap.set("n", "<D-/>", M.toggle_line, { noremap = true, silent = true, desc = "Toggle line comment" })
  vim.keymap.set("v", "<D-/>", M.toggle_visual, { noremap = true, silent = true, desc = "Toggle visual comment" })

  -- Ctrl + / (ターミナルで Command が使えない場合)
  vim.keymap.set("n", "<C-/>", M.toggle_line, { noremap = true, silent = true, desc = "Toggle line comment" })
  vim.keymap.set("v", "<C-/>", M.toggle_visual, { noremap = true, silent = true, desc = "Toggle visual comment" })
end

-- lazy.nvimのプラグイン設定形式で返す
return {
  {
    name = "comment_toggle",
    config = function()
      setup()
    end,
  },
}

