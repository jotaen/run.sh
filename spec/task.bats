#!/usr/bin/env bats
# shellcheck disable=SC2154

load setup.sh

test_fails_if_no_task_specified() { #@test
	create_from run.sh "${BATS_TEST_DIRNAME}/resources/hello-world.sh"

	run main -v
	[[ "${status}" -eq 1 ]]
	[[ "${output}" == 'No task specified' ]]
}

test_fails_if_task_does_not_exist() { #@test
	create_from run.sh "${BATS_TEST_DIRNAME}/resources/hello-world.sh"

	run main foobar
	[[ "${status}" -eq 1 ]]
	[[ "${output}" == 'No such task: foobar' ]]
}

test_disregards_invalid_names() { #@test
	create run.sh '
run_foo:bar() {
	echo
}

run_foo-bar() {
	echo
}

run_%!&@() {
	echo
}
'
	run main --list
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == '' ]]
}
