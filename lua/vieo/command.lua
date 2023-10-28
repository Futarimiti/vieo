local M = {}

local user_cmd = vim.api.nvim_create_user_command

M.setup_commands = function (conf)
  user_cmd('ClearViews', function ()
    require('vieo.actions').clear_views(conf)
  end, {})
end

return M
