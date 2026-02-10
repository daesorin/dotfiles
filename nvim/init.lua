require("config.lazy")

vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "Delete char without copying" })

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete motion to void" })

vim.keymap.set("n", "<leader>dd", '"_dd', { desc = "Delete line to void" })

vim.keymap.set("n", "<leader>D", '"_D', { desc = "Delete to EOL to void" })
