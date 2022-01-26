#!/usr/bin/env bats
# shellcheck disable=SC2154

main() {
	"${BATS_TEST_DIRNAME}/../run" "$@"
}

test_help() { #@test
	# Long flag
	run main --help
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == *"Usage: run"* ]]

	# Short flag
	run main -h
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == *"Usage: run"* ]]

	# No arguments at all
	run main
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == *"Usage: run"* ]]
}
