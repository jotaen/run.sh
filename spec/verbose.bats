#!/usr/bin/env bats
# shellcheck disable=SC2154

setup() {
	cd "${BATS_TEST_TMPDIR}" || exit 1
	cp "${BATS_TEST_DIRNAME}/resources/hello-world.sh" run.sh
}

main() {
	"${BATS_TEST_DIRNAME}/../run" "$@"
}

EXPECTED_GREET_VERBOSE_OUTPUT="+ run_greet
+ NAME=World
+ echo 'Hello, World!'
Hello, World!"

test_verbose_output() { #@test
	# Long flag
	run main --verbose greet
	[[ "${status}" -eq 0 ]]
	[[ "${output}" = "${EXPECTED_GREET_VERBOSE_OUTPUT}" ]]

	# Short flag
	run main -v greet
	[[ "${status}" -eq 0 ]]
	[[ "${output}" = "${EXPECTED_GREET_VERBOSE_OUTPUT}" ]]
}
