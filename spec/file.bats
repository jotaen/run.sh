#!/usr/bin/env bats
# shellcheck disable=SC2154

setup() {
	cd "${BATS_TEST_TMPDIR}" || exit 1
}

main() {
	"${BATS_TEST_DIRNAME}/../run" "$@"
}

test_defaults_to_local_run_sh() { #@test
	cp "${BATS_TEST_DIRNAME}/resources/hello-world.sh" run.sh

	run main greet
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == 'Hello, World!' ]]
}

test_set_specific_file() { #@test
	cp "${BATS_TEST_DIRNAME}/resources/hello-world.sh" .

	# Long flag with equal sign
	run main --file="${BATS_TEST_TMPDIR}/hello-world.sh" greet
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == 'Hello, World!' ]]

	# Long flag with space
	run main --file "${BATS_TEST_TMPDIR}/hello-world.sh" greet
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == 'Hello, World!' ]]

	# Short flag with equal sign
	run main -f="${BATS_TEST_TMPDIR}/hello-world.sh" greet everyone
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == 'Hello, everyone!' ]]

	# Short flag with space
	run main -f "${BATS_TEST_TMPDIR}/hello-world.sh" greet everyone
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == 'Hello, everyone!' ]]
}

test_specific_file_takes_precedence() { #@test
	# Create local `run.sh` file, which should be disregarded.
	touch run.sh
	cp "${BATS_TEST_DIRNAME}/resources/hello-world.sh" .

	# Short flag with space
	run main -f "${BATS_TEST_TMPDIR}/hello-world.sh" greet
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == 'Hello, World!' ]]
}

test_fails_if_no_such_run_file() { #@test
	# With default run file
	run main greet world
	[[ "${status}" -eq 2 ]]
	[[ "${output}" == 'No such file: ./run.sh' ]]

	# With custom run file
	run main -f=non-existing-file.sh greet world
	[[ "${status}" -eq 2 ]]
	[[ "${output}" == 'No such file: non-existing-file.sh' ]]
}
