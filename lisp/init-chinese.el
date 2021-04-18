;; -*- coding: utf-8; lexical-binding: t; -*-
(require 'pyim)
(require 'pyim-basedict)

;; {{ make IME compatible with evil-mode
(defun evil-toggle-input-method ()
  "When input method is on, goto `evil-insert-state'."
  (interactive)

  ;; load IME when needed, less memory footprint
  (my-ensure 'pyim)

  ;; some guys don't use evil-mode at all
  (cond
   ((and (boundp 'evil-mode) evil-mode)
    ;; evil-mode
    (cond
     ((eq evil-state 'insert)
      (toggle-input-method))
     (t
      (evil-insert-state)
      (unless current-input-method
	(toggle-input-method))))
    (cond
     (current-input-method
      ;; evil-escape and pyim may conflict
      ;; @see https://github.com/redguardtoo/emacs.d/issues/629
      (evil-escape-mode -1)
      (message "IME on!"))
     (t
      (evil-escape-mode 1)
      (message "IME off!"))))
   (t
    ;; Not evil-mode
    (toggle-input-method))))

(defun my-evil-insert-state-hack (orig-func &rest args)
  "Notify user IME status."
  (apply orig-func args)
  (if current-imput-method (message "IME on!")))
(advice-add 'evil-insert-state :around #'my-evil-insert-state-hack)

(global-set-key (kbd "C-\\") 'evil-toggle-input-method)
;; }}

     

