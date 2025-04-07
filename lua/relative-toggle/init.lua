local M = {}

-- To keep the combination of number and relativenumber
local current_number = vim.o.number

---Set relative number
---@param relative boolean #Whether relative number should be set
---@param redraw boolean #Whether to redraw the screen
local function set_relativenumber(relative, redraw)
    -- Ignore for buffer or window with number and relative number off by default
    if not vim.o.number and not vim.o.relativenumber then
        return
    end

    local in_insert_mode = vim.api.nvim_get_mode().mode == "i"

    vim.opt.number = not relative or in_insert_mode or current_number
    vim.opt.relativenumber = relative and not in_insert_mode

    if redraw then
        vim.cmd.redraw()
    end
end

function M.setup(user_config)
    local config = require "relative-toggle.config"
    local augroup = vim.api.nvim_create_augroup("relative-toggle", { clear = true })

    vim.opt.relativenumber = true

    config:extend(user_config)

    vim.api.nvim_create_autocmd(config.events.on, {
        pattern = config.pattern,
        group = augroup,
        desc = "Turn relative number on",
        callback = function(args)
            set_relativenumber(true, args.event == "CmdlineEnter")
        end,
    })

    vim.api.nvim_create_autocmd(config.events.off, {
        pattern = config.pattern,
        group = augroup,
        desc = "Turn relative number off",
        callback = function(args)
            set_relativenumber(false, args.event == "CmdlineEnter")
        end,
    })
end

return M
