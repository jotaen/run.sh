#!/usr/bin/env bats
# shellcheck disable=SC2154

setup() {
	cd "${BATS_TEST_TMPDIR}" || exit 1
}

main() {
	"${BATS_TEST_DIRNAME}/../run" "$@"
}

test_version() { #@test
	run main --version
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == 'Version '* ]]
}
