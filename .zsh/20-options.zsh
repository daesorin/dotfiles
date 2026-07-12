# NAVIGATION OPTIONS
# set directory behaviour
setopt AUTO_CD # enter dir without prepending `cd`
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt CDABLE_VARS
setopt NO_CASE_GLOB
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt AUTO_LIST
setopt GLOB_DOTS

# GLOBBING OPTIONS
# set expansion rules
setopt EXTENDED_GLOB
setopt NUMERIC_GLOB_SORT

# SAFETY OPTIONS
# prevent accidental file overwriting
setopt NO_CLOBBER
