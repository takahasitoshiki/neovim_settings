-- Svelte のシンタックスハイライト（treesitter が動かない場合のフォールバック）
return {
  "evanleck/vim-svelte",
  ft = "svelte",
  dependencies = {
    "pangloss/vim-javascript",  -- <script> 内の JS/TS ハイライト
    "othree/html5.vim",         -- テンプレート部分の HTML ハイライト
  },
}
