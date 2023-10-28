local M = {}

M.notify_clear = function ()
  vim.notify '[vieo] cleared views directory'
end

M.unsuccessful_clear = function ()
  vim.notify('[vieo] failed to clear views directory', vim.log.levels.ERROR)
end

return M
