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

;; Install use-package if necessary
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
      (
       append package-archives
	      '(("melpa" . "http://melpa.org/packages/")
		("marmalade" . "http://marmalade-repo.org/packages/")
		("gnu" . "http://elpa.gnu.org/packages/")
		;; ("org" . "http://orgmode.org/elpa/")
		;;("elpy" . "http://jorgenschaefer.github.io/packages/")
		)))

(package-initialize)

;; see https://github.com/gjstein/emacs.d/blob/master/init.el
;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
(package-install 'use-package))

;; Enable use-package
(eval-when-compile
(require 'use-package))

(require 'diminish) ;; if you use :diminish
(require 'bind-key) ;; if you use any :bind variant


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
(use-package rust-mode :ensure t :defer t)
(use-package toml-mode :ensure t :defer t)


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

(use-package powerline
  :ensure t
  :config
  (powerline-default-theme)
  (setq powerline-default-separator 'utf-8)
  )


;; see https://github.com/magnars/.emacs.d/blob/master/init.el
;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)


(provide 'init)
;;; init.el ends here
