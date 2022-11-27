local M = {}

function M.setup()
    require("bufferline").setup {
        options = {
            numbers = "none",
            diagnostics = "nvim_lsp",
            separator_style = "thin",
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center",
                },
            },

            show_tab_indicators = true,
            show_buffer_close_icons = false,
            show_close_icon = false,
        },
    }
end

return M
