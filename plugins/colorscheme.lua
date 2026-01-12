return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                compile = false,
                undercurl = true,
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true },
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = false,
                dimInactive = false,
                colors = {
                    palette = {},
                    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
                },
                overrides = function(colors)
                    return {
                        -- Cursor/VSCode風の色に調整
                        Normal = { fg = "#d4d4d4", bg = "#1e1e1e" },
                        Comment = { fg = "#6a9955", italic = true }, -- 緑のコメント
                        String = { fg = "#ce9178" },                 -- オレンジの文字列
                        Number = { fg = "#b5cea8" },                 -- 薄い緑の数値
                        Function = { fg = "#dcdcaa" },               -- 黄色の関数
                        Variable = { fg = "#9cdcfe" },               -- 青の変数
                        Keyword = { fg = "#569cd6" },                -- 青のキーワード
                        Type = { fg = "#4ec9b0" },                   -- シアンの型
                        Constant = { fg = "#569cd6" },
                        Identifier = { fg = "#9cdcfe" },
                        Statement = { fg = "#569cd6", bold = true },
                        CursorLine = { bg = "#2d2d30" },
                        LineNr = { fg = "#858585" },
                        CursorLineNr = { fg = "#c6c6c6" },
                        Delimiter = { fg = "#ffffff" },
                        Punctuation = { fg = "#ffffff" },
                        ["@punctuation.delimiter"] = { fg = "#ffffff" },
                        ["@punctuation.bracket"] = { fg = "#ffffff" },
                        ["@punctuation.special"] = { fg = "#ffffff" },
                        ["@operator"] = { fg = "#ffffff" },
                    }
                end,
                theme = "wave",
            })
            vim.cmd.colorscheme "kanagawa"
        end,
    },
}
