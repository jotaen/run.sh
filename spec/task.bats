#!/usr/bin/env bats
# shellcheck disable=SC2154

load setup.sh

task::fails_if_task_does_not_exist() { #@test
	create_from run.sh "${BATS_TEST_DIRNAME}/resources/hello-world.sh"

	run main foobar
	[[ "${status}" -eq 1 ]]
	[[ "${output}" == 'No such task: foobar' ]]
}

task::recognises_valid_task_names() { #@test
	create run.sh '
run::foo() {
	echo
}

run::foo123() {
	echo
}

run::foo-bar() {
	echo
}

run::foo_bar() {
	echo
}

run::foo:bar() {
	echo
}
'

	EXPECTED_OUTPUT='foo
foo123
foo-bar
foo_bar
foo:bar'

	run main --list
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]
}
