require("awful.util")

config        = awful.util.getdir("config")
themedir      = config .. "/themes/bamboo" 

theme = {}

-- General
theme.font      = "Mono 8"
theme.border_width  = "0"

-- Colors
theme.fg_normal = "#cccccc"
theme.fg_focus  = "#ffffff"
theme.fg_urgent = "#ffffff"

theme.bg_normal = "#0c0c0c88"
theme.bg_focus  = "#0c0c0c00"
theme.bg_urgent = "#ff0c0c88"

-- Taglist Icons
theme.taglist_squares_sel   = themedir .. "/taglist/squarefz.png"
theme.taglist_squares_unsel = themedir .. "/taglist/squarez.png"

-- Tasklist Icons
theme.tasklist_floating_icon = themedir .. "/taglist/squarez.png"

return theme
