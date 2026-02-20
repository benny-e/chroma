return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
		"pyright",
		"lua_ls",
		"bashls",
		"cssls",
		"jsonls",
		"clangd",
		"yamlls",
		"taplo",
		"marksman",
	    },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      end,
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = { diagnostics = { globals = { "vim" } } },
      },
    })

    vim.lsp.enable({
	    "pyright",
	    "lua_ls",
	    "bashls",
	    "cssls",
	    "jsonls",
	    "clangd",
	    "yamlls",
	    "taplo",
	    "marksman",
	})

    vim.diagnostic.config({
    virtual_text = {
    prefix = "●",
    spacing = 2,
  },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

  end,
}

