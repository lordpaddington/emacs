(package-initialize)
(load-file "~/.emacs.d/configs/config.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org-bullets org-download zenburn-theme writeroom-mode which-key use-package treemacs-icons-dired simple-modeline restart-emacs mwim markdown-mode magit evil doom-themes deft counsel centered-cursor-mode auto-compile))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(egoge-display-time ((t (:inherit modeline :foreground "white" :weight bold :height 0.9))))
 '(fixed-pitch ((t (:family "FreeMono" :height 180))))
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
 '(org-level-3 ((t (:height 1.0 :weight bold))))
 '(org-level-4 ((t (:height 1.0 :weight bold))))
 '(org-level-5 ((t (:height 1.0 :weight bold))))
 '(org-level-6 ((t (:height 1.0 :weight bold))))
 '(org-level-7 ((t (:height 1.0 :weight bold))))
 '(org-link ((t (:foreground "royal blue" :underline t))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-property-value ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-table ((t (:inherit fixed-pitch))))
 '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
 '(org-todo ((t (:inherit fixed-pitch))))
 '(org-verbatim ((t (:inherit (shadow fixed-pitch)))))
 '(variable-pitch ((t (:family "FreeSans" :height 180)))))
