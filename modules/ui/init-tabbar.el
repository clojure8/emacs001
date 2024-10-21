;; -*- coding: utf-8; lexical-binding: t; -*-
;;; code:

;; (use-package tabspaces
;;   ;; use this next line only if you also use straight, otherwise ignore it.
;;   :straight (:type git :host github :repo "mclear-tools/tabspaces")
;;   :hook (after-init . tabspaces-mode) ;; use this only if you want the minor-mode loaded at startup.
;;   :commands (tabspaces-switch-or-create-workspace
;;              tabspaces-open-or-create-project-and-workspace)
;;   :custom
;;   (tabspaces-use-filtered-buffers-as-default t)
;;   (tabspaces-default-tab "Default")
;;   (tabspaces-remove-to-default t)
;;   (tabspaces-include-buffers '("*scratch*"))
;;   (tabspaces-initialize-project-with-todo t)
;;   (tabspaces-todo-file-name "project-todo.org")
;;   ;; sessions
;;   (tabspaces-session t)
;;   (tabspaces-session-auto-restore t))

;; 修复cursor被evil-mode重置的问题。

;; (use-package sort-tab
;;   :load-path "~/elisp/sort-tab"
;;   :custom
;;   (sort-tab-height 40)
;;   :config
;;   )


;;(use-package awesome-tab
;;  :load-path "~/elisp/awesome-tab/"
;;  :custom
;;  (awesome-tab-height 114)
;;  (awesome-tab-active-bar-height 23)
;;  :config
;;  (defun awesome-tab-buffer-groups ()
;;	(list (cond
;;		   ((string-equal "*" (substring (buffer-name) 0 1))
;;			"Emacs")
;;		   ((or (s-starts-with? "magit" (buffer-name))
;;				(s-equals? "COMMIT_EDITMSG" (buffer-name)))
;;			"magit")
;;		   ((or (s-starts-with? "*vter" (buffer-name))
;;				(s-equals? "*vterm*" (buffer-name)))
;;			"magit")
;;		   (t
;;			"others"))))
;;  ;; (awesome-tab-mode t)
;;  )
(use-package vim-tab-bar
  :ensure t
  :hook
  (after-init . vim-tab-bar-mode)
  :config
  (setq vim-tab-bar-show-groups t))

(provide 'init-tabbar)
