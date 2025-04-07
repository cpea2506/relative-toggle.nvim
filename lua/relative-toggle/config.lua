local config = {}

---@class events
---@field on string|string[] #Event(s) to enable relative number, see: [autocmd-events]
---@field off string|string[] #Event(s) to disable relative number, see: [autocmd-events]

---@class options
---@field pattern string|string[] #Pattern(s) where toggling is enabled, see: [autocmd-pattern]
---@field events events #Event(s) that toggle between relative and absolute line numbers
local defaults = {
    pattern = "*",
    events = {
        on = { "BufEnter", "FocusGained", "InsertLeave", "WinEnter", "CmdlineLeave" },
        off = { "BufLeave", "FocusLost", "InsertEnter", "WinLeave", "CmdlineEnter" },
    },
}

---@type options
local options = vim.deepcopy(defaults)

---Extend default with user's config
---@param opts options
function config.extend(opts)
    if not opts or vim.tbl_isempty(opts) then
        return
    end

    local events = opts.events

    if events then
        local logs = require "relative-toggle.logs"

        if not (events.on and events.off) then
            logs.error("config: events must contain two keys %q and %q", "on", "off")

            return
        end

        local function validate_events(name)
            local type_ok, err =
                pcall(vim.validate, "config(events." .. name .. ")", events[name], { "table", "string" })

            if not type_ok then
                logs.error(err)

                return false
            end

            return true
        end

        if not validate_events "on" or not validate_events "off" then
            return
        end
    end

    options = vim.tbl_deep_extend("force", options, opts)
end

setmetatable(config, {
    __index = function(_, k)
        return options[k]
    end,
})

return config
