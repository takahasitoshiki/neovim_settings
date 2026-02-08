return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>g", "<cmd>LazyGit<cr>", desc = "LazyGitを開く" },
  },
  config = function()
    -- 特に詳細な設定がなくても動きます
  end,
}
