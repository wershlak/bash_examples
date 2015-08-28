#!/bin/bash
#
# Jeff Wolak
# Example of an input function
#
# OUTPUT:
#
# $ ./get_input.sh
# Enter the hostname and press [ENTER]. Example: host1
# hostname: host123
# Set the hostname to host123 [y/N]? y
# hostname set to: host123


# get_input function
# $1 : Should be the variable you want to set
# $2 : Is an example format
# EXAMPLE --> get_input hostname host12
get_input () {
  local __input_var=$1
  local __example=$2
  local __answer="n"
  local result=''
  until [ "$__answer" == "y" ]; do
    echo "Enter the $__input_var and press [ENTER]. Example: "$__example""
    echo -n "$__input_var: "
    read result
    [ -z "$result" ] && continue
    echo -n "Set the $__input_var to "$result" [y/N]? "
    read __answer
  done
  eval $__input_var="'$result'"
}

# Get hostname example
get_input hostname host1
echo "hostname set to: $hostname"

exit 0
