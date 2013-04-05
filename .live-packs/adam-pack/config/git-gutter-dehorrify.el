;;; Configure the git gutter to be less horrific in appearance
(require 'git-gutter)

(setq git-gutter:window-width 1)
(setq git-gutter:modified-sign "~")
(setq git-gutter:added-sign "+")
(setq git-gutter:deleted-sign "-")
(setq git-gutter:unchanged-sign "")
