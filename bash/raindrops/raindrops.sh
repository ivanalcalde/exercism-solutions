#!/usr/bin/env bash

is_multiple() {
  remainder=$(($1 % $2))

  echo $((remainder == 0))
}

print_word() {
  case $1 in
    1) echo "$2";;
    0) echo "";;
  esac
}

main () {
 pling="$(print_word $(is_multiple $1 3) "Pling")"
 plang="$(print_word $(is_multiple $1 5) "Plang")"
 plong="$(print_word $(is_multiple $1 7) "Plong")"

 result="$pling$plang$plong"

 echo "${result:-$1}"
}

main "$@"
