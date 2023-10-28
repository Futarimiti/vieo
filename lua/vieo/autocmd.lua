local M = {}

M.setup_autocmds = function (conf)
  local a = require 'vieo.actions'
  local autocmd = vim.api.nvim_create_autocmd
  local augroup = vim.api.nvim_create_augroup

  local group = augroup('vieo', {})

  autocmd('BufWinEnter', {
    group = group,
    callback = function (args)
      if not a.should_save(conf, args.buf) then return end
      pcall(a.restore_view, conf, args.buf)
    end,
  })

  autocmd({ 'BufUnload', 'BufWinLeave' }, {
    group = group,
    callback = function (args)
      if not a.should_save(conf, args.buf) then return end
      pcall(a.save_view, conf, args.buf)
    end,
  })

end

return M
