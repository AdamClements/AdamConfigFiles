(defun custom-clojure-reindent (&optional argument)
  "Fill the definition that the point is on appropriate for Clojure.

  Fills so that every paragraph has a minimum of two initial spaces,
  with the exception of the first line. Fill margins are taken from
  paragraph start, so a paragraph that begins with four spaces will
  remain indented by four spaces after refilling."
  (interactive "P")
  (when (and (fboundp 'paredit-in-string-p)
             (fboundp 'paredit-reindent-defun)
             paredit-mode)
    (if (paredit-in-string-p)
        (clojure-fill-docstring)
        (paredit-reindent-defun))))

(define-key clojure-mode-map (kbd "C-q") 'custom-clojure-reindent)
