;;;; Default keymaps

(require 'evil-states)
(require 'evil-insert)
(require 'evil-operators)

(defmacro evil-redirect-digit-argument (map keys target)
  "Bind a special wrapper function which calles either `target' or `digit-argument'.
`digit-argument' is only called if a prefix-argument has already been started, otherwise `target' is called.
MAP    the keymap where the command should be bound
KEYS   the key-sequence to which the command should be bound
TARGET the command to call."
  (let ((wrapper (intern (concat "evil-digit-argument-or-"
                                 (symbol-name (eval target))))))
    `(progn
       (defun ,wrapper ()
         (interactive)
         (if current-prefix-arg
             (progn
               (setq this-command 'digit-argument)
               (call-interactively 'digit-argument))
           (setq this-command ,target)
           (call-interactively ,target)))
       (put ',wrapper 'evil-digit-argument-redirection t)
       (define-key ,map ,keys ',wrapper))))

(define-key evil-emacs-state-map "\C-z" 'evil-normal-state)

(define-key evil-normal-state-map "\C-z" 'evil-emacs-state)
(define-key evil-normal-state-map "a" 'evil-insert-after)
(define-key evil-normal-state-map "i" 'evil-insert-before)
(define-key evil-normal-state-map "O" 'evil-insert-above)
(define-key evil-normal-state-map "o" 'evil-insert-below)
(define-key evil-normal-state-map "x" 'delete-char)
(define-key evil-normal-state-map "r" 'evil-replace-char)
(define-key evil-normal-state-map "." 'evil-repeat)

(define-key evil-insert-state-map [escape] 'evil-normal-state)

;; "0" is a special command when called first
(evil-redirect-digit-argument evil-motion-state-map "0" 'evil-beginning-of-line)
(define-key evil-motion-state-map "1" 'digit-argument)
(define-key evil-motion-state-map "2" 'digit-argument)
(define-key evil-motion-state-map "3" 'digit-argument)
(define-key evil-motion-state-map "4" 'digit-argument)
(define-key evil-motion-state-map "5" 'digit-argument)
(define-key evil-motion-state-map "6" 'digit-argument)
(define-key evil-motion-state-map "7" 'digit-argument)
(define-key evil-motion-state-map "8" 'digit-argument)
(define-key evil-motion-state-map "9" 'digit-argument)

(define-key evil-motion-state-map "l" 'evil-forward-char)
(define-key evil-motion-state-map "h" 'evil-backward-char)
(define-key evil-motion-state-map "k" 'evil-previous-line)
(define-key evil-motion-state-map "j" 'evil-next-line)
(define-key evil-motion-state-map "H" 'evil-move-to-window-line)
(define-key evil-motion-state-map "M" 'evil-move-to-middle-window-line)
(define-key evil-motion-state-map "L" 'evil-move-to-last-window-line)
(define-key evil-motion-state-map "$" 'evil-end-of-line)
(define-key evil-motion-state-map "^" 'evil-first-non-blank)
(define-key evil-motion-state-map "g_" 'evil-last-non-blank)
(define-key evil-motion-state-map "gg" 'evil-move-to-first-non-blank-beg)
(define-key evil-motion-state-map "G" 'evil-move-to-first-non-blank-end)

(define-key evil-motion-state-map "gk" 'evil-previous-visual-line)
(define-key evil-motion-state-map "gj" 'evil-next-visual-line)
(define-key evil-motion-state-map "g0" 'evil-beginning-of-visual-line)
(define-key evil-motion-state-map "g^" 'evil-first-non-blank-of-visual-line)
(define-key evil-motion-state-map "g$" 'evil-end-of-visual-line)

(define-key evil-motion-state-map "w" 'evil-forward-word-begin)
(define-key evil-motion-state-map "e" 'evil-forward-word-end)
(define-key evil-motion-state-map "b" 'evil-backward-word-begin)
(define-key evil-motion-state-map "ge" 'evil-backward-word-end)
(define-key evil-motion-state-map "W" 'evil-forward-WORD-begin)
(define-key evil-motion-state-map "E" 'evil-forward-WORD-end)
(define-key evil-motion-state-map "B" 'evil-backward-WORD-begin)
(define-key evil-motion-state-map "gE" 'evil-backward-WORD-end)

(define-key evil-operator-state-map "d" 'evil-delete)
(define-key evil-operator-state-map "g?" 'evil-rot13)

(provide 'evil-maps)

;;; evil-maps.el ends here