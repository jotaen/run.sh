#!/usr/bin/env bats
# shellcheck disable=SC2154

setup() {
	cd "${BATS_TEST_TMPDIR}" || exit 1
}

main() {
	"${BATS_TEST_DIRNAME}/../run" "$@"
}

test_fails_if_no_task_specified() { #@test
	cp "${BATS_TEST_DIRNAME}/resources/hello-world.sh" run.sh

	run main -v
	[[ "${status}" -eq 1 ]]
	[[ "${output}" == 'No task specified' ]]
}

test_fails_if_task_does_not_exist() { #@test
	cp "${BATS_TEST_DIRNAME}/resources/hello-world.sh" run.sh

	run main foobar
	[[ "${status}" -eq 1 ]]
	[[ "${output}" == 'No such task: foobar' ]]
}

test_disregards_invalid_names() { #@test
	printf '%s' '
run_foo:bar() {
	echo
}

run_foo-bar() {
	echo
}

run_%!&@() {
	echo
}
' > run.sh
	run main --list
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == '' ]]
}
