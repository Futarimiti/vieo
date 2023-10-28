local M = {}

M.setup_views_dirs = function (user)
  vim.fn.mkdir(user.viewdir, 'p')
end

return M
