# .bashrc

# path stuff
if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi

# Aliases
alias ls="ls -G"
alias cisco-console="sudo cu -l /dev/cu.usbserial -s 9600"
alias ccat='pygmentize -g'

# Proxy for work when needed on the command line
function proxy() {
    if [[ $1 ]]
    then
      if [[ $1 == "on" ]]
      then
        echo "==>  Adding proxy variables"
        export {http,https,ftp}_proxy='http://X.X.X.X:8080'
        export {HTTP,HTTPS,FTP}_PROXY='http://X.X.X.X:8080'
      elif [[ $1 == "off" ]]
      then
        echo "==>  Removing proxy variables"
        unset {http,https,ftp}_proxy
        unset {HTTP,HTTPS,FTP}_PROXY
      else
        echo "Unknown Command: $1 (Try on/off)"
        return 1
      fi
    fi
    echo "Current proxy variables:"
    echo "$(env | grep -i proxy)"
}

# add git branch
function parse_git_branch {
        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'
}

function proml {
  # COLOR CODES
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local        CYAN="\[\033[0;36m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  local     DEFAULT="\[\033[0m\]"
# Prompt command
PS1="$WHITE\$? \$(if [[ \$? == 0 ]]; then echo \"$GREEN\342\234\223\"; else echo \"$RED\342\234\227\"; fi) $DEFAULT [$GREEN\u$DEFAULT@$CYAN\h$DEFAULT] \W$BLUE\$(parse_git_branch)$DEFAULT\$ "

}

proml