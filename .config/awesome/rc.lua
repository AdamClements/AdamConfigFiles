require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("naughty")
require("revelation")
require("eminent")

require("errorhandling")
require("util")

-- Theme
beautiful.init("/home/adam/.config/awesome/themes/thinnest/theme.lua")

terminal = "urxvt"
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
}

-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end

-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                        awful.button({ }, 1, awful.tag.viewonly),
                        awful.button({ modkey }, 1, awful.client.movetotag))

mytasklist = {}
mytasklist.buttons = awful.util.table.join(awful.button({ }, 1, toggle_minimized))

for s = 1, screen.count() do
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    mytaglist[s]   = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)
    mytasklist[s]  = awful.widget.tasklist(function (c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                           end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },

        mytextclock,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
    -- But hide it by default
    mywibox[s].visible = false
end

-------------------------------------------------------------------------------------------------
-- Global keybindings
-------------------------------------------------------------------------------------------------
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),

    -- Twoggle through clients
    awful.key({ modkey,           }, "Tab",  raise_next_client),
    awful.key({ modkey, "Shift"   }, "Tab",  raise_prev_client),

    -- Show/hide the wibox
    awful.key({ modkey }, "b", toggle_wibox),

    -- Revelation bindings
    awful.key({modkey}, "e", revelation),

    -- Layout manipulation
    awful.key({ modkey, "Control" }, "Tab",   function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),

    -- Running stuff
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey            }, "r",
              function ()
                 mywibox[mouse.screen].visible = true
                 mytimer = timer({ timeout = 10 })
                 mytimer:add_signal("timeout", function() mywibox[mouse.screen].visible = false end)
                 mytimer:start()
                 mypromptbox[mouse.screen]:run()
              end),

    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit)
)
root.keys(globalkeys)


-------------------------------------------------------------------------------------------------
-- Per client bindings and rules
-------------------------------------------------------------------------------------------------
clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",         function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",         function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",     awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return",    function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",         awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",         function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "m",         maximize)
)

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

awful.rules.rules = {
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     size_hints_honor = false,
                     keys = clientkeys,
                     buttons = clientbuttons } }
}

-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    c:add_signal("mouse::enter", focus_sloppily)

    -- Put windows at the end (least significant slot)
    if not startup then awful.client.setslave(c) end
end)
