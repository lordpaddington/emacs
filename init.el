(package-initialize)
(load-file "~/.emacs.d/configs/config.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("5cfe6c8985aacad987b52fc671687d019e4c0992ad5ad7a4e8a52808a0271bfd" default))
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   '(magit solarized-theme doom-themes powerline-evil powerline doom-modeline which-key use-package smex simple-modeline restart-emacs counsel centered-cursor-mode auto-compile)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-done ((t (:weight normal :strike-through t))))
 '(org-headline-done ((t (:strike-through t)))))
