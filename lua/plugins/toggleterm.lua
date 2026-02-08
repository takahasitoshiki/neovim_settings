return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = nil, -- <leader>t は keymaps.lua で設定するため nil
      insert_mappings = true,
      terminal_mappings = true,
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      close_on_exit = true,
      direction = "float", -- フローティングウィンドウで表示
      float_opts = {
        border = "rounded",
        winblend = 0,
        width = function()
          return math.ceil(vim.o.columns * 0.5)
        end,
        height = function()
          return math.ceil(vim.o.lines * 0.10)
        end,
      },
      -- ターミナル内で Esc を押すと閉じる
      -- ターミナルモードでは Esc はシェルに送られるため、Ctrl-\ Ctrl-N でノーマルに戻してから閉じる
      on_open = function(term)
        local bufnr = term.bufnr
        local winid = term.window
        -- ノーマルモードのとき Esc で閉じる
        vim.keymap.set("n", "<Esc>", "<cmd>ToggleTerm<CR>", { buffer = bufnr, desc = "Close terminal" })
        -- ターミナルモードのとき Esc でノーマルに戻してから閉じる（1回の Esc で閉じる）
        vim.keymap.set("t", "<Esc>", "<C-\\><C-n><cmd>ToggleTerm<CR>", { buffer = bufnr, desc = "Close terminal" })
        -- 開いた直後にターミナルウィンドウにフォーカスし、入力可能な状態（ターミナルモード）に入る
        -- schedule を使わず即実行し、他プラグイン（例: ime.lua の FocusGained）より先に確実に入力モードへ
        if winid and vim.api.nvim_win_is_valid(winid) then
          vim.api.nvim_set_current_win(winid)
        end
        vim.cmd("startinsert!")
      end,
    })
  end,
}
