vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Up window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Right window" })

-- Quick project docs
vim.keymap.set("n", "<leader>va", "<cmd>edit AGENTS.md<cr>", { desc = "Open AGENTS.md" })

vim.keymap.set("n", "<leader>vs", function()
  local cwd = vim.fn.isdirectory("docs/specs") == 1 and "docs/specs" or "."
  require("telescope.builtin").find_files({ cwd = cwd })
end, { desc = "Find specs" })

vim.keymap.set("n", "<leader>vd", function()
  local cwd = vim.fn.isdirectory("docs/adrs") == 1 and "docs/adrs" or "."
  require("telescope.builtin").find_files({ cwd = cwd })
end, { desc = "Find ADRs" })

-- Terminal
vim.keymap.set("n", "<leader>tt", "<cmd>botright 15split | terminal<cr>", { desc = "Terminal split" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Convenience
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })
