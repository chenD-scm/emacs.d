;; -*- coding: utf-8; lexical-binding: t; -*-

(defun my-initialize-package ()
  ;; optimization, no need to activate all the packages so early
  (cond
   (*emacs27*
    ;; you need run `M-x package-quickstart-refresh' at least once
    ;; to generate file "package-quickstart.el'.
    ;; It contains the `autoload' statements for all packages.
    ;; Please note once this file is created, you can't automatically
    ;; install missing package any more
    ;; You also need need re-generate this file if any package is upgraded.
    (setq package-quickstart t)

    ;; esup need call `package-initialize'
    ;; @see https://github.com/jschaf/esup/issues/84
    (when (or (featurep 'esup-child)
              (fboundp 'profile-dotemacs)
              (not (file-exists-p (concat my-emacs-d "elpa")))
              (my-vc-merge-p)
              noninteractive)
      (package-initialize)))
   (t
    ;; @see https://www.gnu.org/software/emacs/news/NEWS.27.1
    (package-initialize))))

(my-initialize-package)

;; Add temp
(if t
    (package-initialize))

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
  '((eaf :fetcher github :repo  "manateelazycat/emacs-application-framework" :files ("*"))
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
  (unless (package-installed-p 'quelpa)
    (with-temp-buffer
      (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
      (eval-buffer)
      (quelpa-self-upgrade)))

  (dolist (package packages)
    (quelpa package)))

(quelpa-install-packages my-packages)

(provide 'init-quelpa)
