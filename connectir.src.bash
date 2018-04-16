#!/usr/bin/env bash

# USAGE:
#   source connectir.src.bash

# provideds two ways to use connectir 
# without spending too much time dealing with docker commands
#
# 1. connectir function (explicitly not the tutorial, maybe less confusing when something breaks)
#   connectir subdist -i ...
#   connectir mdmr -i ...
#
# 2. aliases -- provides commands that match connectir tutorial
#  - connectir_subdist.R  -i ...
#  - connectir_mdmr.R  -i ...
#


## -- function
docker_connectir() { $CONNECTIR_SUDO docker run -v "$(pwd):$(pwd)" -w "$(pwd)" --entrypoint $1  connectir ${@:2};}

# check inputs, reduce entrypoint to unique bits
CONNECTIR_NAMES="subdist mdmr"
connectir() { 
   local patt="^(${CONNECTIR_NAMES// /|})$" # ^(subdist|mdmr)
   msg=""
   # should match something in CONNECTIR_NAMES
   [[ ! $1 =~ $patt ]] && mgs="$FUNCNAME only accepts subdist or mdmr, you gave '$1'\n"
   # path with a colon is a problem
   [[ "$(pwd)" =~ : ]] && msg="$msg working directory has ':', this will cause problems!\n"
   # do not allow relative going up directory ../blah/path
   [[ "$*" =~ \.\./[^\ ]* ]] && 
      msg="$msg it looks like you're trying to run with a file docker wont be able to find ('$BASH_REMATCH');
      this wont work with docker. file must be within current working dirtory ('$(pwd)')!\n"
   # do not allow absolute paths: /blah/blah
   [[ "$*" =~ \ /[^\ ]* ]] && msg="$msg it looks like you're specifying a aboslute path ('$BASH_REMATCH'). use path relative to $(pwd)\n" 
   [ -n "$msg" ] && echo -e $msg >&2 && return 1

   # actually run
   docker_connectir connectir_${1}.R ${@:2}
}


# -- aliases
alias connectir_subdist.R="connectir subdist"
alias connectir_mdmr.R="connectir mdmr"


# -- tab completion
_connectir(){
   COMPREPLY=( $(compgen -W "$CONNECTIR_NAMES" -- "${COMP_WORDS[COMP_CWORD]}" ) )
   return 0
}
complete -F _connectir connectir 
