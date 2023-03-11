# 🎚️ relative-toggle.nvim

Automatically toggle smoothly between relative and absolute line numbers in various Neovim events. This is useful when you want to take advantage of those type of number's information in different situations.

https://user-images.githubusercontent.com/42694704/224506660-75dc1e01-83ef-4cab-9361-55b45a1c4539.mov

## 📦 Installation

```lua
use "cpea2506/relative-toggle.nvim"
```

### Requirements

- Neovim >= 0.7.2

## ⚙️ Setup

After installed, this plugin will automatically active so no setup statement is required unless you want some custom options.

### Options

| Option       | Description                               | Type              | Note                 |
| ------------ | ----------------------------------------- | ----------------- | -------------------- |
| `pattern`    | pattern where the plugin should be enable | `string or table` | `:h autocmd-pattern` |
| `events.on`  | event to toggle relative number on        | `table`           | `:h autocmd-events`  |
| `events.off` | event to toggle relative number off       | `table`           | `:h autocmd-events`  |

#### Default

```lua
require("relative-toggle").setup ({
    pattern = "*",
    events = {
        on = { "BufEnter", "FocusGained", "InsertLeave", "WinEnter", "CmdLineLeave" },
        off = { "BufLeave", "FocusLost", "InsertEnter", "WinLeave", "CmdLineEnter" },
    },
})
```

## 💡 Tips

1. The keymap `Ctrl-C` does not trigger the `InsertLeave` event (`:h i_CTRL-C`) so you need to use another key that has a capability to do it. For ex: `Esc`, `Ctrl-[`, `Ctrl-o`,...
2. To make the numbers really **_toggle_**, when you define an event in `events.on` table, you should define its oposite event in the `events.off` table. For ex: `BufEnter - BufLeave`, `VimEnter - VimLeave`,...

## Inspiration

- [nvim-numbertoggle](https://github.com/sitiom/nvim-numbertoggle)

## Contribution

Please see [the contributing guidelines](CONTRIBUTING.md) for detailed
instructions on how to contribute to this project.
