return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      local finders = require('telescope.finders')
      local pickers = require('telescope.pickers')
      local sorters = require('telescope.sorters')
      local make_entry = require('telescope.make_entry')

      -- 現在のセッションで開いたファイルと過去の履歴を組み合わせる関数
      local function recent_files()
        local current_buffers = {}
        local all_files = {}
        local cwd = vim.fn.getcwd()
        local cwd_normalized = vim.fn.fnamemodify(cwd, ':p')
        
        -- ファイルが現在のディレクトリ配下にあるかチェックする関数
        local function is_in_cwd(file_path)
          local normalized_path = vim.fn.fnamemodify(file_path, ':p')
          return string.sub(normalized_path, 1, #cwd_normalized) == cwd_normalized
        end
        
        -- 現在開いているバッファを取得
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(buf) then
            local name = vim.api.nvim_buf_get_name(buf)
            if name ~= "" and vim.fn.filereadable(name) == 1 then
              local full_path = vim.fn.fnamemodify(name, ':p')
              if is_in_cwd(full_path) then
                current_buffers[full_path] = true
                table.insert(all_files, full_path)
              end
            end
          end
        end

        -- oldfilesから取得（現在のバッファにないもののみ、かつcwd配下のみ）
        for _, file in ipairs(vim.v.oldfiles) do
          if vim.fn.filereadable(file) == 1 then
            local full_path = vim.fn.fnamemodify(file, ':p')
            if is_in_cwd(full_path) and not current_buffers[full_path] then
              table.insert(all_files, full_path)
            end
          end
        end

        pickers.new({}, {
          prompt_title = "最近開いたファイル",
          finder = finders.new_table({
            results = all_files,
            entry_maker = make_entry.gen_from_file({}),
          }),
          sorter = sorters.get_generic_fuzzy_sorter(),
          previewer = require('telescope.previewers').vim_buffer_cat.new({}),
        }):find()
      end

      -- 1. 最近開いたファイルを優先して検索 (スペース + f)
      --    → MRU (Most Recently Used) リストからファイルを絞り込み
      vim.keymap.set('n', '<leader>f', function()
        builtin.oldfiles({ only_cwd = true })
      end, { desc = "最近開いたファイルから検索 (cwd)" })

      -- 2. 最近開いたファイルから検索 (スペースを2回)
      --    現在のセッションで開いたファイルも含めて表示
      vim.keymap.set('n', '<leader><leader>', recent_files, { desc = "最近開いたファイルから検索" })

      -- 3. 全ショートカット（Vim標準+LSP+自分で決めたもの）の表示
      vim.keymap.set('n', '<leader>?', builtin.keymaps, { desc = "Search all keymaps" })

      -- 4. 通常のファイル名検索も残したい場合 (スペース + F)
      vim.keymap.set('n', '<leader>F', builtin.find_files, { desc = "ファイル名検索 (全体)" })

      -- 元々あった設定も残す場合はこちら（不要なら消してOKです）
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    end
  }
}

