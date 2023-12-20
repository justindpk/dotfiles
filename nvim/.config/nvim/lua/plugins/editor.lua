return {
  { 'catppuccin/nvim' },
  { 'deviantfero/wpgtk.vim' },
  { 'ellisonleao/gruvbox.nvim' },
  { 'dylanaraps/wal.vim' },
  { 'fladson/vim-kitty' },
  {
    'numToStr/Comment.nvim', lazy = false, opts = {}
  },
  {
    'ggandor/leap.nvim',
    config = function()
      local leap = require('leap')
      leap.add_default_mappings()
    end
  },
  {
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    lazy = true,
    cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
    event = { 'User KittyScrollbackLaunch' },
    config = function()
      require('kitty-scrollback').setup()
    end,
  },
  {
    "luckasRanarison/tree-sitter-hypr",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.hypr = {
        install_info = {
          url = "https://github.com/luckasRanarison/tree-sitter-hypr",
          files = { "src/parser.c" },
          branch = "master",
        },
        filetype = "hypr",
      }
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        ensure_installed = { "hypr" },
        highlight = { enable = true },
      })
    end,
    build = ":TSUpdate"
  },
  {
    'catppuccin/nvim',
    as = 'catppuccin',
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        -- ... other configurations ...
        integrations = {
          -- ... integrations ...
        },
      })

      -- Activate the Catppuccin color scheme
      vim.cmd("colorscheme catppuccin")
    end
  }
}

