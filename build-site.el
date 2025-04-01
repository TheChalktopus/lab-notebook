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
(add-to-list 'org-agenda-files "~/roam/lab-files-org/_posts/")
(add-to-list 'org-agenda-files "~/roam/lab-files-org/_projects/")
(setq org-todo-keywords
      '((sequence "TODO(t)" "INPROG(i)" "NEXT(n)" "|" "DONE(d)" "CANCELLED(x)" )
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
;; Customize the HTML output
;(setq org-html-validation-link nil            ;; Don't show validation link
;      org-html-head-include-scripts nil       ;; Use our own scripts
;      org-html-head-include-default-style nil ;; Use our own styles
;      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")

;; Define the publishing project
(setq org-html-inline-images t)
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
(setq org-export-with-broken-links 'mark)
;; Generate the site output
(org-publish-all t)
(org-store-agenda-views)


(message "Build complete!")
