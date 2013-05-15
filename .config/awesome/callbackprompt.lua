---------------------------------------------------------------------------
-- @author Julien Danjou &lt;julien@danjou.info&gt;
-- @copyright 2009 Julien Danjou
-- @release v3.4.13
---------------------------------------------------------------------------

local setmetatable = setmetatable

local capi = { widget = widget }
local completion = require("awful.completion")
local util = require("awful.util")
local prompt = require("awful.prompt")
local layout = require("awful.widget.layout")
local naughty = require("naughty")
local type = type

module("callbackprompt")

--- Run method for promptbox.
-- @param promptbox The promptbox to run.
local function run(promptbox, done_callback)
    return prompt.run({ prompt = promptbox.prompt },
                      promptbox.widget,
                      function (...)
                          local result = util.spawn(...)
                          if type(result) == "string" then
                              naughty.notify({ preset = naughty.config.presets.critical,
                                               text = result, title = "No such command"})
                          end
                      end,
                      completion.shell,
                      util.getdir("cache") .. "/history", 50,
                      done_callback)
end

--- Create a prompt widget which will launch a command.
-- @param args Standard widget table arguments, with prompt to change the
-- default prompt.
-- @return A launcher widget.
function new(args)
    local args = args or {}
    local promptbox = {}
    args.type = "textbox"
    promptbox.widget = capi.widget(args)
    promptbox.widget.ellipsize = "start"
    promptbox.run = run
    promptbox.prompt = args.prompt or "Run: "
    promptbox.layout = args.layout or layout.horizontal.leftright
    return promptbox
end

setmetatable(_M, { __call = function (_, ...) return new(...) end })

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
