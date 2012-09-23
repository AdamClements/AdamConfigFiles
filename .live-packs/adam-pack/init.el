;; User pack init file
;;
;; User this file to initiate the pack configuration.
;; See README for more information.

;; Load bindings config
(live-load-config-file "bindings.el")


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
                :width extra-condensed
                :foundry "unknown"
                :family "DejaVu Sans Mono")))))


(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha 90 90))
