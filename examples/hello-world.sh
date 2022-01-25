#!/bin/sh

GREETING='Hello'

# Prints a greeting.
run_greet() {
	NAME="${1:-World}"
	echo "${GREETING}, ${NAME}!"
}
