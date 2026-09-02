#!/usr/bin/env bash
set -eu

help() {
  echo "Usage: bash delete_output.sh <test_dir>"
}

if [ -z "${1:-}" ]; then
  help
  exit 1
fi

rm -f ${1}/*/out.bin
rm -f ${1}/*/out.bin.md5
