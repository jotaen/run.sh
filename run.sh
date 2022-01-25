#!/bin/bash

# Check code style with shellcheck.
run_lint() {
	shellcheck run run.sh spec.sh
}

# Run all tests.
run_test() {
	docker run -it \
		-v "${PWD}:/app:ro" \
		bats/bats:latest /app/spec.sh
}

# Perform complete build.
run_all() {
	run_lint
	run_test
}
