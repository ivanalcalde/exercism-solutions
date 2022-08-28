#!/usr/bin/env bash

get_points_by_letter() {
  case "${1^^}" in
  A | E | I | O | U | L | N | R | S | T)
    echo "1"
    ;;
  D | G)
    echo "2"
    ;;
  B | C | M | P)
    echo "3"
    ;;
  F | H | V | W | Y)
    echo "4"
    ;;
  K)
    echo "5"
    ;;
  J | X)
    echo "8"
    ;;
  Q | Z)
    echo "10"
    ;;
  *)
    echo "0"
    ;;
  esac
}

main() {
  local total=${2:-0}
  if [[ "${1:0:1}" != "" ]]; then
    local letter="${1:0:1}"
    local letter_points="$(get_points_by_letter $letter)"
    total=$((total + letter_points))

    local next_index=$((index + 1))
    main "${1:$((index + 1))}" "$total"
  else
    echo "$total"
  fi
}

main "$@"
