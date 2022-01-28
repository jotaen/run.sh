#!/usr/bin/env bats
# shellcheck disable=SC2154

load setup.sh

test_version() { #@test
	run main --version
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == 'Version '* ]]
}
