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
  (treemacs-find-file)
  ;; 尝试从 recentf 列表中找到与该项目相关的文件并打开
  (let ((recent-files (seq-filter
                       (lambda (file)
                         (string-prefix-p project-root file))
                       recentf-list)))
    (if recent-files
        (find-file (car recent-files))  ;; 打开最近的文件
      (message "No recent files found for project %s" project-root))))

(use-package dashboard
  :ensure t
  :after projectile
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-item-shortcuts '((recents   . "r")
                                 (bookmarks . "m")
                                 (projects  . "p")
                                 (agenda    . "a")
                                 (registers . "e")))
  (setq dashboard-projects-backend 'projectile) ;; 确保 dashboard 使用 projectile 获取项目
  (setq dashboard-projects-switch-function 'my/dashboard-open-project-and-treemacs)
  )


(provide 'init-prog)
