#!/usr/bin/env bats
# shellcheck disable=SC2154

setup() {
	cd "${BATS_TEST_TMPDIR}" || exit 1
}

main() {
	"${BATS_TEST_DIRNAME}/../run" "$@"
}

test_does_not_pollute_scope() { #@test
	# shellcheck disable=SC2016
	printf '%s' '
# Print out all function names.
compgen -A function

# Print out input arguments.
echo "$@"

# It is not possible to print local variables,
# so we just do a spot check here.
echo "${TASK_DEF_PATTERN_1}"

run_check() {
	echo
}
' > run.sh

	# `bats_readlinkf` is an internal function from the test framework.
	EXPECTED_OUTPUT="bats_readlinkf"

	run main check
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]
}

test_correct_bash_source_variable() { #@test
	# shellcheck disable=SC2016
	printf '%s' '
THIS_FILE="${BASH_SOURCE[0]}"
run_check() {
	echo "${THIS_FILE}"
}
' > run.sh
	EXPECTED_OUTPUT="./run.sh"

	run main check
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]
}
