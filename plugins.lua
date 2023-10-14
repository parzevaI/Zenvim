local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
  --
  -- {
  --   "ahmedkhalf/project.nvim",
  --   lazy = false,
  --   config = function()
  --     require("project_nvim").setup {
  --       sync_root_with_cwd = true,
  --       respect_buf_cwd = true,
  --       update_focused_file = {
  --         enable = true,
  --         update_root = true
  --       },
  --     }
  --     require('telescope').load_extension('projects')
  --   end,
  -- },
  -- {
  --   "uiiaoo/java-syntax.vim",
  --   ft = "java",
  -- },
  --
  -- {
  --   "mfussenegger/nvim-jdtls",
  --   ft = "java",
  -- },

  -- {
  --   'altermo/ultimate-autopair.nvim',
  --   event={'InsertEnter','CmdlineEnter'},
  --   branch='v0.6',
  --   opts={
  --   },

  -- {
  --   "axelvc/template-string.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require('template-string').setup({
  --       filetypes = { 'html', 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'python' }, -- filetypes where the plugin is active
  --       jsx_brackets = true, -- must add brackets to jsx attributes
  --       remove_template_string = false, -- remove backticks when there are no template string
  --       restore_quotes = {
  --         -- quotes used when "remove_template_string" option is enabled
  --         normal = [[']],
  --         jsx = [["]],
  --       },
  --     })
  --   end,
  -- },

  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   lazy = true,
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   config = function()
  --     require'nvim-treesitter.configs'.setup({
  --       textobjects = {
  --         select = {
  --           enable = true,
  --
  --           -- Automatically jump forward to textobj, similar to targets.vim
  --           lookahead = true,
  --
  --           keymaps = {
  --             -- You can use the capture groups defined in textobjects.scm
  --             ["af"] = "@function.outer",
  --             ["if"] = "@function.inner",
  --             ["ac"] = "@class.outer",
  --             -- You can optionally set descriptions to the mappings (used in the desc parameter of
  --             -- nvim_buf_set_keymap) which plugins like which-key display
  --             ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
  --             -- You can also use captures from other query groups like `locals.scm`
  --             ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
  --           },
  --           -- You can choose the select mode (default is charwise 'v')
  --           --
  --           -- Can also be a function which gets passed a table with the keys
  --           -- * query_string: eg '@function.inner'
  --           -- * method: eg 'v' or 'o'
  --           -- and should return the mode ('v', 'V', or '<c-v>') or a table
  --           -- mapping query_strings to modes.
  --           selection_modes = {
  --             ['@parameter.outer'] = 'v', -- charwise
  --             ['@function.outer'] = 'V', -- linewise
  --             ['@class.outer'] = '<c-v>', -- blockwise
  --           },
  --           -- If you set this to `true` (default is `false`) then any textobject is
  --           -- extended to include preceding or succeeding whitespace. Succeeding
  --           -- whitespace has priority in order to act similarly to eg the built-in
  --           -- `ap`.
  --           --
  --           -- Can also be a function which gets passed a table with the keys
  --           -- * query_string: eg '@function.inner'
  --           -- * selection_mode: eg 'v'
  --           -- and should return true of false
  --           include_surrounding_whitespace = true,
  --         },
  --       },
  --     })
  --   end,
  -- {
  --   "NvChad/nvterm",
  --   lazy = false
  -- },
  {
    "princejoogie/dir-telescope.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("dir-telescope").setup({
        -- these are the default options set
        hidden = true,
        no_ignore = false,
        show_preview = true,
      })
    end,
  },

  {
    'Wansmer/treesj',
    -- keys = { 'E' },
    event = "VeryLazy",
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup({
        use_default_keymaps = false,
      })
    end,
  },

  {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },

  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("core.utils").load_mappings("dap")
    end
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end,
  },


  -- {
  --   "themaxmarchuk/tailwindcss-colors.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("tailwindcss-colors").setup()
  --   end,
  -- },


  {
    "sustech-data/wildfire.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("wildfire").setup()
    end,
    opts = {
      surrounds = {
        { "(", ")" },
        { "{", "}" },
        { "<", ">" },
        { "[", "]" },
      },
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        node_decremental = "<BS>",
      },
    }
  },

  {
    "michaelb/sniprun",
    event = "VeryLazy",
    build = "sh ./install.sh",
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      -- { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  {
    "simeji/winresizer",
    event = "BufEnter",
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("plugins.configs.others").luasnip(opts)
          -- extend filetypes
          require("luasnip").filetype_extend("svelte", { "html" })
          -- require("luasnip").filetype_extend("svelte", { "javascript" })
          -- require("luasnip").filetype_extend("svelte", { "css" })
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "plugins.configs.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },



  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults 
        "vim",
        "lua",
        "python",
        "java",

        -- web dev 
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        -- "vue", "svelte",
        "svelte",

       -- low level
        "c",
        "zig"
      },
    },
  },

  {
    "sveltejs/language-tools",
    config = function()
      require('plugins.configs.lspconfig').svelte.setup()
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    opts = function()
      local global_commands = {
        child_or_open = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" or node:has_children() then
            if not node:is_expanded() then -- if unexpanded, expand
              state.commands.toggle_node(state)
            else -- if expanded and has children, select the next child
              require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
            end
          else -- if not a directory just open it
            state.commands.open(state)
          end
        end,
        parent_or_close = function(state)
          local node = state.tree:get_node()
          if (node.type == "directory" or node:has_children()) and node:is_expanded() then
            state.commands.toggle_node(state)
          else
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end
        end,
      }
      return {
        window = {
          width = 30,
          mappings = {
            -- ["O"] = "system_open",
            ["h"] = "parent_or_close",
            ["l"] = "child_or_open",
            -- ["/"] = "toggle-auto-expand-width",
            ["/"] = "",
            ["e"] = "",
            -- ["<space>"] = "fuzzy_finder",
            -- ["Y"] = "copy_selector",
          },
        },
        filesystem = {
          follow_current_file = {
            enabled = true,
          },
          hijack_netrw_behavior = "open_current",
          use_libuv_file_watcher = true,
          commands = global_commands,
        },
      }
    end,
  },

  -- {
  --   "karb94/neoscroll.nvim",
  --   event = "BufEnter",
  --   config = function()
  --     require("neoscroll").setup()
  --   end,
  -- },

  -- {
  --   "justinmk/vim-sneak",
  --   event = "BufEnter",
  -- },
  -- {
  --   "karb94/neoscroll.nvim",
  --   event = ""
  -- }

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  {
    "nvim-tree/nvim-tree.lua",
    enabled = false
  },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
