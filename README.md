hcsm
===========
**Make your tex work easy.**

# hcsm.el
Provide a package `hcsm`. 
Write in ~/.emacs.d/init.el as follows;
``(require `hcsm)``

## hcsm-var-settings.el
Store and declare global variables. 
Don't edit this file directly. use `hcsm-setup`
### hcsm-setup.el
provide `hcsm-setup`, a function to edit hcsm-var-settings.el interactively.

## hcsm-folderinit.el
Provide `hcsm-folderinit`.
It asks (univ/college/parts/questions/something other) 
<<<<<<< HEAD
and create folders using those informations.
### hcsm-folderinit-setting-functions.el
might called only by folderinit.
=======
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
>>>>>>> remotes/upstream/fileinit

## hcsm-eps-input.el
Provide `hcsm-eps-input`.
It help you to insert .eps pictures.
Run it interactive in the buffer of file like;
`/TEX-Genkou/14-kokuritsu/14-HouraiGakuen/14-HRI-gkb/14-HRI-gkb-1/14-HRI-gkb-toi-1.tex`

## hcsm-basicfuncs.el
define some functions useful for me.
## hcsm-templete.el
define defun templete useful for me.
