return {
  -- ChatGPT integration
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local chatgpt = require("chatgpt")
      chatgpt.setup({
        yank_register = '"',
        popup_input = {
          submit = "<C-s>",
        },
        openai_params = {
          model = "gpt-4-turbo-preview",
          max_tokens = 500,
        },
      })

      require("which-key").add({
        { "<leader>c",  group = "ChatGPT" },
        {
          "<leader>cc",
          ":ChatGPT<CR>",
          desc = "Toggle (ChatGPT)",
        },
        {
          "<leader>cs",
          ":ChatGPTActAs<CR>",
          desc = "ActAs (ChatGPT)",
        },
        {
          "<leader>ce",
          ":ChatGPTEditWithInstructions<CR>",
          desc = "Edit (ChatGPT)",
          mode = { "n", "v" },
        },
        { "<leader>ca", group = "Actions (ChatGPT)" },
        {
          "<leader>cac",
          ":ChatGPTRun complete_code<CR>",
          desc = "Complete code",
          mode = { "n", "v" },
        },
        {
          "<leader>cad",
          ":ChatGPTRun docstring<CR>",
          desc = "Docstring for func",
          mode = { "n", "v" },
        },
        {
          "<leader>cat",
          ":ChatGPTRun add_tests<CR>",
          desc = "Add tests",
          mode = { "n", "v" },
        },
        {
          "<leader>cab",
          ":ChatGPTRun fix_bugs<CR>",
          desc = "Fix bugs",
          mode = { "n", "v" },
        },
      })
    end,
  },
}
