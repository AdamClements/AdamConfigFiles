;;; A major mode for emacs to edit imprint assembly files, supports
;;; comments, comment wrapping, syntax highlighting, etc

(defvar imprint-mode-hook nil)

(defvar imprint-mode-map
  (let ((imprint-mode-map (make-keymap)))
    (define-key imprint-mode-map "\C-j" 'newline-and-indent)
    imprint-mode-map)
  "Keymap for Imprint major mode")

(add-to-list 'auto-mode-alist '("\\.bot\\'" . imprint-mode))

;; (regexp-opt '("Sub" "Add" "MessagePush" "MessagePeek" "Mod" "NearestUnit" "NoOp" "VecComp" "Random" "Or" "Max" "PushFrom" "Mul" "VecDecomp" "JumpNe" "MessagePoll" "MessageSetChannel" "MessagePop" "PopTo" "VecSub" "MoveTo" "VecAdd" "VecInvScale" "Jump" "SetColour" "MessageSend" "StatId" "Div" "Pop" "GetId" "ShootAt" "Min" "Swap" "Not" "DumpStack" "JumpZero" "PeekTo" "VecScale" "JumpLt" "VecRandom" "And" "StatPayload" "JumpEq" "Push" "VecLength" "Xor" "JumpGt" "Clone" "GetPos") t)

;;(regexp-opt '("LET" "CONST") t)

(defconst imprint-font-lock-keywords
  (list
   '("\\<\\(A\\(?:[dn]d\\)\\|Clone\\|D\\(?:iv\\|umpStack\\)\\|Get\\(?:Id\\|Pos\\)\\|Jump\\(?:Eq\\|Gt\\|Lt\\|Ne\\|Zero\\)?\\|M\\(?:ax\\|essage\\(?:P\\(?:eek\\|o\\(?:ll\\|p\\)\\|ush\\)\\|Se\\(?:nd\\|tChannel\\)\\)\\|in\\|o\\(?:d\\|veTo\\)\\|ul\\)\\|N\\(?:earestUnit\\|o\\(?:Op\\|t\\)\\)\\|Or\\|P\\(?:eekTo\\|op\\(?:To\\)?\\|ush\\(?:From\\)?\\)\\|Random\\|S\\(?:etColour\\|hootAt\\|tat\\(?:\\(?:I\\|Payloa\\)d\\)\\|ub\\|wap\\)\\|Vec\\(?:Add\\|Comp\\|Decomp\\|InvScale\\|Length\\|Random\\|S\\(?:cale\\|ub\\)\\)\\|Xor\\)\\>" . font-lock-function-name-face)
   '("\\<\\(\\(?:CONS\\|LE\\)T\\)\\>" . font-lock-keyword-face)
   ;;'("\\<\\(\\w*:\\)" . font-lock-string-face) ;Labels
   ;;'("\\<\\([a-z][a-z0-9-_]+\\)" . font-lock-variable-name-face)
   '("\\<\\([A-Z_-]+\\)\\>" . font-lock-constant-face)

   ))

(defvar imprint-mode-syntax-table
  (let ((imprint-mode-syntax-table (make-syntax-table)))
    (modify-syntax-entry ?_ "w" imprint-mode-syntax-table)
    (modify-syntax-entry ?- "w" imprint-mode-syntax-table)
    (modify-syntax-entry ?#  "< b" imprint-mode-syntax-table)
    (modify-syntax-entry ?\n "> b" imprint-mode-syntax-table)
    imprint-mode-syntax-table)
  "Syntax-table for imprint mode")

(defun imprint-mode ()
  "Major mode for editing Imprint bot assembler"
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table imprint-mode-syntax-table)
  (use-local-map imprint-mode-map)
  (set (make-local-variable 'font-lock-defaults) '(imprint-font-lock-keywords))
  (setq major-mode 'imprint-mode)
  (setq mode-name "Imprint")
  (setq comment-start "# ")
  (run-hooks 'imprint-mode-hook))

(provide 'imprint-mode)
