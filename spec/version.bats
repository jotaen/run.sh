#!/usr/bin/env bats
# shellcheck disable=SC2154

load setup.sh

version::prints_version_info() { #@test
	run main --version
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == 'Version '* ]]
}
