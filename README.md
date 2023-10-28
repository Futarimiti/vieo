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

### Credits 

- Robert Sears, for the original plugin
- Bram Moolenaar, for having this in `:h loadview`
    ```vim
    au BufWinLeave *.c mkview
    au BufWinEnter *.c silent! loadview
    ```
    Who could imagine what used to only take two lines
    becomes such a complex thing?
