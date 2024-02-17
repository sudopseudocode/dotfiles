return {
  -- Dependency with build steps
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-live-grep-raw.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "folke/trouble.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local telescope_builtin = require("telescope.builtin")
      -- We cache the results of "git rev-parse"
      -- Process creation is expensive in Windows, so this reduces latency
      local is_inside_work_tree = {}

      local project_files = function()
        local cwd = vim.fn.getcwd()
        if is_inside_work_tree[cwd] == nil then
          vim.fn.system("git rev-parse --is-inside-work-tree")
          is_inside_work_tree[cwd] = vim.v.shell_error == 0
        end

        if is_inside_work_tree[cwd] then
          telescope_builtin.git_files()
        else
          telescope_builtin.find_files()
        end
      end

      require("which-key").register({
        ["<leader>f"] = {
          name = "Telescope",
          f = { project_files, "Find files (Telescope)" },
          g = {
            ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
            "Grep files (Telescope)",
          },
          b = {
            ":Telescope buffers<CR>",
            "Find buffer (Telescope)",
          },
          h = {
            ":Telescope oldfiles<CR>",
            "Find old files (Telescope)",
          },
        },
      })

      local actions = require("telescope.actions")
      local trouble = require("trouble.providers.telescope")

      telescope.setup({
        extensions = {
          fzf = {
            fuzzy = true,                               -- false will only do exact matching
            override_generic_sorter = true,             -- override the generic sorter
            override_file_sorter = true,                -- override the file sorter
          },
        },
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim",
            "--hidden",
            "--glob=!.git",
          },
          mappings = {
            i = {
              -- ["<esc>"] = actions.close,
              ["<C-c>"] = actions.close,
              ["<C-x>"] = trouble.open_with_trouble,
            },
            n = {
              ["<C-c>"] = actions.close,
              ["<C-x>"] = trouble.open_with_trouble,
            },
          },
        },
      })

      -- Load the fzf extension after setup
      telescope.load_extension("fzf")
    end,
  },
}
