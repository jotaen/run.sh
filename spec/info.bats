#!/usr/bin/env bats
# shellcheck disable=SC2154

setup() {
	cd "${BATS_TEST_TMPDIR}" || exit 1
}

main() {
	"${BATS_TEST_DIRNAME}/../run" "$@"
}

test_prints_description() { #@test
	printf '%s' '
# Foo
run_foo() {
	echo
}
' > run.sh

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

test_prints_entire_text_for_task() { #@test
	cp "${BATS_TEST_DIRNAME}/resources/nodejs.sh" run.sh
	EXPECTED_OUTPUT='Start web server

Pass a port number optionally as argument, otherwise
it falls back to 8080.'

	run main --info server
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]
}

test_trims_only_one_leading_space() { #@test
	printf '%s' '
#  Foo
#     Test
run_foo() {
	echo
}
' > run.sh
	EXPECTED_OUTPUT=' Foo
    Test'

	run main --info foo
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]
}

test_fails_if_task_not_found() { #@test
	printf '%s' '
run_foo() {
	echo
}
' > run.sh

	run main --info asdf
	[[ "${status}" -eq 1 ]]
	[[ "${output}" == 'No such task: asdf' ]]
}

test_fails_if_no_task_specified() { #@test
	printf '%s' '
run_foo() {
	echo
}
' > run.sh

	run main --info
	[[ "${status}" -eq 1 ]]
	[[ "${output}" == 'No task specified' ]]
}
