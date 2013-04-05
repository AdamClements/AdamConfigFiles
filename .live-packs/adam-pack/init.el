;; User pack init file
;;
;; User this file to initiate the pack configuration.
;; See README for more information.

;; Load bindings config
(live-load-config-file "bindings.el")

(live-use-packs '(live/foundation-pack
                  live/clojure-pack))


(custom-set-faces
 '(default ((t (:inherit nil
                :stipple nil
                :background "black"
                :foreground "white"
                :inverse-video nil
                :box nil
                :strike-through nil
                :overline nil
                :underline nil
                :slant normal
                :weight normal
                :height 80
                :width normal
                :foundry "unknown"
                :family "DejaVu Sans Mono")))))


(set-frame-parameter (selected-frame) 'alpha '(85 85))
(add-to-list 'default-frame-alist '(alpha 85 85))

(setq mouse-autoselect-window t)

(global-set-key "\C-m" 'newline-and-indent)

(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
