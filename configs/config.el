
;;MAC SPECIFIC - put it in an ifmac
(cond ((eq system-type 'darwin)       
       (setq mac-command-modifier 'meta)
       (setq mac-option-modifier 'none)
       (add-to-list 'default-frame-alist '(ns-transparent-titlebar))
       (add-to-list 'default-frame-alist '(ns-appearance . light))
       (setq org-directory "~/Dropbox/org")
       (set-face-attribute 'default nil :font "Consolas 17")))

;;WINDOWS SPECIFIC:
(cond ((eq system-type 'windows-nt)
       (setq org-directory "C:/Users/Viktor/org")
       (setq org-roam-db-location "C:/Users/Viktor/org/notes")
       (add-to-list 'exec-path "C:/Users/Viktor/usr/sqlite3")
       (menu-bar-mode 1)
       (set-face-attribute 'default nil :font "Consolas 15")))

;;set up package management
(require 'package)
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/")))
(unless (assoc-default "org" package-archives)
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-verbose t)
(setq use-package-always-ensure t)
(use-package auto-compile
  :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)
(setq custom-safe-themes t) ;;UNSAFE! Set every theme as safe, so there is no confirmation!


(use-package restart-emacs
  :ensure t
  :bind* (("C-x M-c" . restart-emacs)))

;;BASICS
(global-visual-line-mode t)
(desktop-save-mode 1)
(setq desktop-load-locked-desktop t)
(scroll-bar-mode 0)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(prefer-coding-system 'utf-8)
(setq ring-bell-function 'ignore)
(setq show-paren-delay 0)
(show-paren-mode)
;;(blink-cursor-mode -1)

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
(fringe-mode 10)
;;(set-face-attribute 'mode-line nil :font "Courier-13") - faszért nem működik rendesen?!?!?

;;THEMES
;;(use-package solarized-theme)
;;(setq solarized-use-variable-pitch nil)
;;(setq solarized-scale-org-headlines nil)
;;(setq x-underline-at-descent-line t)
;;(setq solarized-high-contrast-mode-line t)
;;(load-theme 'solarized-light-high-contrast t)
(use-package doom-themes)
(load-theme 'doom-opera-light)
(set-face-attribute 'fringe nil :background nil)
(tool-bar-mode -1)



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


(use-package term)

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
;(use-package smex
;  :ensure t
;  :config
;  (smex-initialize))

;;IVY Autocompletion
(use-package counsel)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")


;;DEFT
(setq deft-directory (concat org-directory "/notes"))
(use-package deft)
(setq deft-default-extension "org")
(setq deft-recursive t)
(setq deft-use-filename-as-title nil)
(setq deft-use-filter-string-for-filename t) ;Ez miez?
(setq deft-file-naming-rules '((noslash . "-")
                                   (nospace . "-")
                                   (case-fn . downcase)))
(setq deft-text-mode 'org-mode)
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


(setq org-roam-directory deft-directory)
(use-package org-roam
  :ensure t
  :hook
  (after-init . org-roam-mode)
  :bind (:map org-roam-mode-map
              (("C-c r l" . org-roam)
               ("C-c r f" . org-roam-find-file-immediate)
               ("C-c r g" . org-roam-graph))
              :map org-mode-map
              (("C-c r i" . org-roam-insert))
              (("C-c r I" . org-roam-insert-immediate))))

;;MAGIT
(use-package magit)


;;ORG Setup
;;=========
(setq org-startup-indented t
      org-hide-leading-stars t
      org-startup-folded "content"
      org-agenda-start-on-weekday 1)

(setq org-agenda-files '("~/Dropbox/org")) ;;Warning, ezzel majd csinálni kell Windowson!!!

;;Strikethrough DONE regardless of the theme
(setq org-fontify-done-headline t)
(custom-set-faces
 '(org-done ((t (:weight normal
                 :strike-through t))))
 '(org-headline-done
   ((t (:strike-through t)))))

;; The following lines are always needed.  Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-xg" 'magit-status)
(global-set-key "\C-cd" 'deft)

;; Archive all done tasks
(defun my-org-archive-done-tasks ()
  (interactive)
  (org-map-entries 'org-archive-subtree "/DONE" 'file))

;;Do stuff only after Org is loaded:
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "<M-left>") 'beginning-of-line)
  (define-key org-mode-map (kbd "<M-right>") 'end-of-line)
  (centered-cursor-mode))

;; Capture Templates
(defvar notepad (expand-file-name "Notepad.org" org-directory))
(defvar todo (expand-file-name "Todo.org" org-directory))
(defvar journal (expand-file-name "Journal.org" org-directory))
(defvar reference (expand-file-name "Reference" org-directory))

(defun my/generate-org-note-name ()
  (setq my-org-note--name (read-string "Filename: "))
  (setq my-org-note--time (format-time-string "%Y%m%d%H%M%S"))
  (expand-file-name (format "%s-%s.org" my-org-note--time my-org-note--name) org-directory))

(defun my/generate-markdown-note-name ()
  (setq my-org-note--name (read-string "Filename: "))
  (expand-file-name (format "%s.md" my-org-note--name) reference))


(setq org-capture-templates
      '(
        ("t" "Todo" entry (file+headline todo "Tasks:")
         "* TODO %?\n")
        ("n" "Note" entry (file notepad)
         "* %U %?\n " :prepend t)
        ("a" "Action item" entry (file+headline (lambda() (buffer-file-name)) "ACTIONS:")
         "* TODO %?\n")
	;;("w" "Work-Task" entry (file+headline "c:/Users/vweyde/wOrg/Actions/Tasks.org" "Unfiled:")
        ;; "* TODO %?\n")
	;;("j" "Journal entry" plain (file+olp+datetree journal) "**** %<%H:%M>\n%?\n")
	("N" "New OrgMode note" plain (file my/generate-org-note-name) "%(format \"#+TITLE: %s\n#+DATE:  %s\n\" my-org-note--name my-org-note--time)\n%?\n")
	("M" "New markdown reference" plain (file my/generate-markdown-note-name) "%(format \"# %s\n\" my-org-note--name)\n%?\n")
       )
      )

