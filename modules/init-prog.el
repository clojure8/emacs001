;;; init-prog.el --- The necessary settings -*- lexical-binding: t -*-

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1))

(use-package prsp-mode
  :ensure t
  :config
  (prsp-mode +1))

(provide 'init-prog)
