(package-initialize)
(load-file "~/.emacs.d/configs/config.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("c3a072b0ea1993bebdaa21b80bf8b0177181db4289725770d1c80a859c5189ca" "3fa99bb817539e73335905dc181bf5ec104134a2efe31de512dbe3edeb25ee48" "37a4701758378c93159ad6c7aceb19fd6fb523e044efe47f2116bc7398ce20c9" "93ed23c504b202cf96ee591138b0012c295338f38046a1f3c14522d4a64d7308" "e074be1c799b509f52870ee596a5977b519f6d269455b84ed998666cf6fc802a" "99ea831ca79a916f1bd789de366b639d09811501e8c092c85b2cb7d697777f93" "f2927d7d87e8207fa9a0a003c0f222d45c948845de162c885bf6ad2a255babfd" "5cfe6c8985aacad987b52fc671687d019e4c0992ad5ad7a4e8a52808a0271bfd" default))
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   '(neotree org-bullets diminish ns-auto-titlebar markdown-mode+ markdown-preview-mode writeroom-mode markdown-mode sqlite3 key-chord magit solarized-theme doom-themes powerline-evil powerline which-key use-package simple-modeline restart-emacs counsel centered-cursor-mode auto-compile))
 '(save-place-mode t)
 '(show-paren-mode t)
 '(simple-modeline-segments
   '((simple-modeline-segment-modified simple-modeline-segment-buffer-name simple-modeline-segment-position)
     (simple-modeline-segment-input-method simple-modeline-segment-eol simple-modeline-segment-encoding simple-modeline-segment-vc simple-modeline-segment-misc-info simple-modeline-segment-process simple-modeline-segment-major-mode)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fixed-pitch ((t (:family "PT Mono" :height 180))))
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-checkbox ((t (:inherit fixed-pitch :foreground "ForestGreen" :weight bold))))
 '(org-code ((t (:inherit (shadow fixed-pitch)))))
 '(org-document-info ((t (:foreground "dark orange"))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-document-title ((t (:height 1.5 :weight bold :underline t))))
 '(org-done ((t (:inherit fixed-pitch :strike-through t :foreground "Dark Grey"))))
 '(org-headline-done ((t (:foreground "Grey" :strike-through t :weight bold))))
 '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
 '(org-level-1 ((t (:height 1.25 :weight bold))))
 '(org-level-2 ((t (:height 1.1 :weight bold))))
 '(org-link ((t (:foreground "royal blue" :underline t))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-property-value ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-table ((t (:inherit fixed-pitch))))
 '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
 '(org-todo ((t (:inherit fixed-pitch))))
 '(org-verbatim ((t (:inherit (shadow fixed-pitch)))))
 '(variable-pitch ((t (:family "PT Sans" :height 180)))))
