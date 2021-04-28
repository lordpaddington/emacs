;;(setq desktop-dirname "~/.emacs.d/")
;;(desktop-read)


;;set up package management





;;BASICS


;;Set face depending on mode
;TODO: fix this, make it system dependent, I'm sure it fucks everything up on windows...

;Note-this most likely doesn't fucking work... :(



;;MAC SPECIFIC

 ;; This should be set only for Org and Markdown, like this
;; (add-hook 'org-mode-hook 'visual-line-mode)


;;(blink-cursor-mode -1)



;;Custom keybindings

;;Visuals
 ;this is usually 10 only.
;;(set-face-attribute 'mode-line nil :font "Courier-13") - faszért nem működik rendesen?!?!?



;;NEOTREE as default
;(use-package neotree)
;(neotree-show)
;(setq neo-window-width 50)
;(setq neo-window-fixed-size nil)
;(global-set-key [f8] 'neotree-toggle)
;(setq neo-smart-open t)


;;TREEMACS FTW



;;MODELINE


;;Easy switch windows






;;smex is an amazing program that helps order the M-x commands based on usage and recent items.
(use-package smex
  :config
  (smex-initialize))
;; fogalmam sincs, hogy ez hogy működik...


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


;;EVIL MODE
;; Set up package.el to work with MELPA

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
;(require 'evil)
;(evil-mode)



;;ORG Setup
;;=========


;; The following lines are always needed.  Choose your own keys.




;;Do stuff only after Org is loaded:

(add-hook 'org-mode-hook 'org-display-inline-images)

(use-package org-bullets)
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;Org font customizations
(add-hook 'org-mode-hook 'variable-pitch-mode 'centered-cursor-mode)
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




;; ORg config from ladicle
(use-package org
    :custom
    (org-src-fontify-natively t)
    (Private-directory "~/Private/")
    (task-file (concat private-directory "task.org"))
    (schedule-file (concat private-directory "schedule.org"))
    (org-directory private-directory)
    (org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")
    (org-plantuml-jar-path "~/.emacs.d/plantuml.jar")
    (org-confirm-babel-evaluate nil)
    (org-clock-out-remove-zero-time-clocks t)
    (org-startup-folded 'content)
    (org-columns-default-format "%50ITEM(Task) %5TODO(Todo) %10Effort(Effort){:} %10CLOCKSUM(Clock) %2PRIORITY %TAGS")
    (org-agenda-columns-add-appointments-to-effort-sum t)
    (org-agenda-span 'day)
    (org-agenda-log-mode-items (quote (closed clock)))
    (org-agenda-clockreport-parameter-plist
      '(:maxlevel 5 :block t :tstart t :tend t :emphasize t :link t :narrow 80 :indent t :formula nil :timestamp t :level 5 :tcolumns nil :formatter nil))
    (org-global-properties (quote ((
      "Effort_ALL" . "00:05 00:10 00:15 00:30 01:00 01:30 02:00 02:30 03:00"))))
    (org-agenda-files (quote (
      "~/Private/task.org"
      "~/Private/routine.org"
      "~/Private/task.org_archive"
      "~/Private/schedule.org")))
    :custom-face
    (org-link ((t (:foreground "#ebe087" :underline t))))
    (org-list-dt ((t (:foreground "#bd93f9"))))
    (org-special-keyword ((t (:foreground "#6272a4"))))
    (org-todo ((t (:background "#272934" :foreground "#51fa7b" :weight bold))))
    (org-document-title ((t (:foreground "#f1fa8c" :weight bold))))
    (org-done ((t (:background "#373844" :foreground "#216933" :strike-through nil :weight bold))))
    (org-footnote ((t (:foreground "#76e0f3"))))
    ;; do not scale outline header
    ;; (org-level-1 ((t (:inherit outline-1 :height 1.0))))
    ;; (org-level-2 ((t (:inherit outline-2 :height 1.0))))
    ;; (org-level-3 ((t (:inherit outline-3 :height 1.0))))
    ;; (org-level-4 ((t (:inherit outline-4 :height 1.0))))
    ;; (org-level-5 ((t (:inherit outline-5 :height 1.0))))
    :bind (("M-o c" . counsel-org-capture)
           ("M-o a" . org-agenda)
           ("C-x C-l" . org-store-link)
           :map org-mode-map
           ("C-c i" . org-clock-in)
           ("C-c o" . org-clock-out)
           ("C-c n" . org-narrow-to-subtree)
           ("C-c b" . org-narrow-to-block)
           ("C-c w" . widen)
           ("C-c e" . org-set-effort)
           ;; custom functions
           ("C-c 1" . (lambda () (interactive) (org-cycle-list-bullet 2)))
           ("M-o l i" . (lambda () (interactive) (ladicle/open-org-file task-file)))
           ("M-o l s" . (lambda () (interactive) (ladicle/open-org-file schedule-file)))
           ("M-o l y" . (lambda () (interactive) (ladicle/open-org-file (ladicle/get-yesterday-diary))))
           ("M-o l p" . (lambda () (interactive) (ladicle/open-org-file (ladicle/get-diary-from-cal))))
           ("M-o l t" . (lambda () (interactive) (ladicle/open-org-file (ladicle/get-today-diary)))))
    :hook
    (kill-emacs . ladicle/org-clock-out-and-save-when-exit)
    (org-clock-in .
                (lambda ()
                  (setq org-mode-line-string (ladicle/task-clocked-time))
                  (run-at-time 0 60 '(lambda ()
                                       (setq org-mode-line-string (ladicle/task-clocked-time))
                                       (force-mode-line-update)))
                  (force-mode-line-update)))
    (org-mode . (lambda ()
                       (dolist (key '("C-'" "C-," "C-."))
                         (unbind-key key org-mode-map))))
    :preface
    (defun ladicle/get-today-diary ()
      (concat private-directory
        (format-time-string "diary/%Y/%m/%Y-%m-%d.org" (current-time))))
    (defun ladicle/get-yesterday-diary ()
      (concat private-directory
        (format-time-string "diary/%Y/%m/%Y-%m-%d.org" (time-add (current-time) (* -24 3600)))))
    (defun ladicle/get-diary-from-cal ()
      (concat private-directory
        (format-time-string "diary/%Y/%m/%Y-%m-%d.org"
          (apply 'encode-time (parse-time-string (concat (org-read-date) " 00:00"))))))
    (defun ladicle/open-org-file (fname)
      (switch-to-buffer (find-file-noselect fname)))
    (defun ladicle/org-get-time ()
      (format-time-string "<%H:%M>" (current-time)))
    (defun ladicle/code-metadata ()
      (concat ":" (projectile-project-name) ":"))
    (defun ladicle/org-clock-out-and-save-when-exit ()
        "Save buffers and stop clocking when kill emacs."
          (ignore-errors (org-clock-out) t)
          (save-some-buffers t))
    (defun ladicle/task-clocked-time ()
        "Return a string with the clocked time and effort, if any"
        (interactive)
        (let* ((clocked-time (org-clock-get-clocked-time))
               (h (truncate clocked-time 60))
               (m (mod clocked-time 60))
               (work-done-str (format "%d:%02d" h m)))
          (if org-clock-effort
              (let* ((effort-in-minutes
                      (org-duration-to-minutes org-clock-effort))
                     (effort-h (truncate effort-in-minutes 60))
                     (effort-m (truncate (mod effort-in-minutes 60)))
                     (effort-str (format "%d:%02d" effort-h effort-m)))
                (format "%s/%s" work-done-str effort-str))
            (format "%s" work-done-str))))
    :config
    ;; Pomodoro
    (use-package org-pomodoro
    :after org-agenda
    :custom
    (org-pomodoro-ask-upon-killing t)
    (org-pomodoro-format "%s") ;;     
    (org-pomodoro-short-break-format "%s")
    (org-pomodoro-long-break-format  "%s")
    :custom-face
    (org-pomodoro-mode-line ((t (:foreground "#ff5555"))))
    (org-pomodoro-mode-line-break   ((t (:foreground "#50fa7b"))))
    :hook
    (org-pomodoro-started . (lambda () (notifications-notify
                                               :title "org-pomodoro"
                                               :body "Let's focus for 25 minutes!"
                                               :app-icon "~/.emacs.d/img/001-food-and-restaurant.png")))
    (org-pomodoro-finished . (lambda () (notifications-notify
                                               :title "org-pomodoro"
                                               :body "Well done! Take a break."
                                               :app-icon "~/.emacs.d/img/004-beer.png")))
    :config
    (when (eq system-type 'darwin)
      (setq alert-default-style 'osx-notifier))
    (require 'alert)

    :bind (:map org-agenda-mode-map
                ("p" . org-pomodoro)))

    (setq org-agenda-current-time-string "← now")
    (setq org-agenda-time-grid ;; Format is changed from 9.1
        '((daily today require-timed)
          (0900 01000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2100 2200 2300 2400)
          "-"
          "────────────────"))
    (setq org-todo-keyword-faces
            '(("WAIT" . (:foreground "#6272a4":weight bold))
              ("NEXT"   . (:foreground "#f1fa8c" :weight bold))
              ("CARRY/O" . (:foreground "#6272a4" :background "#373844" :weight bold))))
    (setq org-capture-templates
          '(("tweet" "Write down the thoughts of this moment with a timestamp." item
             (file+headline ladicle/get-today-diary "Log")
             "%(ladicle/org-get-time) %? \n")
            ;; memo
            ("memo" "Memorize something in the memo section of today's diary." entry
             (file+headline ladicle/get-today-diary "Memo")
             "** %? \n"
             :unnarrowed 1)
            ;; tasks
            ("inbox" "Create a general task to the inbox and jump to the task file." entry
             (file+headline "~/Private/task.org" "Inbox")
             "** TODO %?"
             :jump-to-captured 1)
            ("interrupt-task" "Create an interrupt task to the inbox and start clocking." entry
             (file+headline "~/Private/task.org" "Inbox")
             "** TODO %?"
             :jump-to-captured 1 :clock-in 1 :clock-resume 1)
            ("hack-emacs" "Collect hacking Emacs ideas!" item
             (file+headline "~/Private/task.org" "Hacking Emacs")
             "- [ ] %?"
             :prepend t)
            ("private-schedule" "Add an event to the private calendar." entry
             (file+olp schedule-file "Calendar" "2019" "Private")
             "** %?\n   SCHEDULED: <%(org-read-date)>\n"
             :prepend t)
            ("work-schedule" "Add an event to the work calendar." entry
             (file+olp schedule-file "Calendar" "2019" "Work")
             "** %?\n   SCHEDULED: <%(org-read-date)>\n")
            ("store-link" "Store the link of the current position in the clocking task." item
             (clock)
             "- %A\n"
             :immediate t :prepend t)
            ;; code-reading
            ("code-link" "Store the code reading memo to today's diary with metadata." entry
             (file+headline ladicle/get-today-diary "Code")
             ;;(file+headline ladicle/get-today-diary "Code")
             "** %? %(ladicle/code-metadata)\n%A\n")))

    ;; delete unused modules
    (setq org-modules (delete '(org-gnus org-w3m org-bbdb org-bibtex org-docview org-info org-irc org-mhe org-rmail org-eww) org-modules))
    ;; load org-protocol for capturing websites
    (use-package org-protocol
      :ensure nil)
    ;; load babel languages
    (org-babel-do-load-languages
         'org-babel-load-languages
         '((dot . t)
           (plantuml . t)
           (latex . t)
           (R . t)))
    ;; Pretty bullets
    (use-package org-bullets
      :custom (org-bullets-bullet-list '("" "" "" "" "" "" "" "" "" ""))
      :hook (org-mode . org-bullets-mode))
  (use-package ox-hugo
    :after ox
    :custom
    (org-blackfriday--org-element-string '((src-block . "Code")
                                              (table . "Table")
                                              (figure . "Figure"))))
    ;; Download Drag&Drop images
    (use-package org-download)

  (with-eval-after-load 'hydra
    (eval-and-compile
      (defun hot-expand (str &optional mod)
        "Expand org template."
        (let (text)
          (when (region-active-p)
            (setq text (buffer-substring (region-beginning) (region-end)))
            (delete-region (region-beginning) (region-end)))
          (insert str)
          (org-try-structure-completion)
          (when mod (insert mod) (forward-line))
          (when text (insert text)))))

    (defhydra hydra-org-template (:color blue :hint nil)
      (format "   %s^^     %s^^^^       %s^^^^^        %s
%s
  %s _e_lisp      %s _h_ugo        %s plant_u_ml      %s _s_ource
  %s _r_uby       %s _c_aption     %s La_t_ex         %s _n_ote
  %s _f_ish       %s _l_ink        %s i_P_ython       %s _i_nfo
  %s _b_ash       %s %s^^^^^       %s %s^^^^          %s qu_o_te
  %s _g_o
  %s _y_aml
%s
                     %s quit%s insert
"
(concat (propertize "((" 'face `(:foreground "#6272a4"))
        (propertize "CODE" 'face `(:foreground "#ff79c6" :weight bold))
        (propertize "))" 'face `(:foreground "#6272a4")))
(concat (propertize "((" 'face `(:foreground "#6272a4"))
        (propertize "META" 'face `(:foreground "#ff79c6" :weight bold))
        (propertize "))" 'face `(:foreground "#6272a4")))
(concat (propertize "((" 'face `(:foreground "#6272a4"))
        (propertize "DRAW" 'face `(:foreground "#ff79c6" :weight bold))
        (propertize "))" 'face `(:foreground "#6272a4")))
(concat (propertize "((" 'face `(:foreground "#6272a4"))
        (propertize "BLOCK" 'face `(:foreground "#ff79c6" :weight bold))
        (propertize "))" 'face `(:foreground "#6272a4")))

(propertize " ──────────────────────────────────────────────────────────── " 'face `(:foreground "#6272a4"))
;; L1
(all-the-icons-fileicon "emacs" :v-adjust .00001 :height .68 :face '(:foreground "#6272a4"))
(all-the-icons-material "web" :v-adjust -.1 :height .7 :face '(:foreground "#6272a4"))
(all-the-icons-material "format_shapes" :v-adjust -.15 :height .7 :face '(:foreground "#6272a4"))
(all-the-icons-octicon "code" :v-adjust -.05 :height .75  :face '(:foreground "#6272a4"))
;; L2
(all-the-icons-alltheicon "ruby-alt" :v-adjust .0505 :height .7 :face '(:foreground "#6272a4"))
(all-the-icons-faicon "flag" :v-adjust -.05 :height .69  :face '(:foreground "#6272a4"))
(all-the-icons-faicon "text-height" :v-adjust -.05 :height .69 :face '(:foreground "#6272a4"))
(all-the-icons-octicon "light-bulb" :v-adjust -.1 :height .78 :face '(:foreground "#6272a4"))
;; L3
(all-the-icons-alltheicon "script" :v-adjust .05 :height .7 :face '(:foreground "#6272a4"))
(all-the-icons-faicon "link" :v-adjust -.05 :height .69 :face '(:foreground "#6272a4"))
(all-the-icons-fileicon "test-python" :v-adjust -.1 :height .75 :face '(:foreground "#6272a4"))
(all-the-icons-faicon "info-circle" :v-adjust -.1 :height .72 :face '(:foreground "#6272a4"))
;; L4
(all-the-icons-alltheicon "script" :v-adjust .05 :height .7 :face '(:foreground "#6272a4"))
(all-the-icons-fileicon "test-python" :v-adjust -.1 :height .7 :face '(:foreground "#282a36")) ;; dummy
(propertize "link" 'face `(:foreground "#282a36"))
(all-the-icons-fileicon "test-python" :v-adjust -.1 :height .7 :face '(:foreground "#282a36")) ;; dummy
(propertize "latex" 'face `(:foreground "#282a36"))
(all-the-icons-faicon "quote-right" :v-adjust -.05 :height .65 :face '(:foreground "#6272a4"))
;; L5
(all-the-icons-fileicon "go" :v-adjust -.1 :height .75 :face '(:foreground "#6272a4"))
;; L6
(all-the-icons-octicon "settings" :v-adjust -.1 :height .75 :face '(:foreground "#6272a4"))
;; Draw
(propertize " ┌──────────────────────────────────────────────────────────┘ " 'face `(:foreground "#6272a4"))
(propertize "[_q_]:" 'face `(:foreground "#6272a4"))
(propertize ", [_<_]:" 'face `(:foreground "#6272a4"))
)
      ("s" (hot-expand "<s"))
      ("o" (hot-expand "<q"))
      ("c" (hot-expand "<c"))
      ("t" (hot-expand "<L"))
      ("c" (insert "#+CAPTION: "))
      ("l" (insert "#+NAME: "))
      ("n" (insert "#+BEGIN_NOTE\n\n#+END_NOTE"))
      ("i" (insert "#+BEGIN_INFO\n\n#+END_INFO"))
      ("h" (insert ":PROPERTIES:\n:EXPORT_FILE_NAME:\n:EXPORT_HUGO_SECTION: pages\n:EXPORT_HUGO_TAGS:\n:EXPORT_HUGO_CATEGORIES:\n:END:"))
      ("e" (hot-expand "<s" "emacs-lisp"))
      ("f" (hot-expand "<s" "fish"))
      ("b" (hot-expand "<s" "bash"))
      ("y" (hot-expand "<s" "yaml"))
      ("P" (hot-expand "<s" "ipython :session :exports both :async :cache yes :results raw drawer\n$0"))
      ("g" (hot-expand "<s" "go"))
      ("r" (hot-expand "<s" "ruby"))
      ("S" (hot-expand "<s" "sh"))
      ("u" (hot-expand "<s" "plantuml :file overview.svg :cache yes :cmdline -config \"$HOME/Private/style.uml\" :async"))
      ("<" self-insert-command)
      ("q" nil))

    (bind-key "<"
              (lambda () (interactive)
                (if (or (region-active-p) (looking-back "^\s*" 1))
                    (hydra-org-template/body)
                  (self-insert-command 1)))
              org-mode-map))
)



