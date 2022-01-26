#!/usr/bin/env bats
# shellcheck disable=SC2154

setup() {
	cd "${BATS_TEST_TMPDIR}" || exit 1
}

main() {
	"${BATS_TEST_DIRNAME}/../run" "$@"
}

test_lists_all_tasks_and_their_title() { #@test
	cp "${BATS_TEST_DIRNAME}/resources/annotating.sh" run.sh
		EXPECTED_OUTPUT="nodescription
titleonly         Task with title
fulldescription   Task with title and description"

	# Long flag
	run main --list
	[[ "${status}" -eq 0 ]]
	[[ "${output}" = "${EXPECTED_OUTPUT}" ]]

	# Long flag alias (hidden in --help)
	run main --ls
	[[ "${status}" -eq 0 ]]
	[[ "${output}" = "${EXPECTED_OUTPUT}" ]]

	# Short flag
	run main -l
	[[ "${status}" -eq 0 ]]
	[[ "${output}" = "${EXPECTED_OUTPUT}" ]]
}
