(use-package rust-mode :ensure t :defer t)
(use-package flycheck-rust  :ensure t :defer t
  :init
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
  )
