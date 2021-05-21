;;; victory-theme.el --- Tango-based custom theme for faces  -*- lexical-binding:t -*-

;; Copyright (C) 2010-2021 Free Software Foundation, Inc.

;; Authors: Chong Yidong <cyd@stupidchicken>
;;          Jan Moringen <jan.moringen@uni-bielefeld.de>

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary

;; The colors in this theme come from the Tango palette, which is in
;; the public domain: http://tango.freedesktop.org/

;;; Code:

(deftheme victory
  "Face colors using the Tango palette (light background).
Basic, Font Lock, Isearch, Gnus, Message, Ediff, Flyspell,
Semantic, and Ansi-Color faces are included.")

(let (
  ;; Tango palette colors.
  (butter-1 "#fce94f")
  (butter-2 "#edd400")
  (butter-3 "#c4a000")
  (orange-1 "#fcaf3e")
  (orange-2 "#f57900")
  (orange-3 "#ce5c00")
  (choc-1 "#e9b96e")
  (choc-2 "#c17d11")
  (choc-3 "#8f5902")
  (cham-1 "#8ae234")
  (cham-2 "#73d216")
  (cham-3 "#4e9a06")
  (blue-1 "#729fcf")
  (blue-2 "#3465a4")
  (blue-3 "#204a87")
  (plum-1 "#ad7fa8")
  (plum-2 "#75507b")
  (plum-3 "#5c3566")
  (red-1 "#ef2929")
  (red-2 "#cc0000")
  (red-3 "#a40000")
  (alum-1 "#eeeeec")
  (alum-2 "#d3d7cf")
  (alum-3 "#babdb6")
  (alum-4 "#888a85")
  (alum-5 "#5f615c")
  (alum-6 "#2e3436")
  (white "#ffffff")
  ;; Not in Tango palette; used for better contrast.
  (cham-4 "#346604")
  (blue-0 "#8cc4ff")
  (orange-4 "#b35000")
  ;; Custom colors
  (bg         "#f0f0f0")
  (bg-alt     "#eeeeee")
  (base0      "#fafafa")
  (base1      "#f5f5f5")
  (base2      "#eeeeee")
  (base3      "#e0e0e0")
  (base4      "#bdbdbd")
  (base5      "#9e9e9e")
  (base6      "#757575")
  (base7      "#616161")
  (base8      "#424242")
  (fg         "#2a2a2a")
  (fg-alt     "#454545")
  (white      "#ffffff")
  (black      "#000000")
  (grey       "#bdbdbd")
  (red        "#99324b")
  (orange     "#ac4426")
  (green      "#4f894c")
  (teal       "#29838d")
  (yellow     "#9a7500")
  (blue       "#3b6ea8")
  (dark-blue  "#5272AF")
  (magenta    "#97365b")
  (violet     "#842879")
  (cyan       "#398eac")
  (dark-cyan  "#2c7088")
  )
  
 
  (custom-theme-set-faces
   'victory
   `(default ((t (:foreground ,fg :background ,bg))))
   `(shadow ((t (:foreground ,base8))))
   `(cursor ((t (:background ,orange-2))))
   ;; Highlighting faces
   `(fringe ((t (:background ,bg))))
   `(highlight ((t (:background ,alum-3))))
   `(hl-line ((t (:background ,white))))
   `(region ((t (:background ,alum-3))))
   `(secondary-selection ((t (:background ,blue-0))))
   `(isearch ((t (:foreground "#ffffff" :background ,orange))))
   `(lazy-highlight ((t (:background ,choc-1))))
   `(trailing-whitespace ((t (:background ,red-1))))
   ;; Mode line faces
   `(mode-line ((t (:box (:line-width 1 :style released-button)
			 :background ,blue-2 :foreground ,white))))
   `(mode-line-inactive ((t (:box (:line-width 1 :style released-button)
				  :background ,base3 :foreground ,base6))))

   ;; Escape and prompt faces
   `(minibuffer-prompt ((t (:weight bold :foreground ,blue))))
   `(escape-glyph ((t (:foreground ,red-3))))
   `(homoglyph ((t (:foreground ,red-3))))
   `(error ((t (:foreground ,red-3))))
   `(warning ((t (:foreground ,orange-3))))
   `(success ((t (:foreground ,cham-3))))

   ;; Font lock faces
   `(font-lock-builtin-face ((t (:foreground ,teal))))
   `(font-lock-comment-face ((t (:slant italic :foreground ,base5))))
   `(font-lock-constant-face ((t (:weight bold :foreground ,magenta))))
   `(font-lock-function-name-face ((t (:foreground ,teal))))
   `(font-lock-keyword-face ((t (:foreground ,blue))))
   `(font-lock-string-face ((t (:foreground ,green))))
   `(font-lock-type-face ((t (:foreground ,yellow))))
   `(font-lock-variable-name-face ((t (:foreground ,magenta))))

   ;; Button and link faces
   `(link ((t (:underline t :foreground ,blue-3))))
   `(link-visited ((t (:underline t :foreground ,blue-2))))

   ;; Ivy Minibuffer faces
   `(ivy-minibuffer-match-face-1 ((t (:inherit isearch))))
   `(ivy-minibuffer-match-face-2 ((t (:inherit lazy-highlight))))
   
   ;; Org mode faces

   
   ;; Message faces
   `(message-header-name ((t (:foreground ,blue-3))))
   `(message-header-cc ((t (:foreground ,butter-3))))
   `(message-header-other ((t (:foreground ,choc-2))))
   `(message-header-subject ((t (:foreground ,red-3))))
   `(message-header-to ((t (:weight bold :foreground ,butter-3))))
   `(message-cited-text ((t (:slant italic :foreground ,alum-5))))
   `(message-separator ((t (:weight bold :foreground ,cham-3))))

   ;; SMerge
   `(smerge-refined-change ((t (:background ,plum-1))))

   ;; Ediff
   `(ediff-current-diff-A ((t (:background ,blue-1))))
   `(ediff-fine-diff-A ((t (:background ,plum-1))))
   `(ediff-current-diff-B ((t (:background ,butter-1))))
   `(ediff-fine-diff-B ((t (:background ,orange-1))))

   ;; Flyspell
   `(flyspell-duplicate ((t (:underline ,orange-1))))
   `(flyspell-incorrect ((t (:underline ,red-1))))

   ;; Realgud
   `(realgud-overlay-arrow1  ((t (:foreground "dark green"))))
   `(realgud-overlay-arrow2  ((t (:foreground "#7a4c02"))))
   `(realgud-overlay-arrow3  ((t (:foreground ,orange-1))))
   `(realgud-bp-disabled-face      ((t (:foreground ,plum-1))))
   `(realgud-bp-line-enabled-face  ((t (:underline "red"))))
   `(realgud-bp-line-disabled-face ((t (:underline ,plum-1))))
   `(realgud-file-name             ((t :foreground "dark green")))
   `(realgud-line-number           ((t :foreground ,blue-3)))
   `(realgud-backtrace-number      ((t :foreground ,blue-3 :weight bold)))

   ;; Semantic faces
   `(semantic-decoration-on-includes ((t (:underline  ,cham-4))))
   `(semantic-decoration-on-private-members-face
     ((t (:background ,alum-2))))
   `(semantic-decoration-on-protected-members-face
     ((t (:background ,alum-2))))
   `(semantic-decoration-on-unknown-includes
     ((t (:background ,choc-3))))
   `(semantic-decoration-on-unparsed-includes
     ((t (:underline  ,orange-3))))
   `(semantic-tag-boundary-face ((t (:overline   ,blue-1))))
   `(semantic-unmatched-syntax-face ((t (:underline  ,red-1)))))

  (custom-theme-set-variables
   'victory
   `(ansi-color-names-vector [,alum-6 ,red-3 ,cham-3 ,butter-3
				      ,blue-3 ,plum-3 ,blue-1 ,alum-1])))

(provide-theme 'victory)

;;; victory-theme.el ends here
