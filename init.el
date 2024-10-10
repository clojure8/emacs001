(eval-and-compile
  (setq package-check-signature nil)
  (customize-set-variable
   'package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                       ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                       ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
					   ("gnu-devel" . "https://elpa.gnu.org/devel")
					   ))
  (package-initialize)
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
	(package-install 'use-package))
  (require 'use-package-ensure)
  (setq use-package-always-ensure t)
  (setq use-package-compute-statistics t))

(use-package no-littering
  :demand
  :config
  (with-eval-after-load 'recentf
	(setq my/etc-directory (expand-file-name "var/config/" user-emacs-directory))
	(setq my/var-directory (expand-file-name "var/data/" user-emacs-directory))
	(add-to-list 'recentf-exclude (expand-file-name "etc/elpa" user-emacs-directory))
	(add-to-list 'recentf-exclude my/etc-directory)
	(add-to-list 'recentf-exclude my/var-directory)))

(add-hook 'after-init-hook
		  (lambda ()
			;; write over selected text on input... like all modern editors do
			(delete-selection-mode t)
			(global-hl-line-mode +1)
			(recentf-mode +1)))

(setq auto-save-file-name-transforms `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
(setq custom-file (no-littering-expand-etc-file-name "custom.el"))
(defvar temporary-file-directory "~/.emacs.d/var/tmp")
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(use-package esup :defer t)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq cursor-in-non-selected-windows nil)

;; Helper function to log messages
(defun my-log (msg)
  (message "[%s] %s" (current-time-string) msg))

(defmacro modules (&rest modules)
  `(progn
     ,@(mapcar
        (lambda (module)
          (let* ((name (car module))
                 (options (cdr module))
                 (str-name (symbol-name name)))
            ;; 构建use-package关键字的统一处理
            `(use-package ,name
               :load-path "modules/"
               ,@(cl-loop for (key val) on options by 'cddr
                          if (member key use-package-keywords)
                          collect key and collect val)
               :init
        (my-log (format "Module %s loading." ,str-name))
        :config
        (my-log (format "Module %s loaded." ,str-name)))))
        modules)
     ,(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds" (float-time (time-subtract after-init-time before-init-time)))
                     gcs-done)))
     )
  )

(modules
 (init-c :hook (c-mode))
 (init-modeline)
 (init-tabbar)
 (init-theme)
 )
