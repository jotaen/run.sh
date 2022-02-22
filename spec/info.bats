#!/usr/bin/env bats
# shellcheck disable=SC2154

load setup.sh

info::prints_description() { #@test
	create run.sh '
# Foo
run_foo() {
	echo
}
'

	# Long flag with equal sign
	run main --info=foo
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == 'Foo' ]]

	# Long flag with space
	run main --info foo
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == 'Foo' ]]

	# Short flag with equal sign
	run main -i=foo
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == 'Foo' ]]

	# Short flag with space
	run main -i foo
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == 'Foo' ]]
}

info::prints_entire_text_for_task() { #@test
	create_from run.sh "${BATS_TEST_DIRNAME}/resources/nodejs.sh"
	EXPECTED_OUTPUT='Start web server

Pass a port number optionally as argument, otherwise
it falls back to 8080.'

	run main --info server
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]
}

info::trims_only_one_leading_space() { #@test
	create run.sh '
#  Foo
#     Test
run_foo() {
	echo
}
'
	EXPECTED_OUTPUT=' Foo
    Test'

	run main --info foo
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]
}

info::fails_if_task_not_found() { #@test
	create run.sh '
run_foo() {
	echo
}
'

	run main --info asdf
	[[ "${status}" -eq 1 ]]
	[[ "${output}" == 'No such task: asdf' ]]
}

info::fails_if_no_task_specified() { #@test
	create run.sh '
run_foo() {
	echo
}
'

	run main --info
	[[ "${status}" -eq 1 ]]
	[[ "${output}" == 'No task specified' ]]
}
