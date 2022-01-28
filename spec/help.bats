#!/usr/bin/env bats
# shellcheck disable=SC2154

load setup.sh

test_help() { #@test
	# Long flag
	run main --help
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == *"Usage: run"* ]]

	# Short flag
	run main -h
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == *"Usage: run"* ]]
}
