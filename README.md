# 🎚️ relative-toggle.nvim

Automatically toggles smoothly between relative and absolute line numbers on various Neovim events. This is useful when you want to take advantage of both types of line numbers in different situations.

![demo](https://user-images.githubusercontent.com/42694704/227732590-e95d94e9-6c06-45dd-91aa-b419525df295.mov)

## 🚀 Installation

```lua
{
  "cpea2506/relative-toggle.nvim"
}
```

### Requirements

- Neovim >= 0.8.0

## ⚙️ Setup

Once installed, this plugin is activated automatically. No setup is required unless you want to customize the options.

### Available Options

| Option       | Description                                 | Type            | Note                 |
| ------------ | ------------------------------------------- | --------------- | -------------------- |
| `pattern`    | Patterns where the plugin should be enabled | `string\|table` | `:h autocmd-pattern` |
| `events.on`  | Events that turn relative numbers on        | `string\|table` | `:h autocmd-events`  |
| `events.off` | Events that turn relative numbers off       | `string\|table` | `:h autocmd-events`  |

### Default Configuration

```lua
require("relative-toggle").setup({
    pattern = "*",
    events = {
        on = { "BufEnter", "FocusGained", "InsertLeave", "WinEnter", "CmdlineLeave" },
        off = { "BufLeave", "FocusLost", "InsertEnter", "WinLeave", "CmdlineEnter" },
    },
})
```

## 💡 Tips

1. The keymap `Ctrl-C` does **not** trigger the `InsertLeave` event (`:h i_CTRL-C`), so you’ll need to use another keymap that does. For example:

   - Built-in keymaps: `Esc`, `Ctrl-[`, `Ctrl-o`, ...
   - Escape-mapping plugins: [better-escape][better-escape], [houdini][houdini], ...

2. To ensure the numbers actually **toggle** (lol), when you define an event in the `events.on` table, you should also define its corresponding "off" event in the `events.off` table. For example: `BufEnter` - `BufLeave`, `VimEnter` - `VimLeave`, ...

3. The `relativenumber` option is always enabled by default. So, based on the value of `vim.opt.number`, the line numbers displayed relative to the cursor will change as follows (`:h number_relativenumber`):

   ```nvim
   'nonu'          'nu'
   'rnu'           'rnu'

   |  2 apple      |  2 apple
   |  1 pear       |  1 pear
   |0   nobody     |3   nobody
   |  1 there      |  1 there
   ```

## :eyes: Inspiration

- [nvim-numbertoggle](https://github.com/sitiom/nvim-numbertoggle)

## :scroll: Contribution

For detailed instructions on how to contribute to this plugin, please see [the contributing guidelines](CONTRIBUTING.md).

<!--- References --->

[better-escape]: https://github.com/max397574/better-escape.nvim
[houdini]: https://github.com/TheBlob42/houdini.nvim
