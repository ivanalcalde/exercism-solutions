#!/usr/bin/env bash

# grains = 2^(n-1)

# we use the `bc` command because for some operations
# with the typical arithmetic operators in bash
# we are overflowing the max limit and the results
# are in these cases wrong

function get_grains() {
  exponent="$(($1 - 1))"

  echo "2^$exponent" | bc
}

function main() {
  min=1
  max=64

  if (("$1" >= "$min" && "$1" <= "$max")); then
    result=$(get_grains "$1")
  elif [[ "$1" == "total" ]]; then
    result=0
    for ((i = "$min"; i <= "$max"; i++)); do
      grains_of_i=$(get_grains "$i")
      result=$(bc <<<"$result + $grains_of_i")
    done
  else
    echo "Error: invalid input"
    return 1
  fi

  echo "$result"
}

main "$@"
