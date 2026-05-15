require 'configs.remaps'

require 'configs.diagnostics'
require 'configs.duckdb'
require 'configs.floaterminal'
require 'configs.firenvim'
require 'configs.lazy'
require 'configs.mtext'
require 'configs.opts'
require 'configs.utils'

require 'configs.navic'
require 'configs.treesitter'

-- require 'configs.c3'

require('configs.telescope').setup()

vim.g.have_nerd_font = true
vim.g.netrw_banner = 0

-- Trans() -- Lets try Catppuccin (wow so unique) with no Transparent bg
-- vim.cmd.colorscheme 'catppuccin-mocha'

--- 0.12 Experimental
-- require('vim._core.ui2').enable {
--   enable = true, -- Whether to enable or disable the UI.
--   msg = { -- Options related to the message module.
--     ---@type 'cmd'|'msg' Default message target, either in the
--     ---cmdline or in a separate ephemeral message window.
--     ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
--     ---or table mapping |ui-messages| kinds and triggers to a target.
--     targets = 'cmd',
--     cmd = { -- Options related to messages in the cmdline window.
--       height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
--     },
--     dialog = { -- Options related to dialog window.
--       height = 0.5, -- Maximum height.
--     },
--     msg = { -- Options related to msg window.
--       height = 0.5, -- Maximum height.
--       timeout = 4000, -- Time a message is visible in the message window.
--     },
--     pager = { -- Options related to message window.
--       height = 1, -- Maximum height.
--     },
--   },
-- }

-- TODO:
-- Left behind from legacy config: java (jdtls) config
