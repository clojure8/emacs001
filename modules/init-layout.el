;;; init-layout.el --- The necessary settings -*- lexical-binding: t -*-

(use-package persist
  :ensure t)

(use-package activities
  :load-path "elisp/activities/"
  :ensure nil
  :init
  (require 'activities)
  (require 'activities-tabs)
  (require 'activities-list)
  (activities-mode)
  (activities-tabs-mode)
  (setq edebug-inhibit-emacs-lisp-mode-bindings t)
  :bind
  (("C-x C-a C-n" . activities-new)
   ("C-x C-a C-d" . activities-define)
   ("C-x C-a C-a" . activities-resume)
   ("C-x C-a C-s" . activities-suspend)
   ("C-x C-a C-k" . activities-kill)
   ("C-x C-a RET" . activities-switch)
   ("C-x C-a b" . activities-switch-buffer)
   ("C-x C-a g" . activities-revert)
   ("C-x C-a l" . activities-list)))


(provide 'init-layout)


