local config = require "relative-toggle.config"
local relative_toggle = require "relative-toggle"

describe("Config options", function()
    it("could be indexed without options field", function()
        assert.equal("*", config.pattern)
        assert.are.same(config.events.on, { "BufEnter", "FocusGained", "InsertLeave", "WinEnter", "CmdlineLeave" })
        assert.are.same(config.events.off, { "BufLeave", "FocusLost", "InsertEnter", "WinLeave", "CmdlineEnter" })
    end)
end)

describe("Override config", function()
    local expected = {
        pattern = "*.toml",
        events = {
            on = "BufWinEnter",
            off = "BufWinLeave",
        },
    }

    relative_toggle.setup(expected)

    it("should change default config", function()
        assert.equal(expected.pattern, config.pattern)
        assert.are.same(expected.events, config.events)
    end)

    it("should change default autocmds", function()
        local function tbl_contains(table, value)
            return vim.tbl_contains(table, function(v)
                for k, _ in pairs(value) do
                    if v[k] ~= value[k] then
                        return false
                    end
                end

                return true
            end, { predicate = true })
        end

        local groupid = vim.api.nvim_create_augroup("relative-toggle", { clear = false })
        local autocmds = vim.api.nvim_get_autocmds { group = groupid }

        assert.is_true(tbl_contains(autocmds, { pattern = "*.toml", event = "BufWinEnter" }))
        assert.is_true(tbl_contains(autocmds, { pattern = "*.toml", event = "BufWinLeave" }))
        assert.is_false(tbl_contains(autocmds, { pattern = "*.toml", event = "InsertEnter" }))
    end)

    it("should change default relativenumber", function()
        local groupid = vim.api.nvim_create_augroup("relative-toggle", { clear = false })

        vim.api.nvim_exec_autocmds(config.events.on, {
            group = groupid,
            pattern = config.pattern,
        })

        assert.is_true(vim.o.relativenumber)

        vim.api.nvim_exec_autocmds(config.events.off, {
            group = groupid,
            pattern = config.pattern,
        })

        assert.is_false(vim.o.relativenumber)
    end)
end)
