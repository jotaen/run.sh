#!/bin/bash

GREETING='Hello'

# Prints a greeting
run::greet() {
	NAME="${1:-World}"
	echo "${GREETING}, ${NAME}!"
}
