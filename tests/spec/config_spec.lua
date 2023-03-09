describe("Override config", function()
    local relative_toggle = require "relative-toggle"
    local logs = require "relative-toggle.logs"
    local config = require "relative-toggle.config"

    it("should change default config", function()
        local expected = {
            pattern = "*.toml",
            events = {
                on = "BufWinEnter",
                off = "BufWinLeave",
            },
        }

        relative_toggle.setup(expected)

        assert.are.same(expected, config.options)
    end)

    it("should log error with wrong key", function()
        local wrong_config = {
            events = {
                on = "BufEnter",
                lmao = "BufLeave",
                off = false,
            },
        }

        relative_toggle.setup(wrong_config)

        assert.equal("config: events must contain two keys 'on' and 'off'", logs.error.msg)

        vim.schedule(function()
            assert.equal(true, logs.error.msg_displayed)
        end)
    end)

    it("should log error with wrong type", function()
        local wrong_config = {
            events = {
                on = "BufEnter",
                off = true,
            },
        }

        relative_toggle.setup(wrong_config)

        assert.equal("off: expected table|string, got boolean", logs.error.msg)

        vim.schedule(function()
            assert.equal(true, logs.error.msg_displayed)
        end)
    end)
end)
