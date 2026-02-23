return {
  "robitx/gp.nvim",
  config = function()
    require("gp").setup({
      openai_api_key = os.getenv("OPENAI_API_KEY"),

      chat = {
        split = "vsplit",
      },

    })

    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }


map("n", "<leader>ai", "<cmd>GpChatNew vsplit<CR>", { silent = true, desc = "AI: New chat (vsplit)" })
map("n", "<leader>at", "<cmd>GpChatToggle<CR>",   { silent = true, desc = "AI: Toggle chat" })

map("x", "<leader>ac", ":'<,'>GpChatNew vsplit<CR>", { silent = true, desc = "AI: ChatNew (vsplit) w/ selection" })
map("x", "<leader>ap", ":'<,'>GpChatPaste<CR>",      { silent = true, desc = "AI: Paste selection to chat" })
map("x", "<leader>ar", ":'<,'>GpRewrite<CR>",        { silent = true, desc = "AI: Rewrite selection" })
map("x", "<leader>aa", ":'<,'>GpAppend<CR>",         { silent = true, desc = "AI: Append after selection" })
map("x", "<leader>aA", ":'<,'>GpPrepend<CR>",        { silent = true, desc = "AI: Prepend before selection" })


    vim.o.timeout = true
    vim.o.timeoutlen = 800
  end,
}
