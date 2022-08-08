#!/usr/bin/env bash

main () {
  input=$1

  input=$( echo "$input" | sed -e 's/_//g' )  # clean underscores
  input=$( echo "$input" | sed -e 's/*//g' )  # clean shell globbing character
  input=$( echo "$input" | sed -e 's/-/ /g' ) # replace hyphens by spaces

  tla=""
  for word in $input
  do
    tla="$tla${word:0:1}"
  done

  echo "${tla^^}"
}

main "$@"
