#!/usr/bin/env bash

error () {
  echo "$1"
  exit 1
}

main () {
  (( $# != 2 )) && error "Usage: $0 <string1> <string2>"

  (( ${#1} != ${#2} )) && error "strands must be of equal length"

  declare -i hamming
  for n in $( seq $#1 ); do
    index=$(( n-1 ))

    char1=${1:$index:1}
    char2=${2:$index:1}

    if [ "$char1" != "$char2" ]; then
      hamming+=1
    fi
  done

  printf "%d" "$hamming"
}

main "$@"
