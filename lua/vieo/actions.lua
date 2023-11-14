-- actions for views

local M = {}

local n = require 'vieo.notification'

M.clear_views = function (conf)
  -- won't complain if not exist
  vim.fn.delete(conf.viewdir, 'rf')

  if conf.verbose then n.notify_clear() end
end

-- perform an action f
-- in the envirnoment where
-- 'viewdir' option is temporarily set to conf.viewdir;
-- 'viewdir' will be restored after f terminates,
-- even if f throws an error.
local with_viewdir = function (conf, f)
  local original = vim.o.viewdir
  vim.o.viewdir = conf.viewdir
  local ok, msg = pcall(f)
  vim.o.viewdir = original
  if not ok then
    error(msg)  -- rethrow
  end
end

local builtin_rule = function (user, buf)
  local notify = function (...) if user.verbose then vim.notify(...) end end

  if user.override_builtin_rule then
    notify('[vieo] using user-defined rule')
    return user.override_builtin_rule(buf)
  end

  -- in diff mode?
  local diffmode = function ()
    return vim.api.nvim_buf_call(buf, function ()
      return vim.wo.diff
    end)
  end

  -- is temp file?
  local tempfile = function ()
    local tmp = os.getenv 'TMPDIR'
    if tmp then
      return tmp == vim.fs.dirname(vim.api.nvim_buf_get_name(buf))
    end

    return false
  end

  local bufname = vim.api.nvim_buf_get_name
  local buftype = vim.bo[buf].buftype
  local modifiable = vim.bo[buf].modifiable

  local res = (not diffmode())
          and (not tempfile())
          and (not bufname(buf) ~= '')
          and (not bufname(buf):match '%[.*%]')  -- [No Name]
          and buftype == ''
          and modifiable

  return res
end

-- should save view for buf?
M.should_save = function (user, buf)
  local res = builtin_rule(user, buf) and user.enable(buf)
  return res
end

M.restore_view = function (conf, buf)
  with_viewdir(conf, function ()
    vim.api.nvim_buf_call(buf, function ()
      vim.cmd 'silent! loadview'
    end)
  end)
end

M.save_view = function (conf, buf)
  with_viewdir(conf, function ()
    vim.api.nvim_buf_call(buf, function ()
      vim.cmd 'silent! mkview!'
    end)
  end)
end

return M
