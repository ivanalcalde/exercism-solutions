#!/usr/bin/env bash

main () {
  case ${#@} in
    1) echo "Hello, $1";;
    *) echo "Usage: $0 <person>" && return 1;;
  esac
}

main "$@"
