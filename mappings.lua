---@type MappingsTable
local M = {}


local function move_or_create_win(key)
  local fn = vim.fn
  local curr_win = fn.winnr()
  vim.cmd("wincmd " .. key)        --> attempt to move

  if (curr_win == fn.winnr()) then --> didn't move, so create a split
    if key == "h" or key == "l" then
      vim.cmd("wincmd v")
    else
      vim.cmd("wincmd s")
    end

    vim.cmd("wincmd " .. key)
  end
end


local function CloseAllExceptCurrent()
	local current_buf = vim.api.nvim_get_current_buf()
	local all_bufs = vim.api.nvim_list_bufs()

	for _, buf in ipairs(all_bufs) do
		if buf ~= current_buf then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end


local bar_run = require("custom.configs.bar_run")


local function Numbers()
  local regex1 = "call search('\\v\\d([^0-9\\.1]|$)', 'cW')"
  vim.cmd(regex1)
  vim.cmd("normal! v")
  local regex2 = "call search('\\v(^|[^0-9\\.]\\d)', 'becW')"
  vim.cmd(regex2)
end


-- keymaps
M.disabled = {
--   t = {
--     -- toggle in terminal mode
--     ["<A-i>"] = "",
--     ["<A-h>"] = "",
--     ["<A-v>"] = "",
--   },
--
--   n = {
--     -- toggle in normal mode
--     ["<A-i>"] = "",
    -- ["<A-h>"] = "",
--     ["<A-v>"] = "",
--
--     -- new
--     ["<leader>h"] = "",
--     ["<leader>v"] = "",
--   },
  n = {
    ["<C-n>"] = "",
    ["<leader>e"] = "",
    -- [";"] = "",
    ["<leader>ff"] = "",
    ["<leader>/"] = "",
    ["<A-i>"] = "",

    -- Splits
    ["<C-h>"] = "",
    ["<C-l>"] = "",
    ["<C-k>"] = "",
    ["<C-j>"] = "",

    ["yip"] = "",

    -- ["<tab>"] = "",
    -- ["<s-tab>"] = "",
  },

  v = {
    ["<leader>/"] = "",
    ["j"] = "",
  },

  t = {
    ["<A-i>"] = "",
  },
}

M.general = {
  n = {
    -- add file to harpoon
    ["<Leader>x"] = {
      function ()
        require("harpoon.ui").toggle_quick_menu()
        vim.cmd("%g/" + vim.fn.expand("%") + "/d")
        require("harpoon.ui").toggle_quick_menu()
        vim.cmd("bd")
      end,
      "Close current buffer",
    },

    -- switch buffers

    ["<tab>"] = { "<cmd>bn<cr>", "Buffer next" },
    ["<s-tab>"] = { "<cmd>bp<cr>", "Buffer previous" },





    -- [";"] = { ":", "enter command mode", opts = { nowait = true } },
    -- ["K"] = { "6k", "move up more" },
    -- ["J"] = { "6j", "move down more" },
    ["H"] = { "b", "move left more" },
    ["L"] = { "w", "move right more" },
    ["K"] = { "3k", "move up more" },
    ["J"] = { "3j", "move down more" },

    ["∆"] = { "3jzz", "move down more and center" },
    ["˚"] = { "3kzz", "move down more and center" },

    -- Probably dumb mappings but this is my config so what the hell
    ["w"] = { ":w<CR>", "Quick save" },
    ["Q"] = { ":q<CR>", "Quick quit" },

    --
    ["<leader>w"] = { "<cmd>w<CR>", "Save all"},
    ["<leader>q"] = { "<cmd>q<CR>", "Quick quit"},
    ["<leader>Q"] = { "<cmd>q!<CR>", "Quick force quit" },
    ["<leader>a"] = { "<cmd>qa<CR>", "Quick quit all"},
    ["<leader>A"] = { "<cmd>qa!<CR>", "Quick force quit all"},

    -- Splits
    ["<leader>h"] = { "<cmd>split<CR>", "Horizontal split"},
    ["<leader>v"] = { "<cmd>vsplit<CR>", "Vertical split"},
    ["<C-h>"] = {
      function()
        move_or_create_win("h")
      end,
      "Move or create left split"
    },
    ["<C-l>"] = {
      function()
        move_or_create_win("l")
      end,
      "Move or create right split"
    },
    ["<C-k>"] = {
      function()
        move_or_create_win("k")
      end,
      "Move or create top split"
    },
    ["<C-j>"] = {
      function()
        move_or_create_win("j")
      end,
      "Move or create bottom split"
    },

    ["s"] = { "/", "Search" },
    ["n"] = { "nzz", "Next result"},
    ["<C-.>"] = { "@@", "Repeat last macro" },

    ["<leader>lt"] = { "<cmd>TailwindColorsToggle<CR> ", "Toggle tailwind color lsp" },

    ["<C-s>"] = { "ggVG", "Select all" },

    ["r<S-Space>"] = { "r_", "Underscore shortcut in single character replace" },
    ["r<C-p>"] = { "vp", "Underscore shortcut in single character replace" },

    ["U"] = { "<C-r>", "Redo" },
    -- ["dif"] = { "v$o:'<,'>s/\v(.*\\().*\\)/\1)/", "Delete in function" },
    -- ["daf"] = { "", "Delete all of function" },
    --
    ["<C-n>"] = { ":e ", "New File" },

    ["<leader>cx"] = {
      function()
        CloseAllExceptCurrent()
      end,
      "Close all buffers except current"
    },

    -- TreeSJ
    ["E"] = { "<cmd>TSJToggle<CR>", "Toggle block collapse" },

    -- Faster indent (just use visual mode for more complex ones, saves keypresses in the long run)
    [">"] = { ">>", "Indent" },
    ["<"] = { "<<", "Unindent" },
  },
  v = {
    -- ["K"] = { "6k", "move up more" },
    -- ["J"] = { "6j", "move down more" },
    ["K"] = { "3k", "move up more" },
    ["J"] = { "3j", "move down more" },
    ["H"] = { "3b", "move left more" },
    ["L"] = { "3w", "move right more" },

    ["<tab>"] = { ">", "Indent" },
    ["<s-tab>"] = { "<", "Indent" },

    ["s"] = { "/", "Search" },

  },
  i = {
    -- Can't type capital J in insert
    -- ["JK"] = { "<esc>", "Escape with capslock" },
    -- ["JJ"] = { "<esc>", "Escape with capslock" },

    ["<c-s>"] = {
      function()
        require("flash").jump()
      end,
      "Flash"
    },
    ["<C-Space>"] = { "-", "Type underscore" },
    ["<S-Space>"] = { "_", "Type dash" },

    ["<C-p>"] = { '<C-r>"', "Paste in insert mode" },
  },
  -- x = {
  --   ["jk"] = { "<CR>", "Enter in ex command" },
  -- },
  c = {
    ["jk"] = { "<CR>", "Execute command" },
  },
}

M.macros = {
  n = {
    ["<leader>,"] = { "qz", "Make macro" },
    [","] = { "@z", "Run macro" },
  },
}

M.objects = {
  n = {
    -- propterty object
    ["cip"] = { "0f:ct;: ", "Change in property" },
    ["cap"] = { "cc", "Change around property" },
    ["yip"] = { "0f:<right>yt;", "Yank in property" },
    ["yap"] = { "yy", "Yank around property" },
    ["dip"] = { "0f:<right>dt;", "Delete in property" },
    ["dap"] = { "dd", "Delete around property" },
    ["vip"] = { "0f:<right>vt;", "Delete in property" },
    ["vap"] = { "^v$", "Delete around property" },
  },

  o = {
    ["in"] = { "vin", "inner number" },
  },

  v = {
    ["in"] = {
      function()
        Numbers()
      end,
      "In object",
    },
  },
}

M.commands = {
  n = {
    ['<leader>yg'] = { ":%g/\\v", 'Global' },
    ['B'] = { ":%g/\\v", 'Global' },
    ['<leader>yv'] = { ":%v/\\v", 'Converse' },
    ['<leader>ys'] = { ":%s/\\v", 'Substitute' },
    ['b'] = { ":%s/\\v", 'Substitute' },
    ['<leader>yw'] = { ":%s/<c-r><c-w>//g<left><left>", 'Substitute word under cursor' },

    ['<leader>ya'] = { ":arg ", 'View and edit arglist' },
    ['<leader>yG'] = { ":argdo %g/", 'Arglist global' },
    ['<leader>yV'] = { ":argdo %v/", 'Arglist Converse' },
    ['<leader>yS'] = { ":argdo %s/", 'Arglist Substitute' },

    ['<leader>ycg'] = { ":cdo g/", 'Quickfix global' },
    ['<leader>ycv'] = { ":cdo v/", 'Quickfix Converse' },
    ['<leader>ycs'] = { ":cdo s/", 'Quickfix Substitute' },
  },
  v = {
    ['<leader>yg'] = { ":g/\\v", 'Global' },
    ['B'] = { ":g/\\v", 'Global' },
    ['<leader>yv'] = { ":v/\\v", 'Converse' },
    ['b'] = { ":s/\\v", 'Substitute' },
    ['<leader>yw'] = { ":%s/'<,'>/", 'Substitute word under cursor' },
  },
}

M.run = {
  n = {
    ["<leader>rr"] = { "<Plug>SnipRun", "Run line" },
    ["<leader>rc"] = { "<Plug>SnipClose", "Clear virtual text" },
    ["<leader>rx"] = { "<Plug>SnipReset", "Reset SnipRun" },
    -- ["<leader>rm"] = { "!make50 ", "Make and run in c" },
  },
  v = {
    ["<leader>r"] = { "<Plug>SnipRun", "Run block"},
  },
}

M.tmux = {
  n = {
    ["<leader>ts"] = { "<cmd>!tmux set status<CR><CR>", "Toggle statusbar"},
    ["<leader>dd"] = { "<cmd>!tmux detach<CR><CR>", "Detach"},
  },
}

M.neotree = {
  n = {
    ["e"] = { "<cmd>Neotree toggle<CR>", "Toggle Neotree" },
    -- ["<S-space>"] = { "<cmd>Neotree toggle<CR>", "Toggle Neotree" },
  },
}

M.telescope = {
  n = {
    ["<Space>"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>fT"] = { "<cmd>Telescope themes<CR>", "Find themes"},
    ["<leader>fc"] = { "<cmd>Telescope find_files search_dirs=~/.config/nvim/lua/custom/.<CR>", "Find config"},
    ["<leader>fW"] = { "<cmd>Telescope live_grep search_dirs=~<CR>", "BIG grep"},
    ["<leader>ft"] = { "<cmd>Telescope terms<CR>", "Find terms"},
    ["<leader>fd"] = { "<cmd>FileInDirectory<CR>", "Find directories"},
  },
}

M.resize = {
  n = {
    ["<C-e>"] = {"<cmd>WinResizerStartResize<CR>", "Resize windows"},
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "Toggle breakpoint" },
    ["<S-Left>"] = { "<cmd> DapToggleBreakpoint <CR>", "Toggle breakpoint" },
    ["<S-Right>"] = {
      function()
        require('dap').step_over()
      end,
      "Step over"
    },
    ["<S-Down>"] = {
      function()
        require('dap').step_into()
      end,
      "Step into"
    },
    ["<S-Up>"] = {
      function()
        require('dap').out()
      end,
      "Step out"
    },
    ["<leader>dl"] = {
      function()
        require('dap').run_last()
      end,
      "Run last"
    }
  },
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dp"] = {
      function()
        require('dap-python').test_method()
      end,
      "Debug python"
    }
  },
}

-- more keybinds!
M.nvterm = {
  plugin = true,

  t = {
    ["<Bar>"] = {
      function ()
        vim.cmd("b#")
        bar_run:runfile()
        vim.cmd("b#")
        vim.cmd("call feedkeys('i')")
      end,
      "Run file"
    },

    -- toggle in terminal mode
    ["ƒ"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
    },
    ["\\"] = {
      function()
        bar_run:toggle()
      end,
    },
    ["<esc>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
    },

    ["˙"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
    },

    ["√"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
    },
  },

  n = {
    -- ["<Bar>"] = { ':lua require("nvterm.terminal").toggle "float"<cr><up><cr>', "Open terminal and run last command" },
    ["<Bar>"] = {
      function ()
        bar_run:runfile()
        bar_run:toggle()
      end,
      "Run file",
    },

    -- toggle in normal mode
    ["ƒ"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
    },
    ["\\"] = {
      function()
        bar_run:toggle()
      end,
    },

    ["˙"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
    },

    ["√"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
    },

    -- new
    ["<leader>tf"] = {
      function()
        require("nvterm.terminal").new "float"
      end,
      "New floating term",
    },

    ["<leader>th"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "New horizontal term",
    },

    ["<leader>tv"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "New vertical term",
    },

  },
}

return M
