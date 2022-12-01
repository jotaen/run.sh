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

run::check() {
	echo
}
'

	# `bats_readlinkf` is an internal function from the test framework.
	EXPECTED_OUTPUT="bats_readlinkf"

	run main check
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]
}

environment::can_source_other_files() { #@test
	# shellcheck disable=SC2016
	create lib.sh '
foo() {
	echo 123
}
'
	# shellcheck disable=SC2016
	create run.sh '
source lib.sh

run::check() {
	foo
}
'

	EXPECTED_OUTPUT="123"

	run main check
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]
}

environment::bash_source_variable() { #@test
	# shellcheck disable=SC2016
	create run.sh '
THIS_FILE_BS="${BASH_SOURCE[0]}"
run::bashsource() {
	echo "${THIS_FILE_BS}"
}

THIS_FILE_0="$0"
run::zero() {
	echo "${THIS_FILE_0}"
}
'

	run main bashsource
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "./run.sh" ]]

	run main zero
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "bash" ]]
}
