;;; Add in some extra snazzy font symbols for clojure
(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("(\\(comp\\)[\[[:space:]]"
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "∘")
                               nil))))))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("(\\(partial\\)[\[[:space:]]"
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "→")
                               nil))))))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("(\\(conde\\|matche\\)[\[[:space:]]"
                     (0 (progn (compose-region (- (match-end 1) 1)
                                               (match-end 1) "ₑ")
                               nil))))))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("(\\(conso\\|membero\\|appendo\\|rembero\\)[\[[:space:]]"
                     (0 (progn (compose-region (- (match-end 1) 1)
                                               (match-end 1) "ₒ")
                               nil))))))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("(\\(Exception.\\)[\[[:space:]]"
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "⚡")
                               nil))))))
