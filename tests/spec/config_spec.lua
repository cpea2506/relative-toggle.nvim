describe("Override config", function()
    local relative_toggle = require "relative-toggle"
    local logs = require "relative-toggle.logs"
    local config = require "relative-toggle.config"

    before_each(function()
        logs.error.msg = ""
    end)

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

        assert.is_not.equal("", logs.error.msg)
    end)

    it("should log error with wrong type", function()
        local wrong_config = {
            events = {
                on = "BufEnter",
                off = true,
            },
        }

        relative_toggle.setup(wrong_config)

        assert.is_not.equal("", logs.error.msg)
    end)
end)
