(live-load-config-file "bindings.el")
(load "clojure")

;;; Sloppy focus
(setq mouse-autoselect-window t)

;;; Pressing enter does a reindent too by default
(global-set-key "\C-m" 'newline-and-indent)

;;; Multiple point editing FTW!
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)

;;; Info about at which point I would like the screen to split
;;; vertically vs horizontally
(setq split-height-threshold nil)
(setq split-width-threshold 180)

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

;;; Set the file to save repl history
(setq nrepl-history-file "~/.emacs.d/.nrepl-history")

;;; Nrepl jack in with the dev profile by default
(add-hook 'nrepl-mode-hook
      '(lambda ()
         (set-variable 'nrepl-server-command
                       "lein with-profile dev repl")))

;;; Show full stack traces in the repl
(setq nrepl-popup-stacktraces nil)
(setq nrepl-popup-stacktraces-in-repl t)

;;; Add in extra repositories/packages
(require 'package)
(setq package-archives
      '(("melpa" . "http://melpa.milkbox.net/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)

(defvar my-packages '(latest-clojure-libraries
                      clj-refactor))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;; Set a more interesting error underline for nrepl
(set-face-attribute 'nrepl-error-highlight-face nil :inherit nil :underline '(:color "red4" :style wave))

;;; Make M-SPC multiline by default
(global-set-key (kbd "M-SPC") (lambda () (interactive) (just-one-space -1)))

(require 'clj-refactor)
(add-hook 'clojure-mode-hook
          (lambda ()
             (clj-refactor-mode 1)
             (cljr-add-keybindings-with-prefix "C-c r")))

(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)
