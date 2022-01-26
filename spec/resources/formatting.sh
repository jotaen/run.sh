#!/bin/sh
# shellcheck disable=SC2113 # `function` keyword
# shellcheck disable=SC2034 # unused variable

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
