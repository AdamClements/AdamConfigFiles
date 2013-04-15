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
        (let ((old-point (point)))
          ;; Oddly, save-excursion doesn't do a good job of preserving point.
          ;; It's probably because we delete the string and then re-insert it.
          (save-restriction
            (save-excursion
              (let* ((string-region (clojure-docstring-start+end-points))
                     (string-start (1+ (car string-region)))
                     (string-end (cdr string-region))
                     (string (buffer-substring-no-properties (1+ (car string-region))
                                                             (cdr string-region))))
                (delete-region string-start string-end)
                (insert
                 (with-temp-buffer
                   (insert string)
                   (let ((left-margin 3))
                     (delete-trailing-whitespace)
                     (fill-region (point-min) (point-max))
                     (buffer-substring-no-properties (+ left-margin (point-min)) (point-max))))))))
          (goto-char old-point))
      ;; If we're not in a string, do a normal paredit reindent
      (paredit-reindent-defun))))

(define-key clojure-mode-map (kbd "C-q") 'custom-clojure-reindent)
