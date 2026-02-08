-- Comment.nvim: コメントのトグル・追加を簡単に
-- デフォルト: gcc(行), gc(オペレータ), gbc(ブロック)
-- 追加: aa でコメント切り替え

return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local comment = require("Comment")
    comment.setup({
      padding = true,
      sticky = true,
      ignore = nil,
      toggler = {
        line = "gcc",
        block = "gbc",
      },
      opleader = {
        line = "gc",
        block = "gb",
      },
      extra = {
        above = "gcO",
        below = "gco",
        eol = "gcA",
      },
      mappings = {
        basic = true,
        extra = true,
      },
      pre_hook = nil,
      post_hook = nil,
    })

    -- aa でコメントトグル
    local api = require("Comment.api")
    vim.keymap.set("n", "aa", function() api.toggle.linewise.current() end, { desc = "Toggle line comment" })
    vim.keymap.set("v", "aa", function() api.toggle.linewise(vim.fn.visualmode()) end, { desc = "Toggle line comment" })
  end,
}
