(require 'auto-save)
(defvar my-auto-save-exclude-major-mode-list
  '(message-mode)
  "The major modes where auto-save is disabled.")

;; {{ auto-save.el
(defun my-check-major-mode-for-auto-save (file)
  "Check current major mode of FILE for auto save."
  (ignore file)
  (memq major-mode my-auto-save-exclude-major-mode-list))

(with-eval-after-load 'auto-save
  (setq make-backup-files nil)
  (setq auto-save-default nil)
  (push 'my-file-too-big-p auto-save-exclude)
  (push 'my-check-major-mode-for-auto-save auto-save-exclude)
  (setq auto-save-idle 2) ; 2 seconds
  (setq auto-save-slient t))

(provide 'init-misc)
