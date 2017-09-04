;; if it does not work, try
;; go get -u github.com/nsf/gocode
;; M-x shell command gocode status

(use-package go-mode
  :ensure t
  :defer t
  :init
  (use-package company-go :ensure t :defer t)
  (use-package go-guru :ensure t  :defer t )
  (use-package go-errcheck :ensure t  :defer t )
  :config
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)
  (add-hook 'go-mode-hook '(lambda () (push 'company-go company-backends)))
  ;; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump)
  )
