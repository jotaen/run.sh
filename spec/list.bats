#!/usr/bin/env bats
# shellcheck disable=SC2154

load setup.sh

test_returns_empty_for_empty_file() { #@test
	create run.sh ''

	run main --list
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "" ]]
}

test_lists_all_tasks_and_their_title() { #@test
	create_from run.sh "${BATS_TEST_DIRNAME}/resources/nodejs.sh"
	EXPECTED_OUTPUT='install   Install NodeJS dependencies
test      Execute unit tests
server    Start web server'

	# Long flag
	run main --list
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]

	# Long flag alias (hidden in --help)
	run main --ls
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]

	# Short flag
	run main -l
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]
}

test_omit_title_is_not_given() { #@test
	create run.sh '
run_noname1() {
	echo
}

# This task has a title
run_first() {
	echo
}

run_noname2() {
	echo
}

# Here is a title again
# There is also a descrition, but that is ignored
run_second() {
	echo
}

run_noname3() {
	echo
}
'
	EXPECTED_OUTPUT='noname1
first     This task has a title
noname2
second    Here is a title again
noname3'

	run main --list
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]
}
