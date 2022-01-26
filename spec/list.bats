#!/usr/bin/env bats
# shellcheck disable=SC2154

setup() {
	cd "${BATS_TEST_TMPDIR}" || exit 1
}

main() {
	"${BATS_TEST_DIRNAME}/../run" "$@"
}

test_returns_empty_for_empty_file() { #@test
	echo "" > run.sh

	run main --list
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "" ]]
}

test_lists_all_tasks_and_their_title() { #@test
	cp "${BATS_TEST_DIRNAME}/resources/nodejs.sh" run.sh
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
	printf '%s' '
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
' > run.sh
	EXPECTED_OUTPUT='noname1
first     This task has a title
noname2
second    Here is a title again
noname3'

	run main --list
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]
}
