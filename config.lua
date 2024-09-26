-- KEYMAPPING
lvim.leader = "space"
lvim.keys.insert_mode["kj"] = "<ESC>"
lvim.keys.normal_mode["<C-w>"] = ":w<cr>"
lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
lvim.keys.normal_mode["<S-l>"] = ":bnext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":bprevious<CR>"
lvim.keys.visual_mode["kj"] = "<ESC>"
lvim.keys.visual_mode["K"] = ":move \'<-2<CR>gv-gv"
lvim.keys.visual_mode["J"] = ":move \'>+1<CR>gv-gv"
lvim.builtin.which_key.setup.plugins.presets.z = true

lvim.builtin.nvimtree.setup.renderer.indent_markers.enable = true
lvim.builtin.indentlines.active = false

-- APPARENCE
lvim.transparent_window = true

-- lvim.colorscheme = "darcula-solid"
-- lvim.colorscheme = "darkplus"
lvim.colorscheme = "no-clown-fiesta"
-- lvim.colorscheme = "mellifluous"
-- lvim.colorscheme = "everforest"
-- vim.g.everforest_background = "hard"
-- vim.g.everforest_transparent_background = 1
-- vim.g.everforest_spell_foreground = 'colored'
-- vim.g.everforest_diagnostic_text_highlight = 1

-- require("no-clown-fiesta").setup({
--   transparent = true, -- Enable this to disable the bg color
--   styles = {
--     -- You can set any of the style values specified for `:h nvim_set_hl`
--     comments = {},
--     keywords = {},
--     functions = {},
--     variables = {},
--     type = { bold = true },
--     lsp = { underline = true }
--   },
-- })

-- OPTIONS
vim.opt.spelllang = 'pt'
vim.opt.relativenumber = false 
vim.opt.clipboard = 'unnamedplus'
vim.opt.textwidth = 100
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- default is ""
vim.opt.foldmethod = "expr"                     -- default is "normal"
vim.opt.foldenable = true
vim.opt.conceallevel = 2
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

-- PLUGINS
lvim.plugins = {
  -- Manage virtual envs [conda]
  "AckslD/swenv.nvim",
  "stevearc/dressing.nvim",

  -- Color
  "doums/darcula",
  "aktersnurra/no-clown-fiesta.nvim",
  "sainnhe/everforest",
  "whatyouhide/vim-gotham",
  "LunarVim/darkplus.nvim",
  "rebelot/kanagawa.nvim",
  { "briones-gabriel/darcula-solid.nvim", dependencies = "rktjmp/lush.nvim" },
  {
    --https://github.com/ramojus/mellifluous.nvim
    'ramojus/mellifluous.nvim',
    config = function()
      require 'mellifluous'.setup({
        color_set = "mountain" -- aulduin - mountain
      })                       -- optional, see configuration section.
    end
  },

  -- Debuging
  "mfussenegger/nvim-dap-python",
  "nvim-neotest/neotest",
  "nvim-neotest/neotest-python",

  --Markdown
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  "preservim/vim-pencil",
  "godlygeek/tabular",
  "preservim/vim-markdown",

  --Python Interpreter
  "geg2102/nvim-python-repl",

  -- Jupyter Notebook
  "meatballs/notebook.nvim",
  {
    "dccsillag/magma-nvim",
    build = ':UpdateRemotePlugins',
  },

  --Pretty Fold
  {
    'anuvyklack/pretty-fold.nvim',
    config = function()
      require('pretty-fold').setup()
    end
  },

  {
    'anuvyklack/fold-preview.nvim',
    dependencies = 'anuvyklack/keymap-amend.nvim',
    config = function()
      require('fold-preview').setup({
        -- auto = 400,
        default_keybinding = true,
        border = "rounded"
      })
    end
  }

}

--VimMarkdown
vim.g.vim_markdown_folding_disabled = 0
vim.g.vim_markdown_folding_style_pythonic = 1
vim.g.vim_markdown_fenced_languages = { "python=py" }
vim.g.vim_markdown_conceal_code_blocks = 0


-- Lualine
local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_y = {
  components.location
}

-- Configuração do LuaLine para usar com o thema "mellifluous"
-- Caso use outro thema comente esta configuração
-- local colors = {
--   bg = "#0c1014",
--   fg = "#E1E1E1",
-- }

-- lvim.builtin.lualine.options.theme = {
--   normal = {
--     a = { fg = colors.fg, bg = colors.bg, gui = "bold" },
--     b = { fg = colors.fg, bg = colors.bg },
--     c = { fg = colors.fg, bg = colors.bg },
--   },
--   insert = { a = { fg = colors.fg, bg = colors.bg, gui = "bold" } },
--   visual = { a = { fg = colors.fg, bg = colors.bg, gui = "bold" } },
--   command = { a = { fg = colors.fg, bg = colors.bg, gui = "bold" } },
--   replace = { a = { fg = colors.fg, bg = colors.bg, gui = "bold" } },
--   inactive = {
--     a = { fg = colors.fg, bg = colors.bg },
--     b = { fg = colors.fg, bg = colors.bg },
--     c = { fg = colors.fg, bg = colors.bg },
--   },
-- }

-- PYTHON
lvim.builtin.treesitter.ensure_installed = {
  "python",
}

-- Virtual Envs
lvim.builtin.which_key.mappings["V"] = {
  nome = "Python",
  e = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Escolha Env" },
}

-- Formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black" },
  {
    name = "isort",
    args = {
      "--multi-line",
      "3",
      "--trailing-comma",
      "--use-parentheses",
      "--force-grid-wrap",
      "0",
      "--line-length",
      "90",
      "--ensure-newline-before-comments",
    }
  },
  {
    name = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespace
    -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
    args = {
      "--print-width",
      "100",
      "--prose-wrap",
      "always",
    },
    ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
    filetypes = { "typescript", "typescriptreact", "markdown" },
  },
}

-- Format on save
lvim.format_on_save.enabled = false
lvim.format_on_save.pattern = { "*.py" }

-- Linting
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup { {
--   command = "flake8",
--   args = {
--     "--ignore=E203",
--     "--max-line-length",
--     "90",
--   },
--   filetypes = { "python" }
-- } }

-- Debuging
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = {
        justMyCode = false,
        console = "integratedTerminal",
      },
      args = { "--log-level", "DEBUG", "--quiet" },
      runner = "pytest",
    })
  }
})
lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>",
  "Test Method" }
lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
lvim.builtin.which_key.mappings["dF"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" }
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }

-- PYTHON ENVS
require('swenv').setup({
  post_set_env = function()
    vim.cmd("LspRestart")
  end
})

lvim.builtin.which_key.mappings["V"] = { "<cmd> lua require('swenv.api').pick_venv()<cr>", "Switch Env" }

-- IPYTHON
require("nvim-python-repl").setup({})

lvim.builtin.which_key.mappings["i"] = {
  name = "Ipython",
  r = { "<cmd>lua require('nvim-python-repl').send_statement_definition()<cr>", "Send semantic unit to REPL" },
  v = { "<cmd>lua require('nvim-python-repl').send_visual_to_repl()<cr>", "Send visual selection to REPL" },
  b = { "<cmd>lua require('nvim-python-repl').send_buffer_to_repl()<cr>", "Send entire buffer to REPL" },
  e = { "<cmd>lua require('nvim-python-repl').toggle_execute()<cr>", "Automatically execute command in REPL after sent" },
  l = { "<cmd>lua require('nvim-python-repl').toggle_vertical()<cr>", "Create REPL in vertical or horizontal split" },
}
