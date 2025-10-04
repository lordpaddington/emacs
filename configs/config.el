;; BASIC SETUP
;; ===========

(require 'package)
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))
;  (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/")))
(unless (assoc-default "org" package-archives)
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  )

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
(setq split-height-threshold 80
      split-width-threshold 100)

(setq track-eol t)			; Keep cursor at end of lines.
(setq line-move-visual nil)		; To be required by track-eol
;(setq-default kill-whole-line t)	; Kill line including '\n'
(setq-default indent-tabs-mode t)   ; nil to use space

(set-terminal-coding-system 'utf-8)
(setq explicit-shell-file-name "/bin/zsh")
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)


;; STYLE
;; =====
(setq custom-safe-themes t) ;;UNSAFE! Set every theme as safe, so there is no confirmation!
(delete-selection-mode 1)
(global-visual-line-mode t)
(scroll-bar-mode -1)
(setq window-divider-default-places t
      window-divider-default-bottom-width 2
      window-divider-default-right-width 2
      )
(window-divider-mode)

;(setq frame-title-format nil)


(setq show-paren-delay 0)
(show-paren-mode)


;;THEME
;;(Use-package solarized-theme)
;;(setq solarized-use-variable-pitch nil)
;;(setq solarized-scaqle-org-headlines nil)
;;(setq x-underline-at-descent-line t)
;;(setq solarized-high-contrast-mode-line t)
;;(load-theme 'solarized-light-high-contrast t)
(use-package doom-themes)
(require 'doom-themes)
;(load-theme 'doom-opera-light) ;Fancy light theme
					;(Load-theme 'zenburn) ;Nice darkish theme
;(load-theme 'doom-zenburn) ; zenburn, but doomed.
;(load-theme 'victory) ;Simple light theme

;;Cursor visibility
(setq-default cursor-type '(bar . 3)) ;; Comment this out if using Evil!!!!
(set-cursor-color "#FF8C00")
(global-hl-line-mode) ; line highlighting.

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




;;System-dependent changes (FUCKING KILL/REFACTOR THIS!!!!)
;; TODO: Consider moving the system-specific settings into separate files!
(cond ((eq system-type 'darwin)
       (set-face-attribute 'default nil :font "iA Writer Mono S 16")
       (setq mac-command-modifier 'meta)
       (setq mac-option-modifier 'none) ;; alt doesn't work, fucks up special characters.
       (load-theme 'doom-nord)
       (use-package ns-auto-titlebar)
       (setq ns-auto-titlebar-mode nil)
       (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
       (add-to-list 'default-frame-alist '(ns-appearance . dark))
       (setq ns-use-proxy-icon nil)
       (global-set-key (kbd "M-h") 'ns-do-hide-emacs)
       (custom-theme-set-faces
	'user
	'(variable-pitch ((t (:family "iA Writer Quattro V"))))
	'(fixed-pitch ((t ( :family "iA Writer Mono S"))))
        '(egoge-display-time ((t (:inherit modeline :foreground "orange" :weight bold :height 1.0))))
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
       (load-theme 'doom-zenburn)
       (set-face-attribute 'default nil :font "Noto Sans Mono 12")
       ;;This sucks, every distro has a different font set...
       (custom-theme-set-faces
	'user
	'(variable-pitch ((t (:family "Noto Sans" :height 120))))
	'(fixed-pitch ((t ( :family "Noto Sans Mono" :height 120))))
	'(egoge-display-time ((t (:inherit modeline :foreground "orange" :weight bold :height 0.9))))
	)
       ;; If using a mac keyboard layout with keyd, this is needed to restore proper modifiers!
       ;; There seems to be no built-in mechanism to swap modifier keys in
       ;; Emacs, but it can be accomplished (for the most part) by
       ;; translating a near-exhaustive list of modifiable keys.  In the case
       ;; of 'control and 'meta, some keys must be omitted to avoid errors or
       ;; other undesired effects.
       (defun my/make-key-string (modsymbol basic-event)
	 "Convert the combination of MODSYMBOL and BASIC-EVENT. BASIC-EVENT can be a character or a function-key symbol. The return value can be used with `define-key'."
	 (vector (event-convert-list `(,modsymbol ,basic-event))))

       ;; Escaped chars are:
       ;; tab return space del backspace (typically translated to del)
       (dolist (char (append '(up down left right menu print scroll pause
			insert delete home end prior next
			tab return space backspace escape
			f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12)
		      ;; Escape gets translated to `C-\[' in `local-function-key-map'
		      ;; We want that to keep working, so we don't swap `C-\[' with `M-\['.
		      (remq ?\[ (number-sequence 33 126))))
  	 ;; Changing this to use `input-decode-map', as it works for more keys.
	 (define-key input-decode-map (my/make-key-string 'control char) (my/make-key-string 'meta char))
 	 (define-key input-decode-map (my/make-key-string 'super char) (my/make-key-string 'control char)))
       )
      )


(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'load-path "~/.emacs.d/packages/")
(fringe-mode 20)
(set-face-attribute 'fringe nil :background nil)
(tool-bar-mode -1)






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
  :bind
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

;; (use-package simple-modeline
;;   :config (simple-modeline-mode))

;; (setq simple-modeline-segments
;;       '((simple-modeline-segment-modified
;; 	 simple-modeline-segment-buffer-name
;; 	 simple-modeline-segment-position)
;; 	(simple-modeline-segment-minor-modes
;; 	 simple-modeline-segment-input-method
;; 	 simple-modeline-segment-vc
;; 	 simple-modeline-segment-misc-info
;; 	 simple-modeline-segment-process
;; 	 simple-modeline-segment-major-mode)))

;; Experimental, leave alone for now.
;(setq-default header-line-format mode-line-format)
;(setq-default mode-line-format nil)

;; (custom-set-faces
;;   '(simple-modeline-status-modified ((t (:foreground "#ee0000")))))

;;Doom modeline
;; (use-package doom-modeline
;;   :ensure t
;;   :init (doom-modeline-mode 1))



;; (custom-set-faces
;;   '(mode-line ((t (:family "Menlo" :height 1.0))))
;;   '(mode-line-active ((t (:family "Menlo" :height 1.0)))) ; For 29+
;;   '(mode-line-inactive ((t (:family "Menlo" :height 1.0)))))


;; (use-package doom-modeline
;;   :ensure t
;;   :init (doom-modeline-mode 1)
;; (setq nerd-icons-scale-factor 1.0)
;; (setq doom-modeline-height 25)
;; (setq doom-modeline-bar-width 4)
;; (setq doom-modeline-hud nil)
;; (setq doom-modeline-window-width-limit 85)
;; (setq doom-modeline-project-detection 'auto)
;; (setq doom-modeline-buffer-file-name-style 'truncate-nil)
;; (setq doom-modeline-icon t)
;; (setq doom-modeline-major-mode-icon t)
;; (setq doom-modeline-major-mode-color-icon t)
;; (setq doom-modeline-buffer-state-icon t)
;; (setq doom-modeline-buffer-modification-icon t)
;; (setq doom-modeline-time-icon nil)
;; (setq doom-modeline-buffer-name t)
;; (setq doom-modeline-highlight-modified-buffer-name t)
;; (setq doom-modeline-column-zero-based t)
;; (setq doom-modeline-percent-position '(-3 "%p"))
;; (setq doom-modeline-position-line-format '("L%l"))
;; (setq doom-modeline-position-column-format '("C%c"))
;; (setq doom-modeline-position-column-line-format '("%l:%c"))
;; (setq doom-modeline-minor-modes nil)
;; (setq doom-modeline-enable-word-count nil)
;; (setq doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode))
;; (setq doom-modeline-buffer-encoding nil)
;; (setq doom-modeline-indent-info nil)
;; (setq doom-modeline-total-line-number nil)
;; (setq doom-modeline-vcs-icon t)
;; (setq doom-modeline-check-icon t)
;; (setq doom-modeline-check-simple-format nil)
;; (setq doom-modeline-number-limit 99)
;; (setq doom-modeline-workspace-name nil)
;; (setq doom-modeline-persp-name nil)
;; (setq doom-modeline-display-default-persp-name nil)
;; (setq doom-modeline-persp-icon nil)
;; (setq doom-modeline-lsp nil)
;; (setq doom-modeline-github nil)
;; (setq doom-modeline-modal t)
;; (setq doom-modeline-modal-icon t)
;; (setq doom-modeline-modal-modern-icon t)
;; (setq doom-modeline-always-show-macro-register nil)
;; (setq doom-modeline-mu4e nil)
;; (setq doom-modeline-gnus nil)
;; (setq doom-modeline-buffer-file-name-function #'identity)
;; (setq doom-modeline-buffer-file-truename-function #'identity))

;; (use-package nerd-icons
;;   :custom
;;   (nerd-icons-font-family "Symbols Nerd Font Mono"))
  



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


;;For centering nicely
(use-package olivetti)
(olivetti-set-width 80) ; Not sure this works, it's buffer local, no idea how to edit the defaults.

;;IVY Autocompletion (keep recent files in the buffer list)
;; TODO Replace this with Vertico and Consult!!!
;; (use-package counsel)
;; (ivy-mode 1)
;; (setq ivy-use-virtual-buffers t)
;; (setq ivy-count-format "(%d/%d) ")
;; (when (commandp 'counsel-M-x)
;;   (global-set-key [remap execute-extended-command] #'counsel-M-x))
;; (global-set-key (kbd "C-x C-b") 'counsel-switch-buffer)
;; (setq ivy-initial-inputs-alist: '((counsel-M-x . "")))


;;Ultra-scroll - nice, smooth scrolling
(use-package ultra-scroll
  ;:vc (:url "https://github.com/jdtsmith/ultra-scroll") ; if desired (emacs>=v30)
  :init
  (setq scroll-conservatively 3 ; or whatever value you prefer, since v0.4
        scroll-margin 0)        ; important: scroll-margin>0 not yet supported
  :config
  (ultra-scroll-mode 1))


;; Enable vertico
(use-package vertico
  :custom
  ;; (vertico-scroll-margin 0) ;; Different scroll margin
  (vertico-count 12) ;; Show more candidates
  (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  ;; (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (vertico-mode))



;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; A few more useful configurations...
(use-package emacs
  :custom
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode))


;; Optionally use the `orderless' completion style.
(use-package orderless
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)) (command (styles partial-completion)))))

;; Annotations in the vertico minibuffer
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))


;; Enable vertico-multiform
(vertico-multiform-mode)

;; Configure the display per completion category.
;; Use the grid display for files and a buffer
;; for the consult-grep commands.
(setq vertico-multiform-categories
      '((file grid)
	(consult-buffer buffer)
        (consult-grep buffer)))


;; Some consult keybindings:
(global-set-key (kbd "C-x b") 'consult-buffer)
(global-set-key (kbd "C-x C-b") 'consult-buffer-other-window)



;; Activate the new window:
; Not convinced if it works, but the functions definitely do. 
(use-package window
  :ensure nil
  :bind (("C-x 2" . vsplit-last-buffer)
         ("C-x 3" . hsplit-last-buffer)
         ;; Don't ask before killing a buffer.
         ([remap kill-buffer] . kill-this-buffer))
  :preface
  (defun hsplit-last-buffer ()
    "Focus to the last created horizontal window."
    (interactive)
    (split-window-horizontally)
    (other-window 1))

  (defun vsplit-last-buffer ()
    "Focus to the last created vertical window."
    (interactive)
    (split-window-vertically)
    (other-window 1)))

;;MAGIT
(use-package magit)
;; How to set up the credentials: https://docs.github.com/en/get-started/getting-started-with-git/caching-your-github-credentials-in-gitq
;; If anything doesn't work, this is the trick!!!

;;Zettelkasten implementation
;; (use-package deft
;;   :init
;;     (setq deft-extensions '("org" "md" "txt")
;;           deft-use-filename-as-title nil
;; 	  deft-use-filter-string-for-filename nil
;; 	  deft-recursive t
;; 	  deft-text-mode 'org-mode
;; 	  deft-org-mode-title-prefix t
;; 	  )       
;;   :bind
;;   ([f8] . deft)
;;   ("C-c d n" . deft-new-file-named)
;;   ("C-c d d" . deft))

;; (setq deft-file-naming-rules '((nospace . "_")
;;                                    (case-fn . downcase)))


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
  (olivetti-mode)
  )
  
  (setq markdown-link-space-sub-char " ")

(add-hook 'markdown-mode-hook 'variable-pitch-mode 'adaptive-wrap-prefix-mode 'olivetti-mode)
(setq markdown-indent-on-enter 'indent-and-new-item
      markdown-make-gfm-checkboxes-buttons t
      markdown-gfm-uppercase-checkbox t)

;;Python
(use-package jedi)
(add-hook 'python-mode-hook 'display-line-numbers-mode 'jedi:setup)
(setq python-shell-interpreter "/usr/local/bin/python") ;; shell path to the python env
(setq jedi:complete-on-dot t)                 ; optional

;; (setq jedi:environment-root "jedi")  ; or any other name you like
;; (setq jedi:environment-virtualenv
;;       (append python-environment-virtualenv
;;               '("--python" "/usr/local/bin/python")))




;;Org Mode
(load-file "~/.emacs.d/local.el")
(use-package org
  :config
  (add-hook 'org-mode-hook 'centered-cursor-mode)
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

(add-hook 'org-mode-hook 'centered-cursor-mode)
(add-hook 'org-mode-hook 'variable-pitch-mode)
(add-hook 'org-mode-hook 'olivetti-mode)
(setq org-display-inline-images t)

;;Stop inserting newlines after headings:
(setf org-blank-before-new-entry '((heading . nil) (plain-list-item . nil)))

(require 'org-indent)
;(set-face-attribute 'org-block nil            :foreground nil :inherit 'fixed-pitch :height 0.85)
;; (set-face-attribute 'org-code nil             :inherit '(shadow fixed-pitch) :height 0.85)
(set-face-attribute 'org-indent nil           :inherit '(org-hide fixed-pitch) :height 0.80)
;; (set-face-attribute 'org-verbatim nil         :inherit '(shadow fixed-pitch) :height 0.85)
;; (set-face-attribute 'org-special-keyword nil  :inherit '(font-lock-comment-face
;; fixed-pitch))
;; (set-face-attribute 'org-meta-line nil        :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil         :inherit 'fixed-pitch)

(setq org-src-fontify-natively t
	  org-src-tab-acts-natively t
      org-edit-src-content-indentation 0)



(use-package org-appear
  :commands (org-appear-mode)
  :hook     (org-mode . org-appear-mode)
  :config
  (setq org-hide-emphasis-markers t)  ; Must be activated for org-appear to work
  (setq org-appear-autoemphasis   t   ; Show bold, italics, verbatim, etc.
        org-appear-autolinks      t   ; Show links
		org-appear-autosubmarkers t)) ; Show sub- and superscripts

(use-package org-download)
(use-package org-bullets  
  :hook
  (org-mode . (lambda () (org-bullets-mode 1)))
  )


(setq org-log-done                       t
	  org-auto-align-tags                t
	  org-tags-column                    -80
	  org-fold-catch-invisible-edits     'show-and-error
	  org-special-ctrl-a/e               t
	  org-insert-heading-respect-content t)


;;Org Capture Templates
(setq org-inbox (concat org-directory "/In"))
(setq org-projects (concat org-directory "/Projects"))

;;(setq org-refile-use-outline-path 'file) - ez lehet kell a refile mukodesehez.
;;FUCKING MOVE THIS INTO LOCAL!!!
(defvar inbox (expand-file-name "Inbox.org" org-inbox))
(defvar todo (expand-file-name "20241218092003-next_actions.org" org-directory))
;(defvar reference (expand-file-name "Reference" org-directory))
(defvar minutes (expand-file-name "Minutes" org-directory))
(defvar someday (expand-file-name "20241218092219-someday_maybe.org" org-directory))
(defvar scheduled (expand-file-name "20241218093247-upcoming.org" org-directory))
(defvar reference (expand-file-name "Reference" org-directory))
(defvar home (expand-file-name "20241216100616-the_hub.org" org-directory))

(defun my/generate-minute-name ()
  (setq my-minute--name (read-string "Meeting Title: "))
  (setq my-minute--date (format-time-string "%Y-%m-%d"))
  (expand-file-name (format "%s - %s.org" my-minute--date my-minute--name ) minutes))

(setq org-capture-templates
      '(
        ("t" "Todo" entry (file+headline todo "Next Actions")
         "* TODO %?\n")
        ("n" "Quick Note" entry (file+headline home "Notes")
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

(setq org-agenda-files (list home todo scheduled))

(setq org-M-RET-may-split-line '((item . nil))) ;;M-RET to insert a new line anywhere!


(require 'org-indent)
;; Some customized org faces (Dunno why it's not working...)
;;(set-face-attribute 'org-block nil            :foreground 'unspecified :inherit 'fixed-pitch :height 0.85)
;;(set-face-attribute 'org-code nil             :inherit '(shadow fixed-pitch) :height 0.85)
(set-face-attribute 'org-indent nil           :inherit '(org-hide fixed-pitch) :height 1.0)
;(set-face-attribute 'org-verbatim nil         :inherit '(font-lock-number) :height 1)
;(set-face-attribute 'org-special-keyword nil  :inherit '(shadow fixed-pitch) :height 0.80)
;(set-face-attribute 'org-meta-line nil        :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-checkbox nil         :inherit '(fixed-pitch) :foreground "teal" :height 1.0 :weight 'semibold)






;;Move focus to new window
(use-package window
    :ensure nil
    :preface
    (defun hsplit-last-buffer ()
      "Focus to the last created horizontal window."
      (interactive)
      (split-window-horizontally)
      (other-window 1))
    (defun vsplit-last-buffer ()
      "Focus to the last created vertical window."
      (interactive)
      (split-window-vertically)
      (other-window 1)))
    (global-set-key (kbd "C-x C-1") #'delete-other-windows)
    (global-set-key (kbd "C-x C-2") #'vsplit-last-buffer)
    (global-set-key (kbd "C-x C-3") #'hsplit-last-buffer)
    (global-set-key (kbd "C-x C-0") #'delete-window)

;;Scratch in the current mode:
(use-package scratch)
  (global-set-key (kbd "C-c s") 'scratch)



;;Org-roam
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/Orgmode")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
	 ("C-c n d" . org-roam-dailies-find-date)
	 ("C-c n j" . org-roam-dailies-goto-today)
	 ("C-c n d" . org-roam-dailies-find-date)
         ("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-setup))
(org-roam-db-autosync-mode)

(add-to-list 'display-buffer-alist
             '("\\*org-roam\\*"
               (display-buffer-in-direction)
               (direction . right)
               (window-width . 0.33)
               (window-height . fit-window-to-buffer)))

;; Consult for Org Roam
(use-package consult-org-roam
   :ensure t
   :after org-roam
   :init
   (require 'consult-org-roam)
   ;; Activate the minor mode
   (consult-org-roam-mode 1)
   :custom
   ;; Use `ripgrep' for searching with `consult-org-roam-search'
   (consult-org-roam-grep-func #'consult-ripgrep)
   ;; Configure a custom narrow key for `consult-buffer'
   (consult-org-roam-buffer-narrow-key ?r)
   ;; Display org-roam buffers right after non-org-roam buffers
   ;; in consult-buffer (and not down at the bottom)
   (consult-org-roam-buffer-after-buffers t)
   :config
   ;; Eventually suppress previewing for certain functions
   (consult-customize
    consult-org-roam-forward-links
    :preview-key "M-.")
   :bind
   ;; Define some convenient keybindings as an addition
   ("C-c n e" . consult-org-roam-file-find)
   ("C-c n b" . consult-org-roam-backlinks)
   ("C-c n B" . consult-org-roam-backlinks-recursive)
   ("C-c n l" . consult-org-roam-forward-links)
   ("C-c n r" . consult-org-roam-search))

;;Hide minor modes in the modeline into a menu:
(use-package minions)
(minions-mode)


;; FUNCTIONS
;; =========

;; insert current date
(defun vix-insert-current-date ()
  (interactive)
  "Insert todays date in YYYY-MM-DD format."
  (insert (shell-command-to-string "echo -n $(date +%Y-%m-%d)")))

;; Insert date as an org heading
(defun vix-insert-date-heading ()
  (interactive)
  "Insert todays date in YYYY-MM-DD format."
  (insert "\n\n* " (shell-command-to-string "echo -n $(date +'%Y-%m-%d, %A')" ) "\n"))


;; (defun vix-open-todays-journal ()
;;   "Display today's journal file."
;;   (interactive)
;;   (find-file-other-window (concat org-directory (format-time-string "/Journal/%Y-%m-%d %A.org"))))
;; Obsolete if I'm using org-roam.

(defun vix/open-home-file ()
  "Open the hub file (set as 'home' in orgmode)."
  (interactive)
  (find-file-other-window home))



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

(defun vix/kill-and-close ()
    (interactive)
    (kill-this-buffer)
    (delete-window)
    
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

(defun nuke-all-buffers ()
  "Kill all buffers, leaving *scratch* only."
  (interactive)
  (mapc
   (lambda (buffer)
     (kill-buffer buffer))
   (buffer-list))
  (delete-other-windows))

;; Custom function for full-text search in roam!!!
(defun bms/org-roam-rg-search ()
  "Search org-roam directory using consult-ripgrep. With live-preview."
  (interactive)
  (let ((consult-ripgrep-command "rg --null --ignore-case --type org --line-buffered --color=always --max-columns=500 --no-heading --line-number . -e ARG OPTS"))
    (consult-ripgrep org-roam-directory)))
(global-set-key (kbd "C-c rr") 'bms/org-roam-rg-search)


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


;; Fuck, for some reason this prefers opening a new frame...
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
;; (setq split-window-preferred-function 'my-split-window-sensibly)

(defun window-split-toggle ()
  "Toggle between horizontal and vertical split with two windows."
  (interactive)
  (if (> (length (window-list)) 2)
      (error "Can't toggle with more than 2 windows!")
    (let ((func (if (window-full-height-p)
                    #'split-window-vertically
                  #'split-window-horizontally)))
      (delete-other-windows)
      (funcall func)
      (save-selected-window
        (other-window 1)
        (switch-to-buffer (other-buffer))))))

;; Insert date as a link to the daily.
;; TODO Not working need to check out if I can fix it...
(defun matt/org-roam-dailies-insert-date ()
  (interactive)
  (save-window-excursion (save-excursion
                            (org-roam-dailies-goto-date)
                            (save-buffer)
                            (org-store-link nil 'not-interactive)
                            (let* ((id (car (car org-stored-links)))
                                  (description (org-roam--file-keyword-get "TITLE"))
                                  (updated (list id description)))
                              (setq org-stored-links (cons updated (cdr org-stored-links))))))
  (call-interactively 'matt/org-insert-last-stored-link-without-newline))

(defun matt/org-insert-last-stored-link-without-newline (arg)
  "Insert the last link stored in `org-stored-links' like
`org-insert-last-stored-link', but without a trailing newline."
  (interactive "p")
  (org-insert-all-links arg "" ""))


(defun org-roam-node-insert-immediate (arg &rest args)
  "Insert link to a roam-node without opening the capture window"
  (interactive "P")
  (let ((args (cons arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))

(setq desktop-restore-forces-onscreen nil)


;; Custom Keybindings
;; ==================
;; Might make more sense at the end when everything is already loaded.
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
;;(global-set-key (kbd "C-c n j") 'org-roam-dailies-goto-today)
(global-set-key (kbd "C-c v h") 'vix/open-home-file)

(global-set-key (kbd "C-x k") 'vix/kill-and-close)


;; LAST
;; ====

; Load the local settings! (LEAVE THIS LAST!)

