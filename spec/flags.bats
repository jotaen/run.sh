#!/usr/bin/env bats
# shellcheck disable=SC2154

load setup.sh

flags::rejects_unknown() { #@test
	# Unknown long flag
	run main --asdf
	[[ "${status}" -eq 1 ]]
	[[ "${output}" == 'Unknown option --asdf' ]]

	# Unknown short flag
	run main -x
	[[ "${status}" -eq 1 ]]
	[[ "${output}" == 'Unknown option -x' ]]
}
