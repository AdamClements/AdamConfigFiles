(live-load-config-file "bindings.el")

;;; Sloppy focus
(setq mouse-autoselect-window t)

;;; Pressing enter does a reindent too by default
(global-set-key "\C-m" 'newline-and-indent)

;;; Multiple point editing FTW!
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

;;; Set up
(setq split-height-threshold nil)
(setq split-width-threshold 160)

;;; Open links in chrome
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

;;; Properly highlight README.md files
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(live-load-config-file "extra-clojure-symbols.el")
(live-load-config-file "git-gutter-dehorrify.el")

;;; Take the nrepl out of the list of windows to open in other buffers
(setq same-window-buffer-names
      (delete "*nrepl*" same-window-buffer-names))


;;; Add in extra repositories
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
