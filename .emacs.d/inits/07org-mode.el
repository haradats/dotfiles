;;; 07org-mode.el --- 07org-mode.el
;;; Commentary:
;;; Code:
;;(setq debug-on-error t)

(require 'org)
(require 'org-tempo)

(require 'org-habit)
(add-to-list 'org-modules 'org-habit)

(setq org-log-done 'time)
(setq org-use-speed-commands t)
(setq org-src-tab-acts-natively t)
(setq org-src-fontify-natively t)
(setq org-agenda-files '("~/backup/emacs/org/task.org"))
(setq calendar-holidays nil)
(setq org-clock-clocked-in-display 'frame-title)

(setq org-agenda-files
      '("~/org/"))
(setq org-agenda-start-on-weekday 0)
(setq org-agenda-include-diary t)
(setq org-use-fast-todo-selection t)
(setq org-blank-before-new-entry (quote ((heading) (plain-list-item))))
(setq org-enforce-todo-dependencies t)
(setq org-log-redeadline (quote time))
(setq org-log-reschedule (quote time))

(add-to-list 'auto-mode-alist
	     '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

(bind-key "C-c a" 'org-agenda)
(bind-key "C-c c" 'org-capture)
(bind-key "C-c l" 'org-store-link)

(with-eval-after-load "org"
  (define-key org-mode-map (kbd "C-'") #'hydra-pinky/body))

(setq org-capture-templates
      '(("e" "Experiment" entry (file+headline "~/backup/emacs/org/experiment.org" "Experiment")
	 "* %? %U %i\n
#+BEGIN_SRC emacs-lisp

#+END_SRC")
	("i" "Idea" entry (file+headline "~/backup/emacs/org/idea.org" "Idea")
	 "* %? %U %i")
	("r" "Remember" entry (file+headline "~/backup/emacs/org/remember.org" "Remember")
	 "* %? %U %i")
	("m" "Memo" entry (file+headline "~/backup/emacs/org/memo.org" "Memo")
	 "* %? %U %i")
	("t" "Task" entry (file+headline "~/backup/emacs/org/task.org" "Task")
	 "** TODO %? \n   SCHEDULED: %^t \n")))

(setq org-capture-templates
      (quote
       (("j" "Journal" entry (file+datetree "~/org/journal.org")
	 "* %? %U %i")
	("n" "Note" entry (file+headline "~/org/note.org")
	 "* %? %U %i")
	("t" "Todo" entry (file+headline "~/org/todo.org")))))
(setq org-agenda-time-grid
      (quote
       ((today remove-match)
	(900 1200 1500 1800 2100)
	"......" "----------------")))

(setq org-refile-targets
      (quote (("~/backup/emacs/org/archives.org" :level . 1)
	      ("~/backup/emacs/org/remember.org" :level . 1)
	      ("~/backup/emacs/org/memo.org" :level . 1)
	      ("~/backup/emacs/org/task.org" :level . 1))))

(defun kanban-rename ()
  "Rotate kanban file."
  (interactive)
  (rename-file "~/backup/kanban/kanban.org"
	       (expand-file-name
		(read-from-minibuffer "Rename: " `(".org" . 1) nil nil nil)
		"~/backup/kanban")
	       1))

;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; 07org-mode.el ends here
