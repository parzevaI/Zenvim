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
  --   "startup-nvim/startup.nvim",
  --   lazy = false,
  --   requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
  --   config = function()
  --     require"startup".setup(require"configs.startup_nvim")
  --   end
  -- },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "BufEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

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


  -- {
  --   "sustech-data/wildfire.nvim",
  --   event = "VeryLazy",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   config = function()
  --     require("wildfire").setup()
  --   end,
  --   opts = {
  --     surrounds = {
  --       { "(", ")" },
  --       { "{", "}" },
  --       { "<", ">" },
  --       { "[", "]" },
  --     },
  --     keymaps = {
  --       init_selection = "<CR>",
  --       node_incremental = "<CR>",
  --       node_decremental = "<BS>",
  --     },
  --   }
  -- },

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
      -- {
      --   "roobert/tailwindcss-colorizer-cmp.nvim",
      --   config = true,
      -- },
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
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
          node_decremental = '<c-backspace>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ao'] = '@class.outer',
            ['io'] = '@class.inner',
            ['ii'] = '@conditional.inner',
            ['ai'] = '@conditional.outer',
            ['il'] = '@loop.inner',
            ['al'] = '@loop.outer',
            ['ic'] = '@comment.inner',
            ['ac'] = '@comment.outer',
            ['iv'] = '@assignment.rhs',
            ['av'] = '@assignment.outer',
            ['ir'] = '@return.inner',
            ['ar'] = '@return.inner',
            ['in'] = '@number.inner',
            ['ah'] = '@call.outer',
            ['ih'] = '@call.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
          -- goto_next = {
          --   [']i'] = "@conditional.inner",
          -- },
          -- goto_previous = {
          --   ['[i'] = "@conditional.inner",
          -- }
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>h'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>H'] = '@parameter.inner',
          },
        },
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

  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
      }
    }
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

  -- {
  --   "nvchad/nvdash.lua",
  --   enabled = false
  -- },


  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
