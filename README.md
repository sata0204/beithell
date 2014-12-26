hcsm
===========
**Make your tex work easy.**

## hcsm.el (under construction)
Its boss of all el files.
hcsm might become major-mode or something.

## hcsm-basicfuncs.el
Define some functions useful for me.
### hcsm-set-string-var(varname prompt &optional convert-option)
bind `varname` to string got from minibuffer with prompt.
### hcsm-set-basepath
get the abs path to `TEX-Genkou` dir.  
and save it to global var, `hcsm-basepath`.

## hcsm-folderinit.el
Provide `hcsm-folderinit`.
It asks (univ/college/parts/questions/something other) 
and create folders related to them.
###hcsm-initializer.el (under construction)
initialize folders.
might be only called by hcsm-folderinit.el.
or might be vanished.

## hcsm-eps-input.el
Provide `hcsm-eps-input`.
It help you to insert .eps pictures.
Run it interactive in the path like;
`/TEX-Genkou/14-kokuritsu/14-HouraiGakuen/14-HRI-gkb/14-HRI-gkb-1/14-HRI-gkb-toi-1.tex`
