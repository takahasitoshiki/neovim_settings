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

-- 前のファイル（ジャンプ）へ
keymap.set("n", "<A-Left>", "<C-o>", { noremap = true, silent = true })

-- 次のファイル（ジャンプ）へ
keymap.set("n", "<A-Right>", "<C-i>", { noremap = true, silent = true })

-- タブを開く → ⌘T
keymap.set("n", "<D-t>", ":tabedit<CR>", { desc = "新しいタブを開く" })

-- ⌘D → 定義ジャンプ
keymap.set("n", "<D-d>", function()
  vim.lsp.buf.definition({ reuse_win = true })
end, { desc = "Go to definition" })

-- gr → 参照箇所一覧を小窓(Telescope)で表示（VSCode の「参照の検索」に近い動き）
keymap.set("n", "gr", function()
  require("telescope.builtin").lsp_references({
    include_declaration = false,  -- 定義そのものはリストから除外
    show_line = true,
  })
end, { desc = "Show LSP references (Telescope)" })

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


-- ALT + n: 次のタブへ移動（WezTermのウィンドウ切り替えに対応）
keymap.set("n", "<A-n>", ":tabnext<CR>", { desc = "次のタブへ（WezTerm互換）" })

-- ALT + SHIFT + RightArrow: 垂直分割（左右分割）
keymap.set("n", "<A-S-Right>", "<C-w>v", { desc = "垂直分割（WezTerm互換）" })

-- ALT + SHIFT + DownArrow: 水平分割（上下分割）
keymap.set("n", "<A-S-Down>", "<C-w>s", { desc = "水平分割（WezTerm互換）" })

-- ALT + CMD + 矢印キー: ペイン間を移動
keymap.set("n", "<A-D-Left>", "<C-w>h", { desc = "左のペインへ移動（WezTerm互換）" })
keymap.set("n", "<A-D-Right>", "<C-w>l", { desc = "右のペインへ移動（WezTerm互換）" })
keymap.set("n", "<A-D-Up>", "<C-w>k", { desc = "上のペインへ移動（WezTerm互換）" })
keymap.set("n", "<A-D-Down>", "<C-w>j", { desc = "下のペインへ移動（WezTerm互換）" })

-- ALT + x: 現在のペインを閉じる
keymap.set("n", "<A-x>", "<C-w>c", { desc = "ペインを閉じる（WezTerm互換）" })

-- Option + Shift + F でコード整形
keymap.set({"n", "v", "i"}, "<M-S-f>", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format code" })

-- エンター2回で検索プロンプトを表示（検索文字列が見やすく表示される）
local enter_timer = nil

keymap.set("n", "<CR>", function()
  if enter_timer then
    -- 2回目のエンター：検索プロンプトを表示
    vim.fn.timer_stop(enter_timer)
    enter_timer = nil
    
    -- ノーマルモードに確実に戻す
    if vim.fn.mode() ~= "n" then
      vim.cmd("normal! <Esc>")
    end
    
    -- 検索ハイライトを有効にする
    vim.opt.hlsearch = true
    
    -- 検索プロンプトを表示（コマンドラインで検索を開始）
    -- feedkeysを使うことで、検索プロンプトが正しく表示される
    vim.schedule(function()
      vim.fn.feedkeys("/", "t")
    end)
  else
    -- 1回目のエンター：タイマーを開始
    enter_timer = vim.fn.timer_start(500, function()
      -- タイマーが切れたら通常のエンター動作
      enter_timer = nil
      -- ノーマルモードで通常のエンター動作を実行
      vim.schedule(function()
        vim.cmd("normal! <CR>")
      end)
    end)
  end
end, { noremap = true, desc = "Enter twice to search" })
