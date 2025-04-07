describe("Override config", function()
    local relative_toggle = require "relative-toggle"
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
end)
