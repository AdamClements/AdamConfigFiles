;; Emacs LIVE
;;
;; This is where everything starts. Do you remember this place?
;; It remembers you...

(add-to-list 'command-switch-alist
             (cons "--live-safe-mode"
                   (lambda (switch)
                     nil)))

(setq live-safe-modep
      (if (member "--live-safe-mode" command-line-args)
          "debug-mode-on"
        nil))

(setq initial-scratch-message "
;; I'm sorry, Emacs Live failed to start correctly.
;; Hopefully the issue will be simple to resolve.
;;
;; First up, could you try running Emacs Live in safe mode:
;;
;;    emacs --live-safe-mode
;;
;; This will only load the default packs. If the error no longer occurs
;; then the problem is probably in a pack that you are loading yourself.
;; If the problem still exists, it may be a bug in Emacs Live itself.
;;
;; In either case, you should try starting Emacs in debug mode to get
;; more information regarding the error:
;;
;;    emacs --debug-init
;;
;; Please feel free to raise an issue on the Gihub tracker:
;;
;;    https://github.com/overtone/emacs-live/issues
;;
;; Alternatively, let us know in the mailing list:
;;
;;    http://groups.google.com/group/overtone
;;
;; Good luck, and thanks for using Emacs Live!
;;
;;                _.-^^---....,,--
;;            _--                  --_
;;           <          SONIC         >)
;;           |       BOOOOOOOOM!       |
;;            \._                   _./
;;               ```--. . , ; .--'''
;;                     | |   |
;;                  .-=||  | |=-.
;;                  `-=#$%&%$#=-'
;;                     | ;  :|
;;            _____.,-#%&$@%#&#~,._____
;;      May these instructions help you raise
;;                  Emacs Live
;;                from the ashes
")

(setq live-supported-emacsp t)

(when (< emacs-major-version 24)
  (setq live-supported-emacsp nil)
  (setq initial-scratch-message (concat "
;;                _.-^^---....,,--
;;            _--                  --_
;;           <          SONIC         >)
;;           |       BOOOOOOOOM!       |
;;            \._                   _./
;;               ```--. . , ; .--'''
;;                     | |   |
;;                  .-=||  | |=-.
;;                  `-=#$%&%$#=-'
;;                     | ;  :|
;;            _____.,-#%&$@%#&#~,._____
;;
;; I'm sorry, Emacs Live is only supported on Emacs 24+.
;;
;; You are running: " emacs-version "
;;
;; Please upgrade your Emacs for full compatibility.
;;
;; Latest versions of Emacs can be found here:
;;
;; OS X GUI     - http://emacsformacosx.com/
;; OS X Console - via homebrew (http://mxcl.github.com/homebrew/)
;;                brew install emacs
;; Windows      - http://alpha.gnu.org/gnu/emacs/windows/
;; Linux        - Consult your package manager or compile from source

"))
  (let* ((old-file (concat (file-name-as-directory "~") ".emacs-old.el")))
    (if (file-exists-p old-file)
      (load-file old-file)
      (error (concat "Oops - your emacs isn't supported. Emacs Live only works on Emacs 24+ and you're running version: " emacs-version ". Please upgrade your Emacs and try again, or define ~/.emacs-old.el for a fallback")))))

(when live-supported-emacsp
;; Store live base dirs
(setq live-root-dir user-emacs-directory)

(setq
 live-tmp-dir      (file-name-as-directory (concat live-root-dir "tmp"))
 live-etc-dir      (file-name-as-directory (concat live-root-dir "etc"))
 live-lib-dir      (file-name-as-directory (concat live-root-dir "lib"))
 live-packs-dir    (file-name-as-directory (concat live-root-dir "packs"))
 live-autosaves-dir(file-name-as-directory (concat live-tmp-dir  "autosaves"))
 live-backups-dir  (file-name-as-directory (concat live-tmp-dir  "backups"))
 live-load-pack-dir nil)

;; create tmp dirs if necessary
(make-directory live-etc-dir t)
(make-directory live-tmp-dir t)
(make-directory live-autosaves-dir t)
(make-directory live-backups-dir t)

;; Load manifest
(load-file (concat live-root-dir "manifest.el"))

;; load live-lib
(load-file (concat live-lib-dir "live-core.el"))

;;default live packs
(let* ((live-dir (file-name-as-directory "live")))
  (setq live-packs (list (concat live-dir "foundation-pack")
                         (concat live-dir "colour-pack")
                         (concat live-dir "clojure-pack")
                         (concat live-dir "lang-pack")
                         (concat live-dir "power-pack"))))

;; Helper fn for loading live packs

(defun live-version ()
  (interactive)
  (if (called-interactively-p 'interactive)
      (message "%s" (concat "This is Emacs Live " live-version))
    live-version))


;; Load `~/.emacs-live.el`. This allows you to override variables such
;; as live-packs (allowing you to specify pack loading order)
;; Does not load if running in safe mode
(let* ((pack-file (concat (file-name-as-directory "~") ".emacs-live.el")))
  (if (and (file-exists-p pack-file) (not live-safe-modep))
      (load-file pack-file)))

;; Load all packs - Power Extreme!
(mapcar (lambda (pack-dir)
          (live-load-pack pack-dir))
        (live-pack-dirs))


(when live-supported-emacsp
  (setq initial-scratch-message (concat ";;
;; Hey Adam.
;; TODO: Add fortunes back here
")))
)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(sclang-auto-scroll-post-buffer t)
 '(sclang-eval-line-forward nil)
 '(sclang-help-path (quote ("/Applications/SuperCollider/Help")))
 '(sclang-runtime-directory "~/.sclang/"))
