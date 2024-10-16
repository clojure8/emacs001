;; -*- coding: utf-8; lexical-binding: t; -*-

;;; code:

;; (setq my-theme 'doom-dracula)
;; (setq my-theme 'modus-operandi)
;; (setq my-theme 'modus-vivendi)
;;(setq my-theme 'doom-xcode)
;; (setq my-theme 'doom-monokai-pro)
;; (setq my-theme 'doom-one-light)
;; (setq my-theme 'doom-one)
;; (setq my-theme 'leuven-dark)
;; (setq my-theme 'doom-plain)
;; (setq my-theme 'kaolin-light)
;; (defvar my-theme nil "my theme")
;; (setq my-theme 'doom-solarized-light)

(use-package doom-themes
  :ensure t
  :custom-face
  (magit-header-line ((t (:inherit 'mode-line))))
  :config
  ;; Global settings (defaults)
  ;; (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
  ;;       doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; (doom-themes-org-config)
  ;; (setq doom-themes-treemacs-theme "doom-colors")
  ;; (doom-themes-treemacs-config)
  )

(use-package solarized-theme :ensure t :defer  t)
(use-package dracula-theme :ensure t :defer  t)
(use-package chocolate-theme :ensure t :defer  t)
(use-package tron-legacy-theme :ensure t :defer  t)
(use-package sublime-themes :ensure t :defer  t)
(use-package kaolin-themes :ensure t :defer  t)
(use-package modus-themes :ensure t :defer  t)
(use-package tok-theme :ensure t :defer  t)

(use-package ef-themes
  :ensure t
  :bind ("C-c t" . ef-themes-toggle)
  :init
  ;; set two specific themes and switch between them
  (setq ef-themes-to-toggle '(ef-summer ef-winter))
  ;; set org headings and function syntax
  (setq ef-themes-headings
        '((0 . (bold 1))
          (1 . (bold 1))
          (2 . (rainbow bold 1))
          (3 . (rainbow bold 1))
          (4 . (rainbow bold 1))
          (t . (rainbow bold 1))))
  (setq ef-themes-region '(intense no-extend neutral))
  ;; Disable all other themes to avoid awkward blending:
  (mapc #'disable-theme custom-enabled-themes)

  ;; Load the theme of choice:
  ;; The themes we provide are recorded in the `ef-themes-dark-themes',
  ;; `ef-themes-light-themes'.

  ;; 如果你不喜欢随机主题，也可以直接固定选择一个主题，如下：
  ;; (ef-themes-select 'dracula)

  ;; 随机挑选一款主题，如果是命令行打开Emacs，则随机挑选一款黑色主题
  (if (display-graphic-p)
       (ef-themes-load-random)
     (ef-themes-load-random 'light))

  :config
  ;; auto change theme, aligning with system themes.
  (defun my/apply-theme (appearance)
    "Load theme, taking current system APPEARANCE into consideration."
    (mapc #'disable-theme custom-enabled-themes)
    (pcase appearance
      ('light (if (display-graphic-p) (ef-themes-load-random 'dark) (ef-themes-load-random 'dark)))
      ('dark (ef-themes-load-random 'dark))))

  ;; (if (eq system-type 'darwin)
  ;;     ;; only for emacs-plus
  ;;     (add-hook 'ns-system-appearance-change-functions #'my/apply-theme)
  ;;   (ef-themes-select 'ef-summer)
  ;;   )
  )


;; 中英文中文字体设置
(defun set-font (english chinese english-size chinese-size)
  (set-face-attribute 'default nil
					  :font (format   "%s:pixelsize=%d"  english english-size))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font) charset
					  (font-spec :family chinese :size chinese-size))))

(add-hook 'after-init-hook
		  (lambda ()
			;; (set-font "JetBrains Mono" "华文楷体" 13 15)
			;; (set-font "JetBrains Mono" "霞鹜文楷" 13 15)
			(set-font "霞鹜文楷等宽" "霞鹜文楷等宽" 14 14)
			;; (set-font "JetBrains Mono" "STkaiti" 13 14)
			;; (set-font "Source Code Pro" "STkaiti" 13 15)
			;; (set-font "monospace" "STkaiti" 14 14)
			;; (set-font "Hack" "Stkaiti" 13 15)
			;; (set-font "Monoid" "更纱黑体 SC" 13 15)
			;; (set-font "Monoid" "更纱黑体 SC" 12 14)
			(setq line-spacing 0.409)
			(setq-default line-spacing 0.409)
			(setq visible-bell nil)))

(use-package display-line-numbers
  :ensure nil
  :hook (prog-mode . display-line-numbers-mode))

(provide 'init-theme)
