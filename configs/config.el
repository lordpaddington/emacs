;; BASIC SETUP
;; ===========

(require 'package)
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))
;  (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/")))
(unless (assoc-default "org" package-archives)
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t))

(unless (package-installed-p 'use-package)
  (package-install 'use-package)
  (package-refresh-contents))

(require 'use-package)
;;(setq use-package-verbose t)
(setq use-package-always-ensure t) ;This makes every package in use-package installed on every machine!!!
(recentf-mode 1)

(setq load-prefer-newer t)

;;opening a file from finder will reuse the same window
(setq ns-pop-up-frames nil)

(desktop-save-mode 1)
(setq desktop-load-locked-desktop t)

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(prefer-coding-system 'utf-8)
(setq ring-bell-function 'ignore)

(setq calendar-week-start-day 1)
(fset 'yes-or-no-p 'y-or-n-p)

;; Ignore split window horizontally (what does this do?)
(setq split-width-threshold nil)
(setq split-width-threshold 100)

(setq track-eol t)			; Keep cursor at end of lines.
(setq line-move-visual nil)		; To be required by track-eol
;(setq-default kill-whole-line t)	; Kill line including '\n'
(setq-default indent-tabs-mode t)   ; nil to use space

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)


;; STYLE
;; =====
(setq custom-safe-themes t) ;;UNSAFE! Set every theme as safe, so there is no confirmation!

;(set-face-attribute 'default nil :font "Menlo 16")
(delete-selection-mode 1)
(global-visual-line-mode t)
(scroll-bar-mode 0)
;(setq frame-title-format nil)


(setq show-paren-delay 0)
(show-paren-mode)

;;System-dependent changes (FUCKING KILL/REFACTOR THIS!!!!)
;; TODO: Consider moving the system-specific settings into separate files!
(cond ((eq system-type 'darwin)
       (set-face-attribute 'default nil :font "Menlo 16")
       (setq mac-command-modifier 'meta)
       (setq mac-option-modifier 'none)
       (use-package ns-auto-titlebar)
       (setq ns-auto-titlebar-mode nil)
       (add-to-list 'default-frame-alist '(ns-transparent-titlebar . nil))
       (add-to-list 'default-frame-alist '(ns-appearance . dark))
       (setq ns-use-proxy-icon nil)
       (global-set-key (kbd "M-h") 'ns-do-hide-emacs)
       (custom-theme-set-faces
	'user
	'(variable-pitch ((t (:family "PT Sans" :height 180))))
	'(fixed-pitch ((t ( :family "PT Mono" :height 180))))
        '(egoge-display-time ((t (:inherit modeline :foreground "white" :weight bold :height 0.9))))
       )
       
       )
      
      ((eq system-type 'windows)
       (menu-bar-mode 0)       
       (custom-theme-set-faces
	'user
	'(variable-pitch ((t (:family "Tahoma" :height 300))))
     	;This shit doesn't seem to work on win and don't know why!!!
	'(fixed-pitch ((t ( :family "Consolas" :height 180)))))
        '(egoge-display-time ((t (:inherit fixed-pitch :foreground "Royal Blue")))) 
	)
      
      ((eq system-type 'gnu/linux)
       (menu-bar-mode 0)
       (set-face-attribute 'default nil :font "Liberation Mono 16")
       (custom-theme-set-faces
	'user
	'(variable-pitch ((t (:family "Ubuntu" :height 180))))
	'(fixed-pitch ((t ( :family "Liberation Mono" :height 180))))
        '(egoge-display-time ((t (:inherit modeline :foreground "white" :weight bold :height 0.9))))
       )
       )
      )


(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(fringe-mode 20)
(set-face-attribute 'fringe nil :background nil)
(tool-bar-mode -1)

;;THEME
;;(Use-package solarized-theme)
;;(setq solarized-use-variable-pitch nil)
;;(setq solarized-scaqle-org-headlines nil)
;;(setq x-underline-at-descent-line t)
;;(setq solarized-high-contrast-mode-line t)
;;(load-theme 'solarized-light-high-contrast t)
(use-package doom-themes)
(require 'doom-themes)
(load-theme 'doom-opera-light) ;Fancy light theme
;(load-theme 'zenburn) ;Nice darkish theme
;(load-theme 'tango) ;Simple light theme

;;Cursor visibility
(setq-default cursor-type '(bar . 3)) ;; Comment this out if using Evil!!!!
(set-cursor-color "#FF8C00")
(global-hl-line-mode)


(defface egoge-display-time
   '((((type x w32 mac))
      ;; #060525 is the background colour of my default face.
      (:foreground "red" :height 0.8))
     (((type tty))
      (:foreground "red" :height 0.8)))
   "Face used to display the time in the mode line.")
;; Rejtély, de valamiéret ez muszáj ide, még akkor is, ha amúgy odafönnt adom meg, hogy hogy kéne kinéznie a fontnak és azt veszi figyelembe...

(setq display-time-string-forms
      '((propertize (concat " " 24-hours ":" minutes " ")
	    'face 'egoge-display-time))) ;;Fuck, this did work once, but not anymore and I don't know why!!!!
(display-time-mode t)


;; KEYS
;; ====
(global-set-key (kbd "<C-up>") 'scroll-down-command)
(global-set-key (kbd "<C-down>") 'scroll-up-command)
(global-set-key (kbd "C-.") 'set-mark-command)
(global-set-key (kbd "<M-left>") 'beginning-of-line)
(global-set-key (kbd "<M-right>") 'end-of-line)
(with-eval-after-load 'dired
  (define-key dired-mode-map "-" 'dired-up-directory))
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

;;(setq ns-function-modifier 'control)

;(with-eval-after-load 'org
;  (define-key org-mode-map (kbd "<C-S-up>") 'org-move-subtree-up)
  ;; (define-key org-mode-map (kbd "<C-S-down>") 'org-move-subtree-down)
  ;; ;(define-key org-mode-map (kbd "<M-left>") 'beginning-of-line)
  ;; ;(define-key org-mode-map (kbd "<M-right>") 'end-of-line)
  ;; )

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-xg" 'magit-status)
(global-set-key (kbd "C-c v j") 'vix-open-todays-journal)
(global-set-key (kbd "C-c v h") 'vix-open-home-file)


;; PACKAGES:
;; =========

;;auto-compile
(use-package auto-compile
  :config
  (auto-compile-on-load-mode))

;;restart emacs easily
(use-package restart-emacs
  :bind*
  (("C-x M-c" . restart-emacs)))

;;typewriter scrolling
(use-package centered-cursor-mode)

;; move properly to the end of the line
(use-package mwim
  :bind
  ("C-a" . mwim-beginning-of-code-or-line)
  ("C-e" . mwim-end-of-code-or-line))

;;tree buffer
(use-package treemacs
  :config
  ;(treemacs)
  (treemacs-toggle-fixed-width)
  :bind
  ([f9] . treemacs) ;miért nem megy?
  :custom
  (treemacs-width 50))


;;Treemacs icons in dired
(use-package treemacs-icons-dired
  :after treemacs
  :config (treemacs-icons-dired-mode)) 

;;Custom modeline
(use-package simple-modeline
  :config (simple-modeline-mode))

;;Easy window switching
(use-package windmove
  :bind
  (("<C-M-right>" . windmove-right)
   ("<C-M-left>" . windmove-left)
   ("<C-M-up>" . windmove-up)
   ("<C-M-down>" . windmove-down)
   ))

;;Show keybindings!!!!
(use-package which-key
  :diminish which-key-mode
  :custom
  (which-key-sort-order 'which-key-key-order-alpha)  
  :bind* (("M-m ?" . which-key-show-top-level))
  :config
  (which-key-mode)
  (which-key-add-key-based-replacements "M-m ?" "top level bindings")
  (which-key-setup-minibuffer)
)

;;focused writing
(use-package writeroom-mode
  :bind ([f7] . writeroom-mode))

;;IVY Autocompletion (keep recent files in the buffer list)
(use-package counsel)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")


;;MAGIT
(use-package magit)

;;Zettelkasten implementation
(use-package deft
  :init
    (setq deft-extensions '("org" "md" "txt")
          deft-use-filename-as-title nil
	  deft-use-filter-string-for-filename nil
	  deft-recursive t
	  deft-text-mode 'org-mode
	  deft-org-mode-title-prefix "#+TITLE:")       
  :bind
  ([f8] . deft)
  ("C-c d n" . deft-new-file-named)
  ("C-c d d" . deft)
)

;;VTERM
;;(use-package vterm
;; :load-path  "~/.emacs.d/emacs-libvterm/")

;; (use-package zetteldeft
;;   :after
;;   deft
;;   :init
;;   (setq zetteldeft-link-indicator "§"
;;       zetteldeft-id-format "%Y-%m-%d-%H%M"
;;       zetteldeft-id-regex "[0-9]\\{4\\}\\(-[0-9]\\{2,\\}\\)\\{3\\}"
;;       zetteldeft-tag-regex "[#@][a-z-]+")  
;;   :config
;;   (zetteldeft-set-classic-keybindings)
;;   )


;;Markdown
(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . gfm-mode)
         ("\\.markdown\\'" . gfm-mode))
  :custom
  (markdown-header-scaling t)
  (markdown-hide-markup t)
  (markdown-command "multimarkdown")
  (markdown-indent-function t)
  (markdown-hide-urls t)
  (markdown-enable-wiki-links t)
  :config
  (variable-pitch-mode)
  ;; :custom-face
  ;; TODO: copy the OrgMode faces, but try to keep the original blue heading colors
  ;; (markdown-header-delimiter-face ((t (:foreground "mediumpurple"))))
  ;; (markdown-header-face-1 ((t (:foreground "violet" :weight bold :height 1.0))))
  ;; (markdown-header-face-2 ((t (:foreground "lightslateblue" :weight bold :height 1.0))))
  ;; (markdown-header-face-3 ((t (:foreground "mediumpurple1" :weight bold :height 1.0))))
  ;; (markdown-link-face ((t (:background "#0e1014" :foreground "#bd93f9"))))
  ;; (markdown-list-face ((t (:foreground "mediumpurple"))))
  ;; (markdown-pre-face ((t (:foreground "#bd98fe"))))
  )
  
  (setq markdown-link-space-sub-char " ")




;;Org Mode
(load-file "~/.emacs.d/local.el")


(use-package org
  :config  
  (org-display-inline-images)
  (add-hook 'org-mode-hook 'variable-pitch-mode 'centered-cursor-mode)
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
   '(org-headline-done ((t (:foreground "Grey" :strike-through t :weight bold)))))
  :custom
  (org-src-fontify-natively t)
  (org-agenda-span 'day)  
  (org-startup-indented t)
  (org-hide-leading-stars t)
  (org-startup-folded "content")
  (org-agenda-start-on-weekday 1)
  (org-pretty-entities t)
  (org-fontify-done-headline t)
  (org-hide-emphasis-markers t)
  (org-todo-keywords '((sequence "TODO(t)" "INPR(i)" "WAIT(w)" "|" "DONE(d)" )))
  (org-todo-keyword-faces '(("TODO" . org-todo) ("INPR" . "orange") ("WAIT" . "purple")))

  ;; Directories
  
  :bind (:map org-mode-map
	      ("<M-left>" . beginning-of-line)
	      ("<M-right>" . end-of-line)
	      ("<C-S-up>" . org-move-subtree-up)
	      ("<C-S-down>" . org-move-subtree-down)
              )
  )

(use-package org-download)
(use-package org-bullets  
  :hook
  (org-mode . (lambda () (org-bullets-mode 1)))
  )

;;Org Capture Templates
(setq org-inbox (concat org-directory "/In"))
(setq org-projects (concat org-directory "/Projects"))
(setq deft-directory "~/org/Reference")
;;(setq org-refile-use-outline-path 'file) - ez lehet kell a refile mukodesehez.

(defvar inbox (expand-file-name "Inbox.org" org-inbox))
(defvar todo (expand-file-name "Next Actions.org" org-directory))
;(defvar reference (expand-file-name "Reference" org-directory))
(defvar minutes (expand-file-name "Minutes" org-directory))
(defvar someday (expand-file-name "Someday.org" org-directory))

(defun my/generate-minute-name ()
  (setq my-minute--name (read-string "Meeting Title: "))
  (setq my-minute--date (format-time-string "%Y-%m-%d"))
  (expand-file-name (format "%s - %s.org" my-minute--date my-minute--name ) minutes))

(setq org-capture-templates
      '(
        ("t" "Todo" entry (file+headline todo "Next Actions:")
         "* TODO %?\n")
        ("n" "Quick Note" entry (file inbox)
         "* %?\n\n" :prepend t)
        ("a" "Action item" entry (file+headline (lambda() (buffer-file-name)) "Action items:")
         "* TODO %?\n")
	("l" "Log Entry" entry (file+headline (lambda() (buffer-file-name)) "Log")
         "** %U %?\n" :prepend t)
	("m" "New Meeting Minutes" plain (file my/generate-minute-name) "%(format \"#+TITLE: %s\n#+DATE:  %s\n\" my-minute--name my-minute--date)\n%?\n")
       )
      )

(setq org-refile-targets (quote ((todo :maxlevel . 1)
                                 (someday :maxlevel . 1))))
;Consider having Next Actions in the home file...

(setq org-agenda-files (list todo inbox someday))




;;Org-roam
(use-package org-roam
      :ensure t
      :hook
      (after-init . org-roam-mode)
      ;;:custom
      ;; (org-roam-directory (file-truename "/path/to/org-files/"))
      ; Take this from the local.el!!!
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))


;; FUNCTIONS
;; =========

;; insert current date
(defun vix-insert-current-date () (interactive)
       (insert (shell-command-to-string "echo -n $(date +%Y-%m-%d)")))


(defun vix-open-todays-journal ()
  (interactive)
  (find-file-other-window (concat org-directory (format-time-string "/Journal/%Y-%m-%d %A.org"))))

(defun vix-open-home-file ()
  (interactive)
  (find-file-other-window (concat org-directory "/Home.org")))


;; (defun ladicle/open-org-file (fname)
;;       (switch-to-buffer (find-file-other-frame fname)))

;; archive all done tasks
(defun vix-org-archive-done-tasks ()
  (interactive)
  (org-map-entries 'org-archive-subtree "/DONE" 'file))


(defun vix-org-archive-done-tasks ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
   "/DONE" 'tree))

;; Edit/View mode change for Markdown
;; FUCKING DOESN'T WORK!
;; For some reason it's not a toggle, only set them once.
(defun vix-markdown-modechange ()
  (interactive)
  (markdown-toggle-markup-hiding)
  (variable-pitch-mode)
  (markdown-toggle-url-hiding)
  )

;; (with-eval-after-load 'markdown-mode
;;   (define-key markdown-mode-map (kbd "<C-return>") 'my-markdown-modechange)
;;   )



;; LAST
;; ====

; Load the local settings! (LEAVE THIS LAST!)

