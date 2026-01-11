-- キーマップ設定
local keymap = vim.keymap

-- リーダーキー（各種操作の起点）をスペースに設定
vim.g.mapleader = " "

-- jk でインサートモードを抜ける
keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- スペース + nh で検索のハイライトを消す
keymap.set("n", "<leader>nh", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- 画面分割
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })

-- タブ操作
keymap.set("n", "te", ":tabedit", { desc = "新しいタブを開く" }) -- tab edit
keymap.set("n", "gn", ":tabnext<Return>", { desc = "次のタブへ" }) -- go next
keymap.set("n", "gp", ":tabprev<Return>", { desc = "前のタブへ" }) -- go previous
keymap.set("n", "tx", ":tabclose<Return>", { desc = "タブを閉じる" }) -- tab closie

-- nvim-tree
-- スペース + e でツリーを開閉する (e は Explorer の e)
keymap.set("n", "<leader>e", ":NvimTreeToggle<Return>", { desc = "Toggle file explorer" })

-- 全選択 (Command + a)
keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Command + a を全選択にする設定（環境によって動作しない場合があります）
keymap.set("n", "<D-a>", "ggVG", { desc = "Select all" })
keymap.set("v", "<D-a>", "<Esc>ggVG", { desc = "Select all" })
keymap.set("i", "<D-a>", "<Esc>ggVG", { desc = "Select all" })

-- スペース + ya で全コピー
keymap.set("n", "<leader>ya", ":%y<CR>", { desc = "Copy all" })

-- インサートモード中に Command + z (または Ctrl + z) で元に戻す
-- MacのCommandキーを利用する場合
keymap.set("i", "<D-z>", "<Esc>ui", { desc = "Undo in insert mode" })
-- もしCommandが効かない場合は Ctrl + z も設定しておくと安心です
keymap.set("i", "<C-z>", "<Esc>ui", { desc = "Undo in insert mode" })

-- ノーマルモードの Command + z もついでに設定
keymap.set("n", "<D-z>", "u", { desc = "Undo" })

-- スペース + g で Lazygit を起動
keymap.set("n", "<leader>g", ":LazyGit<CR>", { desc = "Lazygitを起動 (Git操作)" })

-- スペース + p (Project) でプロジェクト一覧を表示
-- 選択するとそのディレクトリに移動(cd)してファイル検索が開きます
keymap.set('n', '<leader>p', function()
  require('telescope').load_extension('projects')
  require('telescope').extensions.projects.projects({})
end, { desc = "プロジェクトを切り替える" })

-- keymaps.lua に入っている設定
keymap.set("i", "<D-z>", "<Esc>ui", { desc = "挿入モードで元に戻す" })
keymap.set("i", "<C-z>", "<Esc>ui", { desc = "挿入モードで元に戻す" }) 

-- 背景を透かしてぼかす (キー入力: Space + tr)
vim.keymap.set('n', '<leader>tr', function()
  -- プロファイルを「Glass」に切り替える命令を送る
  vim.fn.system([[printf "\e]50;SetProfile=Glass\a"]])
  -- Neovim自体の背景（色）を消すプラグインを実行
  pcall(vim.cmd, "TransparentEnable")
  print("Glass Mode On")
end, { desc = "背景を透明化してぼかす" })

-- 背景を真っ黒に戻す (キー入力: Space + ts)
vim.keymap.set('n', '<leader>ts', function()
  -- プロファイルを「Default」に戻す命令を送る
  vim.fn.system([[printf "\e]50;SetProfile=Default\a"]])
  -- Neovim自体の背景（色）を元に戻す
  pcall(vim.cmd, "TransparentDisable")
  print("Glass Mode Off")
end, { desc = "背景を不透明に戻す" })
