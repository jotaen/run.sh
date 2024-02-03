#!/usr/bin/env bats
# shellcheck disable=SC2154

load setup.sh

parsing::parses_bash_syntax_variations() { #@test
	create run.sh '
run::a() {
	echo a
}

 run::b (  )
{
	echo b
}

# This is not a function/command
run::foo=1

function run::c {
  run::b
	echo c
}

	function	run::d			{
	echo d
}
'
	EXPECTED_OUTPUT='a
b
c
d'

	run main --list
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]

	run main --info a
	[[ "${status}" -eq 0 ]]

	run main --info b
	[[ "${status}" -eq 0 ]]

	run main --info c
	[[ "${status}" -eq 0 ]]

	run main --info d
	[[ "${status}" -eq 0 ]]
}

parsing::disregards_invalid_task_names() { #@test
	create run.sh '
run::%foo() {
	echo
}

run::1foo() {
	echo
}

run::-asdf() {
	echo
}

run::--asdf() {
	echo
}

run:::asdf() {
	echo
}
'
	run main --list
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == '' ]]
}
