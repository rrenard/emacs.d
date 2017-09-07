;;; init.el --- init stuff
;;; Commentary:
;;; Code:

;; see also
;; https://www.lunaryorn.com/posts/my-emacs-configuration-with-use-package.html
;; https://github.com/gjstein/emacs.d/blob/master/init.el
;; https://github.com/purcell/emacs.d
;; https://github.com/magnars/.emacs.d/blob/master/init.el
;; https://github.com/gozes/.emacs.d/blob/master/config.org
;; https://github.com/mbriggs/.emacs.d
;; https://utcc.utoronto.ca/~cks/space/blog/programming/GoGocodeEmacsAutocompleteII


;; See https://github.com/jwiegley/use-package/issues/219 xuchunyang's comment

;; Setup package.el
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ;; ("marmalade" . "https://marmalade-repo.org/packages/")
                         ;; ("elpy" . "http://jorgenschaefer.github.io/packages/")
                         ;; ("org" . "http://orgmode.org/elpa/")
                         ))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
(package-install 'use-package))

;; Enable use-package
(eval-when-compile
(require 'use-package))

(require 'diminish) ;; if you use :diminish
(require 'bind-key) ;; if you use any :bind variant


(require 'server)
(unless (server-running-p)
  (server-start))

;; server socket dir
(setq server-socket-dir (format "~/tmp/emacs%d" (user-uid)))

;; Keep my working directories clean please, thanks
(setq backup-directory-alist (quote ((".*" . "~/tmp/emacs/backups/"))))

(prefer-coding-system 'utf-8)
(setq inhibit-startup-message t)

;; type "y"/"n" instead of "yes"/"no"
(fset 'yes-or-no-p 'y-or-n-p)

;; no toolbar, no scrollbar thanks
(tool-bar-mode nil)
(set-scroll-bar-mode nil)

;; Disable menu bars, etc.
(if window-system (scroll-bar-mode -1))
(tool-bar-mode -1)
;;(menu-bar-mode -1)

;; syntax highlight
(setq font-lock-mode t)

;; line highlighted
(global-hl-line-mode 1)

(show-paren-mode t)

(setq-default show-trailing-whitespace t)
(setq-default default-indicate-empty-lines t)
(setq-default indent-tabs-mode nil)

(setq line-number-mode t)
(setq column-number-mode t)

(setq display-time-24hr-format t)
(display-time-mode t)

(global-set-key (kbd "<f2>") 'whitespace-mode)
(global-set-key (kbd "<f3>") 'linum-mode)
(global-set-key (kbd "C-x C-b") 'bs-show)

;; see https://github.com/magnars/.emacs.d/blob/master/settings/key-bindings.el
(windmove-default-keybindings) ;; Shift+direction

; default tramp to ssh instead of scp
(setq tramp-default-method "ssh")

(load-file (expand-file-name "magit.el" user-emacs-directory))

(use-package markdown-mode
  :ensure t
  :defer t
  :mode (
         ("\\.text\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.txt\\'" . markdown-mode)
         )
  )

(use-package yaml-mode
  :ensure t
  :defer t
  ;; :config
  ;; (add-hook 'yaml-mode-hook
  ;;           (lambda () (local-set-key (kbd "C-c >") 'indent-tools-hydra/body)))
  )


(use-package dockerfile-mode :ensure t :defer t)
(use-package rpm-spec-mode :ensure t :defer t)

(load-file (expand-file-name "rust.el" user-emacs-directory))

(use-package toml-mode :ensure t :defer t)
(use-package cmake-mode :ensure t :defer t)
(use-package puppet-mode :ensure t :defer t)
(use-package powershell :ensure t :defer t)

;; https://github.com/dajva/rg.el
(use-package rg
  :ensure t
  :defer t
  :bind ("M-s" . rg)
  )

;; see https://github.com/gjstein/emacs.d/blob/master/config/init-10-face.el
(use-package monokai-theme
  :ensure t
  :init (load-theme 'monokai t)
  )

(use-package groovy-mode
  :ensure t
  :defer t
  :config
  (add-hook 'groovy-mode-hook
            (lambda ()
              (setq c-basic-offset 4)
              ;; http://stackoverflow.com/questions/17822969/indentation-of-groovy-style-method-parameters-in-emacs
              (c-set-offset 'label 4))
            )
  )

;; https://keramida.wordpress.com/2008/08/08/tweaking-shell-script-indentation-in-gnu-emacs/
;; http://emacs.stackexchange.com/questions/24719/set-indentation-for-shell-script-function
(add-hook 'sh-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq sh-indentation 2)
            (setq sh-basic-offset 2)))


(use-package yasnippet
  :ensure t
  :defer t
  :config (yas-global-mode t)
  )

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  )

(use-package company
  :ensure t
  :config
  (global-company-mode)
  (push 'company-ansible company-backends)
  (setq company-dabbrev-downcase nil
        company-dabbrev-ignore-case nil)
  )

(use-package company-ansible :ensure t )

(load-file (expand-file-name "go-lang.el" user-emacs-directory))

(load-file (expand-file-name "powerline.el" user-emacs-directory))

(use-package nov
  :ensure t
  :defer t
  :init
  (push '("\\.epub\\'" . nov-mode) auto-mode-alist)
  )

;; see https://github.com/magnars/.emacs.d/blob/master/init.el
;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)


(provide 'init)
;;; init.el ends here
