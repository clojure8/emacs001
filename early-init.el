;; -*- coding: utf-8; lexical-binding: t; -*-


;; Defer garbage collection further back in the startup process
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(setq read-process-output-max (* 100 1024 1024))

;; Package initialize occurs automatically, before `user-init-file' is
;; loaded, but after `early-init-file'. We handle package
;; initialization, so we must prevent Emacs from doing it early!
(setq package-enable-at-startup nil)

;; Inhibit resizing frame
(setq frame-inhibit-implied-resize t)

;; Faster to disable these here (before they've been initialized)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(setq inhibit-splash-screen t)

(setq ns-auto-hide-menu-bar nil)
(setq frame-title-format nil)

(setq custom-file (make-temp-file "")) ; use a temp file as a placeholder
(setq custom-safe-themes t)            ; mark all themes as safe, since we can't persist now
;; (setq enable-local-variables :all)     ; fix =defvar= warnings

;; turn on highlight selection
(transient-mark-mode 1)

(unless (display-graphic-p)
  (menu-bar-mode -1))

(when (featurep 'ns)
  ;; 将 Command 键映射为 Meta 键

  (setq alpha-list '((100 100) (95 65) (85 55) (75 45) (65 35)))

  (defun loop-alpha ()
	(interactive)
	(let ((h (car alpha-list)))                ;; head value will set to
      ((lambda (a ab)
		 (set-frame-parameter (selected-frame) 'alpha (list a ab))
		 (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
		 ) (car h) (car (cdr h)))
      (setq alpha-list (cdr (append alpha-list (list h))))
      )
	)
  (loop-alpha)

  ;; (setq ns-command-modifier 'meta)
  ;; ;; 将 Control 键映射为 Command 键
  ;; (setq ns-control-modifier 'super)

  ;; 去除titlebar
  ;; (add-to-list 'default-frame-alist '(undecorated . t))

  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  ;; (add-to-list 'default-frame-alist '(ns-appearance . dark)) ;; {light, dark}
  ;; (add-hook 'after-load-theme-hook
  ;;           (lambda ()
  ;; 			  (let ((bg (frame-parameter nil 'background-mode)))
  ;;               (set-frame-parameter nil 'ns-appearance bg)
  ;;               (setcdr (assq 'ns-appearance default-frame-alist) bg))))

  ;; 设置初始化启动的窗口大小和位置
  (add-to-list 'default-frame-alist '(width . 152))
  (add-to-list 'default-frame-alist '(height . 59))
  (add-to-list 'default-frame-alist '(top . 20))
  (add-to-list 'default-frame-alist '(left . 214))

  ;; 启动自动最大化
  ;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
  )
