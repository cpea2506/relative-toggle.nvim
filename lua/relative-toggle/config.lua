local logs = require "relative-toggle.logs"

local config = {}

config.options = {
    ---set relative number by default
    default_relative = true,
    ---@type string|table #pattern(s) where toggle should be enable, see: [autocmd-pattern]
    pattern = "*",
    ---@type table<string, string>[] #event to toggle between relative and absolute line numbers, each `event` receive only two keys:
    ---• `on`: event to turn relative number on
    ---• `off`: event to turn relative number off
    ---see: [autocmd-events]
    events = {
        { on = "BufEnter", off = "BufLeave" },
        { on = "FocusGained", off = "FocusLost" },
        { on = "InsertLeave", off = "InsertEnter" },
        { on = "WinEnter", off = "WinLeave" },
        { on = "CmdLineLeave", off = "CmdLineEnter" },
    },
}

---Extend default with user config
---@param user_config table #user's defined config
function config:extend(user_config)
    if not user_config or vim.tbl_isempty(user_config) then
        return
    end

    for _, event in ipairs(user_config.events) do
        if not event.on or not event.off then
            logs.error.notify "config(events): event table must contain two keys 'on' and 'off' only"

            return
        end

        local type_ok, err = pcall(vim.validate, {
            on = { event.on, "string" },
            off = { event.off, "string" },
        })

        if not type_ok then
            logs.error.notify(err)

            return
        end
    end

    self.options = vim.tbl_deep_extend("force", self.options, user_config)
end

-- allow index options without options field
return setmetatable(config, {
    __index = function(table, key)
        return table.options[key]
    end,
})
