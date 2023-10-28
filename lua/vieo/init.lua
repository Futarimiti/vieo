local M = {}

M.setup = function (raw)
  local c = require 'vieo.config'
  local fs = require 'vieo.fs'
  local au = require 'vieo.autocmd'
  local cmd = require 'vieo.command'

  local conf = c.validate(raw)

  fs.setup_views_dirs(conf)
  au.setup_autocmds(conf)
  cmd.setup_commands(conf)
end

return M
