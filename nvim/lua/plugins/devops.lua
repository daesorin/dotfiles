return {
  -- 1. KULALA (Better Postman/Curl)
  -- Run APIs directly from .http files.
  -- Usage: Create `test.http`, type `GET http://google.com`, press space+R
  {
    "mistweaverco/kulala.nvim",
    opts = {},
  },

  -- 2. DIFFVIEW (Git Merge/Diff Tool)
  -- A powerful UI for viewing git diffs and merge conflicts.
  -- Usage: :DiffviewOpen
  {
    "sindrets/diffview.nvim",
  },

  -- 3. HARPOON (Fast Navigation)
  -- Mark frequent files (like a config and a deploy script) and jump between them.
  -- Usage: <leader>a to mark, <C-e> to view menu
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>a",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Harpoon File",
      },
      {
        "<C-e>",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Harpoon Menu",
      },
      {
        "<C-h>",
        function()
          require("harpoon.ui").nav_file(1)
        end,
        desc = "Harpoon File 1",
      },
      {
        "<C-j>",
        function()
          require("harpoon.ui").nav_file(2)
        end,
        desc = "Harpoon File 2",
      },
      {
        "<C-k>",
        function()
          require("harpoon.ui").nav_file(3)
        end,
        desc = "Harpoon File 3",
      },
    },
  },

  -- 4. NVIM-DEV-CONTAINER (Docker Dev Envs)
  -- If you use VS Code Remote Containers, this allows Nvim to attach to them.
  {
    "https://codeberg.org/esensar/nvim-dev-container",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("devcontainer").setup({})
    end,
  },
}
