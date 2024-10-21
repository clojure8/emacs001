;; -*- coding: utf-8; lexical-binding: t; -*-

;; init package manager
(eval-and-compile
  (setq package-check-signature nil)
  (customize-set-variable
   'package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                       ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                       ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
		               ("gnu-devel" . "https://elpa.gnu.org/devel")))
  (package-initialize)
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
	(package-install 'use-package))
  (require 'use-package-ensure)
  (setq use-package-always-ensure nil)
  (setq use-package-compute-statistics t)
  (use-package foo :no-require t :ensure nil))

(defun my-log (msg)
  (message "[%s] %s" (current-time-string) msg))

(defmacro modules (&rest modules)
  `(progn
     ,@(mapcar
        (lambda (m)
          (let* ((module (if (symbolp m) (list m) m))
                 (name (car module))
                 (options (cdr module))
                 (str-name (symbol-name name))
		         (dir (concat "modules/" (if (plist-get options :dir) (symbol-name (plist-get options :dir)) ""))))
            `(use-package ,name
               :load-path ,dir
               ,@(cl-loop for (key val) on options by 'cddr
                          if (member key use-package-keywords)
                          collect key and collect val)
               :init
               (my-log (format "Module %s loading." ,str-name))
               :config
               (my-log (format "Module %s loaded." ,str-name)))))
        modules)))

;; modules config 
(modules
 init-pm
 init-base
 init-minibuffer
 init-git
 init-tools
 init-text
 init-spell
 (init-modeline :dir ui )
 (init-tabbar :dir ui)
 (init-theme :dir ui)
 init-evil
 (init-osx :when (memq window-system '(mac ns)))
 (init-shell :commands (eshell shell vterm))
 ;; TODO org/window/session/lang ...
 init-org
 init-edit
 init-prog
 init-layout
 init-lsp-bridge
 )

