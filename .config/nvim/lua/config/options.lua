vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4

--keeps dir that changed in nvim
vim.g.netrw_keepdir = 0

--use system clipboard
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.opt.scrolloff = 20

--hightight on paste
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
