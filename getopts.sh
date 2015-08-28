#!/bin/bash
#
# Jeff Wolak
#
# Bash example for getopts


usage() {
    cat << EOF
    usage: $0 options

    Nagios plugin to check something

    OPTIONS:
        -h      Show this message
        -H      IP Address
        -v      Verbose
EOF
}


ADDRESS=
VERBOSE=
while getopts "hH:v" OPTION
do
    case $OPTION in
        h)
            usage
            exit 3
            ;;
        H)
            ADDRESS=$OPTARG
            ;;
        v)
            VERBOSE=1
            ;;
        ?)
            usage
            exit 3
            ;;
    esac
done

if [[ -z $ADDRESS ]]
then
    usage
    exit 3
fi

if [[ $VERBOSE == 1 ]]
then
    echo "*** Verbose mode on ***"
    echo "Address: $ADDRESS"
fi
