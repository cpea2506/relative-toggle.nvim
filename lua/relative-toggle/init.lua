local M = {}

local config = require "relative-toggle.config"
local logs = require "relative-toggle.logs"
local api = vim.api

---creates an autocommand event handler.
---@param event object
---@param opts? table<string, any>
local function create_autocmd(event, opts)
    local event_ok, error = pcall(api.nvim_create_autocmd, event, opts)

    if not event_ok then
        logs.error.notify(error)
    end
end

---@param relative boolean #whether relativenumber should be set
local function set_relativenumber(relative)
    local in_insert_mode = vim.api.nvim_get_mode().mode == "i"

    if vim.o.number then
        vim.opt.relativenumber = relative and not in_insert_mode
    end
end

function M.setup(user_config)
    -- load user config
    config:extend(user_config)

    local events = config.events
    local augroup = api.nvim_create_augroup("relative-toggle", {})

    create_autocmd(events.on, {
        pattern = config.pattern,
        group = augroup,
        desc = "turn relative number on",
        callback = function()
            set_relativenumber(true)
        end,
    })

    create_autocmd(events.off, {
        pattern = config.pattern,
        group = augroup,
        desc = "turn relative number off",
        callback = function()
            set_relativenumber(false)
        end,
    })
end

return M
