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
(setq split-height-threshold 120
      split-width-threshold 160)

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
(scroll-bar-mode 1)
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
        '(egoge-display-time ((t (:inherit modeline :foreground "orange" :weight bold :height 0.9))))
       )
       
       )
      
      ((eq system-type 'windows)
       (menu-bar-mode 0)       
       (custom-theme-set-faces
	'user
	'(variable-pitch ((t (:family "Tahoma" :height 300))))
     	;This shit doesn't seem to work on win and don't know why!!!
	'(fixed-pitch ((t ( :family "Consolas" :height 180)))))
        '(egoge-display-time ((t (:inherit modeline :foreground "orange" :weight bold :height 0.9))))
	)
      
      ((eq system-type 'gnu/linux)
       (menu-bar-mode 0)
       (set-face-attribute 'default nil :font "Liberation Mono 16")
       (custom-theme-set-faces
	'user
	'(variable-pitch ((t (:family "Ubuntu" :height 180))))
	'(fixed-pitch ((t ( :family "Liberation Mono" :height 180))))
	'(egoge-display-time ((t (:inherit modeline :foreground "orange" :weight bold :height 0.9))))
       )
       )
      )


(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'load-path "~/.emacs.d/packages/")
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
;(use-package doom-themes)
;(require 'doom-themes)
;(load-theme 'doom-opera-light) ;Fancy light theme
;(load-theme 'zenburn) ;Nice darkish theme
(load-theme 'victory) ;Simple light theme

;;Cursor visibility
(setq-default cursor-type '(bar . 3)) ;; Comment this out if using Evil!!!!
(set-cursor-color "#FF8C00")
;;(global-hl-line-mode) - if you want line highlighting.

(set-face-attribute 'fringe nil :background nil)

(defface egoge-display-time
   '((((type x w32 mac))
      ;; #060525 is the background colour of my default face.
      (:foreground "red" :height 0.8))
     (((type tty))
      (:foreground "red" :height 0.8)))
   "Face used to display the time in the mode line.")


(setq display-time-string-forms
      '((propertize (concat " " 24-hours ":" minutes " ")
	    'face 'egoge-display-time))) ;;Face defined in the theme!
(display-time-mode t)

;;Kill window when the buffer is killed:


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
(global-set-key (kbd "C-c K") 'kill-buffer-and-window) ;;Could write a function to this: if one window, 'kill-buffer, if >1: 'kill-buffer-and-window...


;; PACKAGES:
;; =========

;; adaptive wrapping
;;(require 'adaptive-wrap-vp) - this is buggy, fucks up markdown.
(use-package adaptive-wrap)


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
;(use-package simple-modeline
;  :config (simple-modeline-mode))

(setq simple-modeline-segments
      '((simple-modeline-segment-modified
	 simple-modeline-segment-buffer-name)
	(simple-modeline-segment-minor-modes
	 simple-modeline-segment-input-method
	 simple-modeline-segment-vc
	 simple-modeline-segment-misc-info
	 simple-modeline-segment-process
	 simple-modeline-segment-major-mode)))

;; Experimental, leave alone for now.
;(setq-default header-line-format mode-line-format)
;(setq-default mode-line-format nil)



(custom-set-faces
 '(simple-modeline-status-modified ((t (:foreground "#ee0000"))))
 )

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

;;Centered Window Mode
(use-package centered-window :ensure t)
;(centered-window-mode t)
;(setq cwm-centered-window-width 80) ;; nem biztos, hogy működik!!!

;;IVY Autocompletion (keep recent files in the buffer list)
(use-package counsel
  :diminish ivy
  )
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
(when (commandp 'counsel-M-x)
  (global-set-key [remap execute-extended-command] #'counsel-M-x))
(global-set-key (kbd "C-x C-b") 'counsel-switch-buffer)
(setq ivy-initial-inputs-alist: '((counsel-M-x . "")))


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
	  deft-org-mode-title-prefix t
	  )       
  :bind
  ([f8] . deft)
  ("C-c d n" . deft-new-file-named)
  ("C-c d d" . deft)
  )

(setq deft-file-naming-rules '((nospace . "_")
                                   (case-fn . downcase)))


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
  ;; :commands (markdown-mode gfm-mode)
  ;; :mode (("README\\.md\\'" . gfm-mode)
  ;;        ("\\.md\\'" . gfm-mode)
  ;;        ("\\.markdown\\'" . gfm-mode))
  :commands (markdown-mode)
  :mode (("README\\.md\\'" . markdown-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))  
  :custom
  (markdown-header-scaling t)
  (markdown-hide-markup t)
  (markdown-command "multimarkdown")
  ;;(markdown-indent-function markdown-indent-line)
  (markdown-hide-urls t)
  (markdown-enable-wiki-links t)
  :config
  (variable-pitch-mode)
  )
  
  (setq markdown-link-space-sub-char " ")

(add-hook 'markdown-mode-hook 'variable-pitch-mode 'adaptive-wrap-prefix-mode)
(setq markdown-indent-on-enter 'indent-and-new-item
      markdown-make-gfm-checkboxes-buttons t
      markdown-gfm-uppercase-checkbox t)




;;Org Mode
(load-file "~/.emacs.d/local.el")


(use-package org
  :config  
  (add-hook 'org-mode-hook 'variable-pitch-mode 'centered-cursor-mode)
  :custom
  (org-src-fontify-natively t)
  (org-agenda-span 'day)  
  (org-startup-indented t)
  (org-startup-with-inline-images t)
  (org-hide-leading-stars t)
  (org-startup-folded "content")
  (org-agenda-start-on-weekday 1)
  (org-fontify-quote-and-verse-blocks t)  
  (org-pretty-entities t)
  (org-fontify-done-headline t)
  (org-hide-emphasis-markers t)
  (org-todo-keywords '((sequence "TODO(t)" "INPR(i)" "WAIT(w)" "|" "DONE(d)" )))
  (org-todo-keyword-faces '(("TODO" . org-todo) ("INPR" . "orange") ("WAIT" . "purple")))
  :bind (:map org-mode-map
	      ("<M-left>" . beginning-of-line)
	      ("<M-right>" . end-of-line)
	      ("<C-S-up>" . org-move-subtree-up)
	      ("<C-S-down>" . org-move-subtree-down)
              )
  )

(add-hook 'org-mode-hook 'variable-pitch-mode 'centered-cursor-mode)
;(setq org-display-inline-images t)

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
(defvar scheduled (expand-file-name "Scheduled.org" org-directory))
(defvar reference (expand-file-name "Reference" org-directory))

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
                                 (someday :maxlevel . 1)
				 (scheduled :maxlevel . 1)
				 )))
;Consider having Next Actions in the home file...

(setq org-agenda-files (list todo inbox scheduled minutes))




;;Org-roam
(use-package org-roam
      :diminish org-roam-mode
      :ensure t
      :hook
      (after-init . org-roam-mode)
      ;;:custom
      ;; (org-roam-directory (file-truename "/path/to/org-files/"))
      ; Take this from the local.el!!!
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph)
	       ("C-c n b" . org-roam-switch-to-buffer)
	       )
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))



;; Clean up the modeline
;(diminish '(auto-revert-mode ivy-mode line-number-mode global-visual-line-mode))
;(diminish 'visual-line-mode)

(use-package diminish
  :diminish auto-revert-mode
  :diminish visual-line-mode
  :diminish ivy-mode
  :diminish line-number-mode
  :diminish eldoc-mode
  :diminish buffer-face-mode
  :diminish rainbow-mode
  )





;; FUNCTIONS
;; =========

;; insert current date
(defun vix-insert-current-date () (interactive)
       "Insert todays date in YYYY-MM-DD format."
       (insert (shell-command-to-string "echo -n $(date +%Y-%m-%d)")))


(defun vix-open-todays-journal ()
  "Display today's journal file."
  (interactive)
  (find-file-other-window (concat org-directory (format-time-string "/Journal/%Y-%m-%d %A.org"))))

(defun vix-open-home-file ()
  "Open my 'Home.org' file."
  (interactive)
  (find-file-other-window (concat org-directory "/Home.org")))


;; (defun ladicle/open-org-file (fname)
;;       (switch-to-buffer (find-file-other-frame fname)))

;; archive all done tasks

(defun vix-org-archive-done-tasks ()
  "Archive all DONE tasks starting from the cursor."
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
  "Toggle Markdown editing and Reading mode."
  (interactive)
  (markdown-toggle-markup-hiding)
  (variable-pitch-mode)
  (markdown-toggle-url-hiding)
  (read-only-mode)
  )

(defun delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if filename
        (if (y-or-n-p (concat "Do you really want to delete file " filename " ?"))
            (progn
              (delete-file filename)
              (message "Deleted file %s." filename)
              (kill-buffer)))
      (message "Not a file visiting buffer!"))))

;;Highlight the active window
;; Doesn't work well for some reason, screws up the fonts.
;; (defun highlight-selected-window ()
;;   "Highlight selected window with a different background color."
;;   (walk-windows (lambda (w)
;;                   (unless (eq w (selected-window))
;;                     (with-current-buffer (window-buffer w)
;;                       (buffer-face-set '(:inherit default :background "#e0e0e0"))))))
;;   (buffer-face-set 'default))
;; (add-hook 'buffer-list-update-hook 'highlight-selected-window)

;; (with-eval-after-load 'markdown-mode
;;   (define-key markdown-mode-map (kbd "<C-return>") 'my-markdown-modehange)
;;   )

;; (defun my-split-window-sensibly (&optional window)
;;     "replacement `split-window-sensibly' function which prefers vertical splits"
;;     (interactive)
;;     (let ((window (or window (selected-window))))
;;         (or (and (window-splittable-p window t)
;;                  (with-selected-window window
;;                      (split-window-right)))
;;             (and (window-splittable-p window)
;;                  (with-selected-window window
;;                      (split-window-below))))))

;; (setq split-window-preferred-function #'my-split-window-sensibly)



;; LAST
;; ====

; Load the local settings! (LEAVE THIS LAST!)

