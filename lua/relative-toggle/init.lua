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

-- to keep the combination of number and relativenumber
local current_number = vim.o.number

---@param relative boolean #whether relativenumber should be set
---@param redraw boolean #whether to redraw the screen
local function set_relativenumber(relative, redraw)
    -- ignore for buffer with these off by default
    if not vim.o.number and not vim.o.relativenumber then
        return
    end

    local in_insert_mode = vim.api.nvim_get_mode().mode == "i"

    vim.opt.number = not relative or in_insert_mode or current_number
    vim.opt.relativenumber = relative and not in_insert_mode

    if redraw then
        vim.cmd "redraw"
    end
end

function M.setup(user_config)
    local events = config.events
    local augroup = vim.api.nvim_create_augroup("relative-toggle", {})

    vim.opt.relativenumber = true

    config:extend(user_config)

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
