#!/usr/bin/env bats
# shellcheck disable=SC2154

setup() {
	cd "${BATS_TEST_TMPDIR}" || exit 1
	cp "${BATS_TEST_DIRNAME}/resources/hello-world.sh" run.sh
}

main() {
	"${BATS_TEST_DIRNAME}/../run" "$@"
}

test_fails_if_no_task_specified() { #@test
	run main -v
	[[ "${status}" -eq 1 ]]
	[[ "${output}" = 'No task specified' ]]
}

test_fails_if_task_does_not_exist() { #@test
	run main foobar
	[[ "${status}" -eq 1 ]]
	[[ "${output}" = 'No such task: foobar' ]]
}
