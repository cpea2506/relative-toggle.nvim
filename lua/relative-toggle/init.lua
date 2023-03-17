local M = {}

local config = require "relative-toggle.config"
local logs = require "relative-toggle.logs"

---creates an autocommand event handler.
---@param event object
---@param opts? table<string, any>
local function create_autocmd(event, opts)
    local event_ok, error = pcall(vim.api.nvim_create_autocmd, event, opts)

    if not event_ok then
        logs.error.notify(error)
    end
end

---@param relative boolean #whether relativenumber should be set
---@param redraw boolean #whether to redraw the screen
local function set_relativenumber(relative, redraw)
    local in_insert_mode = vim.api.nvim_get_mode().mode == "i"

    if vim.o.number then
        vim.opt.relativenumber = relative and not in_insert_mode

        if redraw then
            vim.cmd "redraw"
        end
    end
end

function M.setup(user_config)
    -- load user config
    config:extend(user_config)

    local events = config.events
    local augroup = vim.api.nvim_create_augroup("relative-toggle", {})

    create_autocmd(events.on, {
        pattern = config.pattern,
        group = augroup,
        desc = "turn relative number on",
        callback = function(ev)
            set_relativenumber(true, ev.event == "CmdlineEnter")
        end,
    })

    create_autocmd(events.off, {
        pattern = config.pattern,
        group = augroup,
        desc = "turn relative number off",
        callback = function(ev)
            set_relativenumber(false, ev.event == "CmdlineEnter")
        end,
    })
end

return M
