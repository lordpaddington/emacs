;;; Filename: name-theme.el 
(deftheme name
  "basic")
 
;; Not a bad idea to define a palette...
(let (
   (color-1 "#ffffff") 
   (color-2 "#ff0000") 
   (color-3 "#00ff00")
   (color-4 "#0000ff"))
 
  ;; Set faces
  (custom-theme-set-faces
   'basic ;; you must use the same theme name here...
   '(default ((t (:foreground ,color-1 :background black))))
   '(cursor  ((t (:background ,color-4))))
   '(fringe  ((t (:background ,color-3))))
   ;;; etc... 
   ;;; don't use these settings of course, 
   ;;; they're horrible.
   )
 
  ;; Set variables
  (custom-theme-set-variables
   'basic ;; again specify the same theme name...
   '(any-variable EXPR)
 
(provide-theme 'basic)
;;; name-theme.el ends here
