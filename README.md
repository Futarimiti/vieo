# vieo

Save and restore views across sessions
plus huge customisation

### Functionalities

- Auto save and restore views across sessions for *approriate buffers*
- Command `ClearViews` for clearing views
- Great user control

### Installation

```lua
-- lazy.nvim
return { 'Futarimiti/vieo', opts = {} }
```

### Configuration

See [here](lua/vieo/config/defaults.lua) for full configuration,
including docs, types and defaults for each option.

### Common issues

If you use `<C-C>` to exit insert mode, you may sometimes see a keyboard interrupt error like this:
```
Error detected while processing BufWinLeave Autocommands for "*":
Error executing lua callback: <path/to/vieo>/lua/vieo/actions.lua:55: Keyboard interrupt
stack traceback:
	[C]: in function '__index'
	/Users/futar/.config/nvim/dev/vieo/lua/vieo/actions.lua:55: in function 'builtin_rule'
	/Users/futar/.config/nvim/dev/vieo/lua/vieo/actions.lua:70: in function 'should_save'
	/Users/futar/.config/nvim/dev/vieo/lua/vieo/autocmd.lua:21: in function <<path/to/vieo>/lua/vieo/autocmd.lua:20>
```

This is not a problem with vieo, but rather with Neovim's API.
See [this issue](https://github.com/neovim/neovim/issues/16416) for more details.

### Credits 

- Robert Sears, for the original plugin
- Bram Moolenaar, for having this in `:h loadview`
    ```vim
    au BufWinLeave *.c mkview
    au BufWinEnter *.c silent! loadview
    ```
    Who could imagine what used to only take two lines
    becomes such a complex thing?
