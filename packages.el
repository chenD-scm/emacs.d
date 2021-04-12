(require 'package)

(defconst emacs-d
  (file-name-directory
    (file-chase-links load-file-name)))

;; Don't use any packages from GNU ELPA, for minimize dependency on 3rd party web site.
(setq package-archives
      '(
        ;; uncomment below line if you need use GNU ELPA
        ;; ("gnu" . "https://elpa.gnu.org/packages/")
        ;; ("melpa" . "https://melpa.org/packages/")
        ;; ("melpa-stable" . "https://stable.melpa.org/packages/")

        ;; Use either 163 or tsinghua mirror repository when official melpa
        ;; is slow or shutdown.

        ;; {{ Option 1: 163 mirror repository:
        ;; ("gnu" . "https://mirrors.163.com/elpa/gnu/")
        ("melpa" . "https://mirrors.163.com/elpa/melpa/")
        ("melpa-stable" . "https://mirrors.163.com/elpa/melpa-stable/")
        ;; }}

        ;; ;; {{ Option 2: tsinghua mirror repository
        ;; ;; @see https://mirror.tuna.tsinghua.edu.cn/help/elpa/ on usage:
        ;; ;; ("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ;; ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ;; ("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")
        ;; }}
        ))

(defconst my-packages
  '(eaf 
    eclipse-theme
    evil
    (evil-escape :fetcher github :repo "syl20bnr/evil-escape" :files ("*")) ;; quelpa install it result in error"
    evil-exchange
    evil-find-char-pinyin
    evil-mark-replace
    evil-matchit
    evil-nerd-commenter
    evil-surround
    evil-visualstart
    general
    )
  "List of packages that I use.")

(defun quelpa-install-packages (packages)
  (setq quelpa-dir
    (expand-file-name "quelpa" emacs-d))

  (unless (package-installed-p 'quelpa)
    (with-temp-buffer
      (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
      (eval-buffer)
      (quelpa-self-upgrade)))

  (dolist (package packages)
    (quelpa package)))

(quelpa-install-packages my-packages)

