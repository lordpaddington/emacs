# My private emacs config

Pretty much everything is in configs/config.el

### Config files that are "missing":

**init.el** - do keep it for compatibility purposes, but not included in the repo to avoid customizations on different machniges messing up things.

Include in the beginning:

`
(package-initialize)
(load-file "~/.emacs.d/configs/config.el")
`

**local.el** - should be located in the .emacs.d dir. Define everything here that only applies to the current setup. Right now it's only used to set up the org directory:

`
;;Directories
(setq org-directory "~/org")
`
