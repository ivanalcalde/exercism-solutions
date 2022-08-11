#!/usr/bin/env bash

armstrong_number() {
  number=$1
  number_length=${#number}
  exp=${2:-$number_length}
  acc=${3:-0}

  if [ "$number_length" -eq 0 ]
  then
    echo "${acc}"
  else
    last_index=$((number_length - 1))
    head=${number:0:1}
    tail=${number:1:last_index}
    acc=$((acc + head ** exp))
    armstrong_number "$tail" "$exp" "$acc"
  fi
}

main () {
  n=$1
  armstrong_n=$(armstrong_number "$n")

  if [[ "$n" == "$armstrong_n" ]]
  then
    echo "true"
  else
    echo "false"
  fi
}

main "$@"
