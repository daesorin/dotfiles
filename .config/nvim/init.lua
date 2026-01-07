-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- =============================================================================
--  BLACK HOLE DELETE (Preserve Clipboard)
-- =============================================================================

-- 1. Map 'x' to always use the black hole register.
--    (Because you rarely want to "cut" a single character to your clipboard)
vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "Delete char without copying" })

-- 2. Leader + d = Delete to Void (Motion)
--    Example: <leader>dw deletes a word but keeps your clipboard clean.
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete motion to void" })

-- 3. Leader + dd = Delete Line to Void
--    Example: <leader>dd wipes the line and saves your clipboard.
vim.keymap.set("n", "<leader>dd", '"_dd', { desc = "Delete line to void" })

-- 4. Leader + D = Delete to end of line to Void
vim.keymap.set("n", "<leader>D", '"_D', { desc = "Delete to EOL to void" })
