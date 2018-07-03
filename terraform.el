(use-package terraform-mode
  :ensure t
  :defer t
  :init
  (use-package company-terraform :ensure t :defer t)
  :config
  (add-hook 'go-mode-hook '(lambda () (push 'company-terraform company-backends)))
  )
