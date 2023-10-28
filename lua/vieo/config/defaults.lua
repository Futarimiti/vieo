local typecheck = function (conf)
  vim.validate
  { conf = { conf, 'table' }
  , verbose = { conf.verbose, 'boolean' }
  , viewdir = { conf.viewdir, 'string' }
  , enable = { conf.enable, 'function' }
  , override_builtin_rule = { conf.override_builtin_rule, { 'nil', 'function' } }
  }
end

local defaults =
{ verbose = false

-- by default, view.nvim will not dirty the default viewdir
-- but rather use the isolated `.cache/vieo/views/`
-- if you would like to use the default viewdir, or specify your own,
-- change this to your target
, viewdir = vim.fn.stdpath('cache') .. '/vieo/views'

-- view.nvim thinks twice before restoring views
-- but on top of that, you may want to define extra rules to exclude buffers
-- on which restoring views are not useful e.g. gitcommit
--
-- here you can specify a predicate, given a buffer handle,
-- used to determine if view restoring should be applied to it
-- i.e. fun(integer) -> boolean
--
-- to disable saving gitcommit buffers, you can pass
-- `function (buf) return vim.bo[buf].filetype ~= 'gitcommit' end`
, enable = function (_) return true end

-- here's the rough builtin rule:
-- ```lua
-- builtin_rule = function (buf)
--   return buftype == ''
--      and modifiable
--      and not diffmode(buf)
--      and not bufname == ''
--      and not bufname:match '%[.*%]'  -- [No Name]
--      and not tempfile(buf)
-- end
-- ```
-- if you believe this could mistakenly kill files that
-- ought to be saved, you can override this rule by passing
-- using a predicate of buffer handle i.e. fun(integer) -> boolean
-- (Though I would recommend you open an issue on GitHub
-- if you find this flawed ;)
, override_builtin_rule = nil
}

assert(pcall(typecheck, defaults))

return { defaults = defaults, typecheck = typecheck }
