
function toggle_minimized (c)
   if c == client.focus then
      c.minimized = true
   else
      if not c:isvisible() then
         awful.tag.viewonly(c:tags()[1])
      end
      client.focus = c
      c:raise()
   end
end


function maximize (c)
   c.maximized_horizontal = not c.maximized_horizontal
   c.maximized_vertical   = not c.maximized_vertical
end


function focus_sloppily (c)
   if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
      and awful.client.focus.filter(c) then
   client.focus = c
   end
end

function toggle_wibox ()
   -- Not very pretty, this references things in rc.lua
   mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible 
end

function raise_next_client ()
   awful.client.focus.byidx( 1)
   if client.focus then client.focus:raise() end
end

function raise_prev_client()
   awful.client.focus.byidx(-1)
   if client.focus then client.focus:raise() end
end

