(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(custom-set-faces
 '(default ((t (:background "black"
                            :foreground "white"
                            :weight normal
                            :height 80
                            :width normal
                            :family "DejaVu Sans Mono")))))

(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha 90 90))

(live-use-packs '(live/foundation-pack
		  live/clojure-pack
		  live/lang-pack
		  live/git-pack
		  live/power-pack))

(setq live-disable-zone t)

(live-add-packs '(~/.live-packs/adam-pack))
