#!/bin/bash

# Check code style with shellcheck.
run_lint() {
	docker run --rm -t \
		-v "${PWD}:/mnt:ro" \
		koalaman/shellcheck:stable run run.sh spec.sh
}

# Run all tests.
run_test() {
	docker run --rm -t \
		-v "${PWD}:/app:ro" \
		bats/bats:latest /app/spec.sh
}

# Perform complete build.
run_all() {
	set -o errexit # Exit on first error.
	run_lint
	run_test
}
