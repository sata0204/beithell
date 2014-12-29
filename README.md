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
###hcsm-initializer.el (under construction)
initialize folders.
might be only called by hcsm-folderinit.el.
or might be vanished.

## hcsm-setup.el
store some settings.
will be renamed to hcsm-var-settings.el after merged dev branches.

## hcsm-eps-input.el
Provide `hcsm-eps-input`.
It help you to insert .eps pictures.
Run it interactive in the path like;
`/TEX-Genkou/14-kokuritsu/14-HouraiGakuen/14-HRI-gkb/14-HRI-gkb-1/14-HRI-gkb-toi-1.tex`

## hcsm-basicfuncs.el
define some functions useful for me.
## hcsm-templete.el
define defun templete useful for me.
