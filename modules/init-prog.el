;;; init-prog.el --- The necessary settings -*- lexical-binding: t -*-

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1))

(defun my/dashboard-open-project-and-treemacs (project-root)
  "Open treemacs for the given PROJECT-ROOT and open recent files."
  (interactive)
  ;; 打开 treemacs 并跳转到项目根目录
  (treemacs-add-and-display-current-project)
  ;; 尝试从 recentf 列表中找到与该项目相关的文件并打开
  (let ((recent-files (seq-filter
                       (lambda (file)
                         (string-prefix-p project-root file))
                       recentf-list)))
    (if recent-files
        ;; 遍历并打开与项目相关的所有文件
        (dolist (file recent-files)
          (find-file file))
      (message "No recent files found for project %s" project-root))))

(use-package dashboard
  :ensure t
  :after projectile
  :config
  (setq dashboard-items '((recents   . 5)
                          (projects  . 5)))
  (setq dashboard-item-shortcuts '((recents   . "r")
                                   (projects  . "p")))
  (setq dashboard-projects-backend 'projectile) ;; 确保 dashboard 使用 projectile 获取项目
  (setq dashboard-projects-switch-function 'my/dashboard-open-project-and-treemacs)
  (dashboard-setup-startup-hook))

;;(use-package eglot :ensure t)
(use-package citre :ensure t
  :config
  (require 'citre-config))

(use-package apheleia
  :ensure t
  :config
  (apheleia-global-mode +1))

(provide 'init-prog)
