#!/usr/bin/env bats
# shellcheck disable=SC2154

load setup.sh

parsing::parses_bash_syntax_variations() { #@test
	create run.sh '
run_1() {
	echo 1
}

 run_2 (  )
{
	echo 2
}

run_foo=1 # This is not a function/command

function run_3 {
  run_2
	echo 3
}

	function	run_4			{
	echo 4
}
'
	EXPECTED_OUTPUT='1
2
3
4'

	run main --list
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]

	run main --info 1
	[[ "${status}" -eq 0 ]]

	run main --info 2
	[[ "${status}" -eq 0 ]]

	run main --info 3
	[[ "${status}" -eq 0 ]]

	run main --info 4
	[[ "${status}" -eq 0 ]]
}
