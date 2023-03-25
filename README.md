# 🎚️ relative-toggle.nvim

Automatically toggling smoothly between relative and absolute line numbers in various Neovim events. This is useful when you want to take advantage of the information on those types of numbers in different situations.

![demo](https://user-images.githubusercontent.com/42694704/227732590-e95d94e9-6c06-45dd-91aa-b419525df295.mov)

## 📦 Installation

```lua
use "cpea2506/relative-toggle.nvim"
```

### Requirements

- Neovim >= 0.7.2

## ⚙️ Setup

After installed, this plugin will automatically active so no setup statement is required unless you want to custom some options.

### Options

| Option       | Description                               | Type           | Note                 |
| ------------ | ----------------------------------------- | -------------- | -------------------- |
| `pattern`    | pattern where the plugin should be enable | `string/table` | `:h autocmd-pattern` |
| `events.on`  | event to toggle relative number on        | `string/table` | `:h autocmd-events`  |
| `events.off` | event to toggle relative number off       | `string/table` | `:h autocmd-events`  |

#### Default

```lua
require("relative-toggle").setup ({
    pattern = "*",
    events = {
        on = { "BufEnter", "FocusGained", "InsertLeave", "WinEnter", "CmdlineLeave" },
        off = { "BufLeave", "FocusLost", "InsertEnter", "WinLeave", "CmdlineEnter" },
    },
})
```

## 💡 Tips

1. The keymap `Ctrl-C` does not trigger the `InsertLeave` event (`:h i_CTRL-C`) so you need to use another keymap that has a capability to do it. For ex:

   - Builtin keymap: `Esc`, `Ctrl-[`, `Ctrl-o`,...
   - Escape mapping plugins: [better-escape][better-escape], [houdini][houdini],...

2. To make sure the numbers really **toggle** (lol), when you define an event in `events.on` table, you should define its opposite event in `events.off` table. For ex: `BufEnter - BufLeave`, `VimEnter - VimLeave`,...

3. The `relativenumber` is always on by default. So based on the value of `vim.opt.number`, the displayed number to be
   relative to the cursor will be changed as follows (`:h number_relativenumber`):

   ```nvim
       'nonu'          'nu'
       'rnu'           'rnu'

       |  2 apple      |  2 apple
       |  1 pear       |  1 pear
       |0   nobody     |3   nobody
       |  1 there      |  1 there
   ```

## Inspiration

- [nvim-numbertoggle](https://github.com/sitiom/nvim-numbertoggle)

## Contribution

Please see [the contributing guidelines](CONTRIBUTING.md) for detailed
instructions on how to contribute to this project.

<!--- references --->

[better-escape]: https://github.com/max397574/better-escape.nvim
[houdini]: https://github.com/TheBlob42/houdini.nvim
