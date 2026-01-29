return {
    "monkoose/neocodeium",
    event = "InsertEnter",
    config = function()
        local neocodeium = require("neocodeium")
        neocodeium.setup()

        -- Tabキーの設定
        vim.keymap.set("i", "<Tab>", function()
            -- Codeiumの提案が表示されているか確認
            if neocodeium.visible() then
                return neocodeium.accept()
            else
                -- 提案がない場合は通常のTab（インデント等）として動作
                return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
            end
        end, { expr = true, replace_keycodes = false })
    end,
}
