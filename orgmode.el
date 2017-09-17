
(use-package org
  :ensure t
  :defer t
  :bind ("C-c c" . org-capture)
  :bind ("C-c l" . org-store-link)
  :bind ("C-c a" . org-agenda)

  :config
  (setq org-directory "~/org"
        org-agenda-files (list "~/org/notes.org"
                               "~/org/work.org")

        org-default-notes-file (concat org-directory "/notes.org")
        org-capture-templates (quote (
                                      ("t" "Tasks" entry (file+headline "~/org/notes.org" "Tasks") "* TODO %?")
                                      ("y" "Tasks" entry (file "~/org/notes.org")
                                       "************************ TODO %?\n %U")
                                      ("w" "work notes" entry (file+weektree "~/org/work.org")
                                       "* %?\nEntered on %U\n  %i")
                                      ("l" "work log" entry (file+datetree "~/org/worklog.org")
                                       "* DONE %?\nEntered on %U\n  %i")
                                      )
                               )
        )
  )
