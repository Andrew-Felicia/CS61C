#!/usr/bin/env bash
set -eu

help() {
	echo "Usage: bash run_test.sh [command]"
}

if [ -z "${2:-}" ]; then
	help
	exit 1
fi

_term() {
  kill -TERM "$child" 2>/dev/null
}

echo "Command: ${@:1}"

trap _term SIGTERM

start_time="$(date +%s%3N)"

${1} ${@:2} &

child=$!
wait "$child"

return_code="$?"
end_time="$(date +%s%3N)"

echo "Time elapsed: $((end_time - start_time))ms"

if [ $return_code -ne 0 ]; then
	exit $return_code
fi
