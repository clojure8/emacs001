;;; init-lsp-bridge.el --- The necessary settings -*- lexical-binding: t -*-


(use-package markdown-mode :ensure t)

(use-package yasnippet :ensure t)
(use-package yasnippet-snippets :ensure t)

(use-package lsp-bridge
  :ensure nil
  :load-path "~/elisp/lsp-bridge"
  :hook ((prog-mode . lsp-bridge-mode)
         (after-init . yas-global-mode)))

(use-package treemacs
  :ensure t)

(provide 'init-lsp-bridge)
