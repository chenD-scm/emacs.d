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

;; {{ start dictionary lookup
(require 'sdcv)
;; # wordnet English => English
;;  https://src.fedoraproject.org/repo/pkgs/stardict-dic/stardict-dictd_www.dict.org_wn-2.4.2.tar.bz2/f164dcb24b1084e1cfa2b1cb63d590e6/stardict-dictd_www.dict.org_wn-2.4.2.tar.bz2
;; # Langdao Chinese => English
;; https://src.fedoraproject.org/repo/pkgs/stardict-dic/stardict-langdao-ec-gb-2.4.2.tar.bz2/41a71f5b3952709746dd7e52cf155b8b/stardict-langdao-ec-gb-2.4.2.tar.bz2
;;
(setq sdcv-dictionary-data-dir ;; setup directory of stardict dictionary
      (concat emacs-d "sdcv-dict"))
(setq sdcv-dictionary-simple-list ;; setup dictionary list for simple search
      '("郎道英汉字典5.0"))
(setq sdcv-dictionary-complete-list ;; setup dictionary list for complete search
      '("WordNet"))
(setq sdcv-tooltip-timeout 60)
;; }}

(provide 'init-misc)
