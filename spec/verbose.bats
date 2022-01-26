#!/usr/bin/env bats
# shellcheck disable=SC2154

setup() {
	cd "${BATS_TEST_TMPDIR}" || exit 1
}

main() {
	"${BATS_TEST_DIRNAME}/../run" "$@"
}

test_verbose_output() { #@test
	cp "${BATS_TEST_DIRNAME}/resources/hello-world.sh" run.sh
	EXPECTED_OUTPUT="+ run_greet
+ NAME=World
+ echo 'Hello, World!'
Hello, World!"

	# Long flag
	run main --verbose greet
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]

	# Short flag
	run main -v greet
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]
}
