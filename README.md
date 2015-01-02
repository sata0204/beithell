hcsm
===========
**Make your tex work easy.**

## hcsm.el (under construction)
Its boss of all el files.
hcsm might become major-mode or something.

## hcsm-var-settings.el
Declare global vars using defvar.
`hcsm-TEX-Genkou-path`, `hcsm-school-year` is set now.
### hcsm-setup.el
Provide some functions to set your var-settings up. 

## hcsm-folderinit.el
Provide `hcsm-folderinit`.
It asks (univ/college/parts/questions/something other) 
and create folders related to them.
### hcsm-folderinit-setting-functions.el
might called only by folderinit.
### hcsm-folderinit-create-matome.el
might called only by folderinit.
* note: if you merge this in hcsm-folderinit.el,
let varlist wasn't loaded by some unknown reasons. 
needs more info

## hcsm-var-settings.el
store global var settings.
### hcsm-setup.el
provide `hcsm-setup`, a function to edit hcsm-var-settings.el interactively.

## hcsm-eps-input.el
Provide `hcsm-eps-input`.
It help you to insert .eps pictures.
Run it interactive in the path like;
`/TEX-Genkou/14-kokuritsu/14-HouraiGakuen/14-HRI-gkb/14-HRI-gkb-1/14-HRI-gkb-toi-1.tex`

## hcsm-basicfuncs.el
define some functions useful for me.
## hcsm-templete.el
define defun templete useful for me.
