#!/usr/bin/env bash

function is_question {
  [[ "$1" =~ \?$ ]]
}

function is_all_mayus {
  [[ "${1^^}" == "${1}" && "${1,,}" != "${1}" ]]
}

function echo_and_exit {
  echo "$1"
  exit 0
}

function main {
  # clean the input for make it easy to work with
  local input="${1:-}"
  local input="${input//[^A-Za-z0-9?]/}"

  [[ -z "$input" ]] && echo_and_exit "Fine. Be that way!"

  is_question "${input}"
  local question=$?
  is_all_mayus "${input}"
  local all_mayus=$?

  (($question == 0 && $all_mayus == 0)) && echo_and_exit "Calm down, I know what I'm doing!"
  (($question == 0)) && echo_and_exit "Sure."
  (($all_mayus == 0)) && echo_and_exit "Whoa, chill out!"
  echo_and_exit "Whatever."
}

main "$@"
