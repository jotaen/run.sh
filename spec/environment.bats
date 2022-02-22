#!/usr/bin/env bats
# shellcheck disable=SC2154

load setup.sh

environment::does_not_pollute_scope() { #@test
	# shellcheck disable=SC2016
	create run.sh '
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
'

	# `bats_readlinkf` is an internal function from the test framework.
	EXPECTED_OUTPUT="bats_readlinkf"

	run main check
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]
}

environment::correct_bash_source_variable() { #@test
	# shellcheck disable=SC2016
	create run.sh '
THIS_FILE="${BASH_SOURCE[0]}"
run_check() {
	echo "${THIS_FILE}"
}
'
	EXPECTED_OUTPUT="./run.sh"

	run main check
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]
}
