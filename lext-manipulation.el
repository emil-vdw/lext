;;; lext-manipulation.el --- Convenience functions for lisp form manipulations -*- lexical-binding: t; -*-

;; Author: Emil van der Westhuizen <vdwemil@protonmail.com>
;; Maintainer: Emil van der Westhuizen <vdwemil@protonmail.com>
;; Created:  4 August 2024
;; Version: 0.1
;; Package-Requires: ((emacs "29.3"))
;; Homepage: https://www.github.com/emil-vdw/lisp-extensions
;; Keywords: languages, tools, convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;;

;;; Code:
(require 'thingatpt)

(defun lext-clone-node ()
  "Clone the node at point."
  (interactive)
  (mark-sexp)
  (call-interactively 'kill-ring-save)
  (yank)
  (insert " "))

(defun lext--start-of-sexp ()
  "Like `thing-at-point--beginning-of-sexp' but favors subsequent sexps."
  ;; We treat the start of an sexp, like a \( as a valid starting
  ;; point for an sexp. `thing-at-point--beginning-of-sexp' will jump
  ;; to the stat of the previous sexp.
  (unless
      (save-excursion
        ;; We are already at the start of an s-expression.
        (equal (point)
               (ignore-errors (forward-sexp)
                              (backward-sexp)
                              (point))))
    (thing-at-point--beginning-of-sexp)))

(defun lext-drag-sexp-back ()
  "Drag the sexp back one position in the list."
  (interactive)
  (lext--start-of-sexp)
  (call-interactively 'transpose-sexps)
  (backward-sexp)
  (backward-sexp))

(defun lext-drag-sexp-forward ()
  "Drag the sexp forward one position in the list."
  (interactive)
  (lext--start-of-sexp)
  (forward-sexp)
  (transpose-sexps 1)
  (save-excursion
    (backward-sexp)
    (backward-sexp)
    (forward-sexp)))

(provide 'lext-manipulation)
;;; lext-manipulation.el ends here
