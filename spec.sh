#!/usr/bin/env bats

# https://bats-core.readthedocs.io/en/stable/index.html

# Ignore unassigned variables, so that we can use the bats
# special variables like $status or $output.
# shellcheck disable=SC2154

setup() {
	# Setup a file with sample tasks.
	cat << EOF > "hello-world.sh"
#!/bin/sh

GREETING='Hello'

# Prints a greeting.
run_greet() {
	NAME="\${1:-World}"
	echo "\${GREETING}, \${NAME}!"
}
EOF
}

main() {
	bash "${BATS_TEST_DIRNAME}/run" "${@}"
}

test_help() { #@test
	# Long flag
	run main --help
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == *"Usage: run"* ]]

	# Short flag
	run main -h
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == *"Usage: run"* ]]

	# No arguments at all
	run main
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == *"Usage: run"* ]]
}

test_set_specific_file() { #@test
	# Long flag with equal sign
	run main --file=hello-world.sh greet
	[[ "${status}" -eq 0 ]]
	[ "${output}" = 'Hello, World!' ]

	# Long flag with space
	run main --file hello-world.sh greet
	[[ "${status}" -eq 0 ]]
	[ "${output}" = 'Hello, World!' ]

	# Short flag with equal sign
	run main -f=hello-world.sh greet everyone
	[[ "${status}" -eq 0 ]]
	[ "${output}" = 'Hello, everyone!' ]

	# Short flag with space
	run main -f hello-world.sh greet everyone
	[[ "${status}" -eq 0 ]]
	[ "${output}" = 'Hello, everyone!' ]
}

test_fails_if_no_such_run_file() { #@test
	# With default run file
	run main greet world
	[ "${status}" -eq 2 ]
	[ "${output}" = 'No such file: ./run.sh' ]

	# With custom run file
	run main -f=non-existing-file.sh greet world
	[ "${status}" -eq 2 ]
	[ "${output}" = 'No such file: non-existing-file.sh' ]
}
