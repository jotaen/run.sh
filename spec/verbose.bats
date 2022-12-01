#!/usr/bin/env bats
# shellcheck disable=SC2154

load setup.sh

verbose::verbose_output() { #@test
	create_from run.sh "${BATS_TEST_DIRNAME}/resources/hello-world.sh"
	EXPECTED_OUTPUT="+ run::greet
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
