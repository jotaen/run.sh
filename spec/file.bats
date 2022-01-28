#!/usr/bin/env bats
# shellcheck disable=SC2154

load setup.sh

test_defaults_to_local_run_sh() { #@test
	create_from run.sh "${BATS_TEST_DIRNAME}/resources/hello-world.sh"

	run main greet
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == 'Hello, World!' ]]
}

test_set_specific_file() { #@test
	create_from hello-world.sh "${BATS_TEST_DIRNAME}/resources/hello-world.sh"

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
	create run.sh ''
	create_from hello-world.sh "${BATS_TEST_DIRNAME}/resources/hello-world.sh"

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

test_fails_on_directories() { #@test
	mkdir foo

	run main -f=foo --list
	[[ "${status}" -eq 2 ]]
	[[ "${output}" == 'Not a file: foo' ]]
}

test_fails_is_not_executable() { #@test
	touch foo

	run main -f=foo --list
	[[ "${status}" -eq 2 ]]
	[[ "${output}" == 'File not executable: foo' ]]
}
