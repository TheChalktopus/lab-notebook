;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "~/Sites/math-site/.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)



(add-to-list 'org-agenda-files "~/orgs/obligations.org")
(add-to-list 'org-agenda-files "~/lab-files/lab-journal/")
(add-to-list 'org-agenda-files "~/roam/lab-files-org/")
(setq org-todo-keywords
      '((sequence "TODO(t)" "INPROG(i)" "NEXT(n)" "|" "DONE(d)" "CANCELLED(x)" )
	(sequence  "CONSUME(c)" "|")
	))
(setq org-agenda-sorting-strategy
      '(
	(agenda habit-down time-up priority-up category-keep)
	(todo priority-down category-keep tag-up)
	(tags priority-down category-keep)
	(tags-todo priority-down category-keep)
	(search priority-up category-keep)
	)
      )
(setq org-agenda-custom-commands
	  '(("d" "Lab Tasks"
         (
          (tags-todo "lab"  ((org-agenda-sorting-strategy '(priority-down)))))
         ((org-agenda-remove-tags t))
         ("~/roam/lab-files-org/todo.org")))
	  )
(defun my-org-agenda-preserve-first-n-lines (n)
  "Overwrite an Org agenda file while preserving the first N lines."
  (let ((output-file "~/roam/lab-files-org/todo.org")  ;; Change this to your desired file
        preserved-lines)

    ;; Read and store the first N lines
    (when (file-exists-p output-file)
      (with-temp-buffer
        (insert-file-contents output-file)
        (goto-char (point-min))
        (dotimes (_ n)
          (when (not (eobp)) ;; Stop if the file has fewer than N lines
            (push (buffer-substring-no-properties (line-beginning-position) (line-end-position)) preserved-lines)
            (forward-line 1)))))

    ;; Write the preserved lines and new agenda content
    (with-temp-file output-file
      ;; Insert preserved lines first
      (dolist (line (reverse preserved-lines))
        (insert line "\n"))
      (insert "\n") ;; Separate preserved lines from the agenda
      ;; Insert the new agenda content
      (org-agenda-write (buffer-name))))

  (message "Agenda written to %s, preserving the first %d lines." output-file n))

;; Example: Preserve the first 5 lines
(my-org-agenda-preserve-first-n-lines 5)

(org-store-agenda-views)
;; Customize the HTML output
;(setq org-html-validation-link nil            ;; Don't show validation link
;      org-html-head-include-scripts nil       ;; Use our own scripts
;      org-html-head-include-default-style nil ;; Use our own styles
;      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :recursive t
             :base-directory "~/roam/lab-files-org/"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "~/Sites/lab-notebook/docs/"
	     :body-only t
	     :with-toc nil)           
       ))
(setq org-export-with-section-numbers nil)
;; Generate the site output
(org-publish-all t)



(message "Build complete!")
