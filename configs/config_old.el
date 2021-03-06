;;(setq desktop-dirname "~/.emacs.d/")
;;(desktop-read)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-verbose t)
(setq use-package-always-ensure t)
(use-package auto-compile
  :config (auto-compile-on-load-mode))


;;set up package management
(require 'package)
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/")))
(unless (assoc-default "org" package-archives)
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t))

(setq load-prefer-newer t)
(setq custom-safe-themes t) ;;UNSAFE! Set every theme as safe, so there is no confirmation!



(use-package restart-emacs
  :ensure t
  :bind* (("C-x M-c" . restart-emacs)))

;;BASICS
(set-face-attribute 'default nil :font "Courier 16")
(delete-selection-mode 1)


;;Set face depending on mode
;TODO: fix this, make it system dependent, I'm sure it fucks everything up on windows...

;Note-this most likely doesn't fucking work... :(



;;MAC SPECIFIC - put it in an ifmac
(cond ((eq system-type 'darwin)
       (set-face-attribute 'default nil :font "Menlo 16")
       (setq mac-command-modifier 'meta)
       (setq mac-option-modifier 'none)
       (use-package ns-auto-titlebar)
       (ns-auto-titlebar-mode 1)
       (add-to-list 'default-frame-alist '(ns-transparent-titlebar))
       (add-to-list 'default-frame-alist '(ns-appearance . dark))
       (setq ns-use-proxy-icon nil)
       (custom-theme-set-faces
	'user
	'(variable-pitch ((t (:family "PT Sans" :height 180))))
	'(fixed-pitch ((t ( :family "PT Mono" :height 180)))))
       )
      ((eq system-type 'windows)
       (setq org-directory "C:/Users/Viktor/Dropbox/org")
       (add-to-list 'exec-path "C:/Users/Viktor/usr/sqlite3")
       (menu-bar-mode 0)       
       (custom-theme-set-faces
	'user
	'(variable-pitch ((t (:family "Tahoma" :height 300))))
     	;This shit doesn't seem to work on win and don't know why!!!
	'(fixed-pitch ((t ( :family "Consolas" :height 180)))))
        '(egoge-display-time ((t (:inherit fixed-pitch :foreground "Royal Blue" :weight bold)))) 
       )
      )

(global-visual-line-mode t) ;; This should be set only for Org and Markdown, like this
;; (add-hook 'org-mode-hook 'visual-line-mode)
(desktop-save-mode 1) ;;Disabling to see if it breaks roam...
(setq desktop-load-locked-desktop t)
(scroll-bar-mode 0)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(prefer-coding-system 'utf-8)
(setq ring-bell-function 'ignore)
(setq show-paren-delay 0)
(show-paren-mode)
;;(blink-cursor-mode -1)
(setq calendar-week-start-day 1)

(use-package centered-cursor-mode)

;;Custom keybindings
(global-set-key (kbd "<C-up>") 'scroll-down-command)
(global-set-key (kbd "<C-down>") 'scroll-up-command)
(global-set-key (kbd "C-.") 'set-mark-command)
(global-set-key (kbd "<M-left>") 'beginning-of-line)
(global-set-key (kbd "<M-right>") 'end-of-line)
(with-eval-after-load 'dired
  (define-key dired-mode-map "-" 'dired-up-directory))

;;Visuals
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(fringe-mode 20) ;this is usually 10 only.
;;(set-face-attribute 'mode-line nil :font "Courier-13") - faszért nem működik rendesen?!?!?



;;Themes
;;(Use-package solarized-theme)
;;(setq solarized-use-variable-pitch nil)
;;(setq solarized-scale-org-headlines nil)
;;(setq x-underline-at-descent-line t)
;;(setq solarized-high-contrast-mode-line t)
;;(load-theme 'solarized-light-high-contrast t)
(use-package doom-themes)
(require 'doom-themes)
(load-theme 'doom-opera-light) ;Fancy light theme
;(load-theme 'zenburn) ;Nice darkish theme
;(load-theme 'tango) ;Simple light theme
(set-face-attribute 'fringe nil :background nil)
(tool-bar-mode -1)
;(load-theme doom-themes-neotree) ;;How the fuck does this work?
(doom-themes-neotree-config)

;;NEOTREE as default
;(use-package neotree)
;(neotree-show)
;(setq neo-window-width 50)
;(setq neo-window-fixed-size nil)
;(global-set-key [f8] 'neotree-toggle)
;(setq neo-smart-open t)


;;TREEMACS FTW
(use-package treemacs)
(global-set-key [f8] 'treemacs)
(setq treemacs-width 50)
(treemacs)
(treemacs-toggle-fixed-width)
(use-package treemacs-icons-dired) ;Treemacs icons in dired!
(treemacs-icons-dired-mode)



;;MODELINE
(use-package simple-modeline)
(simple-modeline-mode)

;;Insert Date Function
(defun insert-current-date () (interactive)
       (insert (shell-command-to-string "echo -n $(date +%Y-%m-%d)")))

;;Easy switch windows
(use-package windmove
  :bind
  (("<C-M-right>" . windmove-right)
   ("<C-M-left>" . windmove-left)
   ("<C-M-up>" . windmove-up)
   ("<C-M-down>" . windmove-down)
   ))

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
(fset 'yes-or-no-p 'y-or-n-p)


;; Show keybindings!!!!
(use-package which-key
  :ensure t
  :defer t
  :diminish which-key-mode
  :init
  (setq which-key-sort-order 'which-key-key-order-alpha)
  :bind* (("M-m ?" . which-key-show-top-level))
  :config
  (which-key-mode)
  (which-key-add-key-based-replacements "M-m ?" "top level bindings")
  (which-key-setup-minibuffer)
)

;;smex is an amazing program that helps order the M-x commands based on usage and recent items.
(use-package smex
  :ensure t
  :config
  (smex-initialize))

;;IVY Autocompletion
(use-package counsel)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
;;A faszert nem mukodik ez???

;;MARKDOWN
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(setq markdown-header-scaling 1)
(setq markdown-hide-markup 1)
(use-package writeroom-mode)


;; Doesn't fucking work!
;; For some reason it's not a toggle, only set them once.
(defun my-markdown-modechange ()
  (interactive)
  (markdown-toggle-markup-hiding)
  (variable-pitch-mode)
  )

(with-eval-after-load 'markdown-mode
  (define-key markdown-mode-map (kbd "<C-return>") 'my-markdown-modechange)
  )

;;DEFT and ZETTELDEFT
(use-package deft
  :ensure t
  :init
    (setq deft-extensions '("org" "md" "txt")
          deft-use-filename-as-title nil
	  deft-recursive t
	  deft-text-mode 'org-mode))

(use-package zetteldeft
  :ensure t
  :after deft
  :config (zetteldeft-set-classic-keybindings))

(setq zetteldeft-link-indicator "§"
      zetteldeft-id-format "%Y-%m-%d-%H%M"
      zetteldeft-id-regex "[0-9]\\{4\\}\\(-[0-9]\\{2,\\}\\)\\{3\\}"
      zetteldeft-tag-regex "[#@][a-z-]+")



;(setq deft-use-filter-string-for-filename t) ;Ez miez?
;(setq deft-file-naming-rules '((noslash . "-")
;                                   (nospace . "-")
;                                   (case-fn . downcase)))
; Lehet itt be kellene konfigolni az alapokat...



;;ORG ROAM

;This could theoretically turn a [[ into a new Roam Insert link, but I couldn't get it work.
;(use-package key-chord)
;(key-chord-define org-mode-map "[[" #'my/insert-roam-link)
;(defun my/insert-roam-link ()
;    "Inserts an Org-roam link."
;    (interactive)
;    (insert "[[file:]]") ;Shouldn't this be roam?
;    (backward-char 2))





;;(use-package org-roam
;  :ensure t
;  :hook
;  (after-init . org-roam-mode)
;  :custom
;  (org-roam-directory "~/org/Notes/")
;  :bind (:map org-roam-mode-map
;              (("C-c r l" . org-roam)
;               ("C-c r f" . org-roam-find-file)
;	       ("C-c r F" . org-roam-find-file-immediate)
;               ("C-c r g" . org-roam-graph)
;              :map org-mode-map
;              (("C-c r i" . org-roam-insert))
;              (("C-c r I" . org-roam-insert-immediate)))))

;;MAGIT
(use-package magit)

;;EVIL MODE
;; Set up package.el to work with MELPA

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
;(require 'evil)
;(evil-mode)
(setq-default cursor-type 'bar) ;; Comment this out if using Evil!!!!


;;ORG Setup
;;=========
(setq org-startup-indented t
      org-hide-leading-stars t
      org-startup-folded "content"
      org-agenda-start-on-weekday 1
      org-pretty-entities t
      org-hide-emphasis-markers t
      org-todo-keywords '((sequence "TODO(t)" "INPR(i)" "WAIT(w)" "|" "DONE(d)"))
      org-todo-keyword-faces
      '(("TODO" . org-todo) ("INPR" . "orange")
        ("WAIT" . "purple"))
      )


;; The following lines are always needed.  Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-xg" 'magit-status)



;; Archive all done tasks
(defun my-org-archive-done-tasks ()
  (interactive)
  (org-map-entries 'org-archive-subtree "/DONE" 'file))

;;Do stuff only after Org is loaded:
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "<M-left>") 'beginning-of-line)
  (define-key org-mode-map (kbd "<M-right>") 'end-of-line)
  (define-key org-mode-map (kbd "<C-S-up>") 'org-move-subtree-up)
  (define-key org-mode-map (kbd "<C-S-down>") 'org-move-subtree-down)
  (centered-cursor-mode))

(add-hook 'org-mode-hook 'org-display-inline-images)

(use-package org-bullets)
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;Org font customizations
(add-hook 'org-mode-hook 'variable-pitch-mode)
(setq org-fontify-done-headline t)
(custom-theme-set-faces
   'user
   '(org-block ((t (:inherit fixed-pitch))))
   '(org-code ((t (:inherit (shadow fixed-pitch)))))
   '(org-document-info ((t (:foreground "dark orange"))))
   '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
   '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
   '(org-link ((t (:foreground "royal blue" :underline t))))
   '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-property-value ((t (:inherit fixed-pitch))) t)
   '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-table ((t (:inherit fixed-pitch))))
   '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
   '(org-verbatim ((t (:inherit (shadow fixed-pitch)))))
   '(org-checkbox ((t (:inherit fixed-pitch :foreground "ForestGreen" :weight bold))))
   '(org-document-title ((t (:height 1.5 :weight bold :underline t))))
   '(org-level-1 ((t (:height 1.25 :weight bold))))
   '(org-level-2 ((t (:height 1.1 :weight bold))))
   '(org-level-3 ((t (:height 1.0 :weight bold))))
   '(org-level-4 ((t (:height 1.0 :weight bold))))
   '(org-level-5 ((t (:height 1.0 :weight bold))))
   '(org-level-6 ((t (:height 1.0 :weight bold))))
   '(org-level-7 ((t (:height 1.0 :weight bold))))
   '(org-todo ((t (:inherit fixed-pitch))))
   '(org-done ((t (:inherit fixed-pitch :strike-through t :foreground "Dark Grey"))))
   '(org-headline-done ((t (:foreground "Grey" :strike-through t :weight bold))))
   '(egoge-display-time ((t (:inherit fixed-pitch :foreground "Royal Blue" :weight bold))))
   ) 

(setq display-time-string-forms
      '((propertize (concat " " 24-hours ":" minutes " ")
	    'face 'egoge-display-time))) ;;Fuck, this did work once, but not anymore and I don't know why!!!!
(display-time-mode 1)


;; Load the locally applicable settings
(load-file "~/.emacs.d/local.el")

