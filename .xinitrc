#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Make sure that the background is solid black, probably unnecessary
hsetroot -solid "#000000"

# Set the background, different for different computers
case $(uname -n) in
    glados)
        # On powerful computers, animated background!
        background glmatrix &
        ;;
    *)
        # Simple picture by default
        feh --bg-scale --no-xinerama /home/adam/.config/awesome/themes/bamboo/background.jpg
        ;;
esac

# Improve performance for things doing a lot of pixmap shuffling
nvidia-settings -a InitialPixmapPlacement=2

# Make games work on just one of the screens
export SDL_VIDEO_FULLSCREEN_HEAD=0

# Sets the colour temperature of the screen to be lovely
xflux -l 51.5 -g -0.1 &

# Transparent windows and such
unagi &

# Turn off the annoying terminal beep
xset -b

# Load in some key binding settings (for volume control etc)
xbindkeys &

# Load my custom keyboard layout (if it exists)
if [ -f /home/adam/.Xmodmap ]
then
    xmodmap /home/adam/.Xmodmap
else
    setxkbmap dvorak
fi

# Tell everything that we're running looking glass 3d, in the hope that java will play nice
wmname LG3D

# Start the disk auto-mounter. We don't live in the stone age
devmon &

# Run the window manager
exec awesome
