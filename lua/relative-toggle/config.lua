local logs = require "relative-toggle.logs"

local config = {}

config.options = {
    ---@type string|table #pattern(s) where toggle should be enable, see: [autocmd-pattern]
    pattern = "*",
    ---@type table<string, string | string[] > #event(s) to toggle between relative and absolute line numbers.
    ---• `on`: event to turn relative number on
    ---• `off`: event to turn relative number off
    ---see: [autocmd-events]
    events = {
        on = { "BufEnter", "FocusGained", "InsertLeave", "WinEnter", "CmdlineLeave" },
        off = { "BufLeave", "FocusLost", "InsertEnter", "WinLeave", "CmdlineEnter" },
    },
}

---Extend default with user config
---@param user_config table #user's defined config
function config:extend(user_config)
    if not user_config or vim.tbl_isempty(user_config) then
        return
    end

    local events = user_config.events

    if events then
        if not (events.on and events.off) then
            logs.error "config: events must contain two keys 'on' and 'off'"

            return
        end

        local types_ok, err = pcall(vim.validate, {
            on = { events.on, { "table", "string" } },
            off = { events.off, { "table", "string" } },
        })

        if not types_ok then
            logs.error(err)

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
