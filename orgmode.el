


;; see https://lists.gnu.org/archive/html/emacs-orgmode/2008-08/msg00106.html
;;     https://lists.gnu.org/archive/html/emacs-orgmode/2008-08/msg00139.html
;; Don't convert _ and ^ unless surrounded by braces
;; #+OPTIONS:   ^:{} # in file
;; or
;; (setq org-export-with-sub-superscripts '{})


(use-package org
  :ensure t
  :defer t
  :bind (("C-c c" . org-capture)
         ("C-c l" . org-store-link)
         ("C-c a" . org-agenda))

  :config
  (setq org-directory "~/org"
        org-agenda-files (list "~/org/notes.org"
                               "~/org/work.org")
        ;; Don't convert _ and ^ unless surrounded by braces
        org-export-with-sub-superscripts '{}
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
