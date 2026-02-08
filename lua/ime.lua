-- Neovimにフォーカスした時・Insertモードを抜けた時に半角（英数）に切り替える
-- macOS 専用（英数キー key code 102 をシミュレート）
-- ※ 動作しない場合: システム設定 > プライバシーとセキュリティ > アクセシビリティ で
--    ターミナル/Cursor を許可してください

local function switch_to_halfwidth()
  if vim.fn.has("mac") ~= 1 then
    return
  end
  -- ターミナルバッファでは実行しない（toggleterm のフォーカス・入力が乱れるのを防ぐ）
  if vim.bo.buftype == "terminal" then
    return
  end
  -- 非同期で実行（Neovimをブロックしない）
  vim.fn.jobstart({ "osascript", "-e", 'tell application "System Events" to key code 102' }, {
    detach = true,
  })
end

vim.api.nvim_create_augroup("ime_halfwidth", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained", "InsertLeave" }, {
  group = "ime_halfwidth",
  callback = switch_to_halfwidth,
})
