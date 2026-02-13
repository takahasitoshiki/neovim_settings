return {
  "dlyongemallo/diffview.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>dv",
      function()
        if next(require("diffview.lib").views) == nil then
          vim.cmd("DiffviewOpen")
        else
          vim.cmd("DiffviewClose")
        end
      end,
      desc = "Diffview 開く/閉じる",
    },
    { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "Diffview 開く（作業ツリー差分）" },
    { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Diffview 閉じる" },
    { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "ファイル履歴（現在のファイル）" },
    { "<leader>dH", "<cmd>DiffviewFileHistory<cr>", desc = "ファイル履歴（リポジトリ）" },
  },
  config = function()
    local actions = require("diffview.actions")

    require("diffview").setup({
      use_icons = true,
      view = {
        default = {
          layout = "diff2_horizontal",
        },
      },
      file_panel = {
        win_config = {
          position = "left",
          width = 35,
        },
      },
      keymaps = {
        -- <leader>e は NvimTree で使用中のため無効化し、代わりに <leader>df / <leader>db を使用
        view = {
          { "n", "<leader>e", false },
          { "n", "<leader>b", false },
          { "n", "<leader>df", actions.focus_files, { desc = "Diffview: ファイルパネルにフォーカス" } },
          { "n", "<leader>db", actions.toggle_files, { desc = "Diffview: ファイルパネル開閉" } },
        },
        file_panel = {
          { "n", "<leader>df", actions.focus_files, { desc = "Diffview: ファイルパネルにフォーカス" } },
          { "n", "<leader>db", actions.toggle_files, { desc = "Diffview: ファイルパネル開閉" } },
        },
      },
    })
  end,
}
