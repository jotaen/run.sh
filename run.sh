#!/usr/bin/env bash

# Check code style with shellcheck.
run_lint() {
	docker run --rm -t \
		-v "${PWD}:/mnt:ro" \
		koalaman/shellcheck:stable \
			run run.sh spec/*.bats spec/resources/*.sh
}

# Run all tests.
# https://bats-core.readthedocs.io/en/stable/index.html
run_test() {
	docker run --rm -t \
		-v "${PWD}:/app:ro" \
		bats/bats:latest \
			--print-output-on-failure \
			'/app/spec'
}

# Perform complete build.
run_all() {
	set -o errexit # Exit on first error.
	run_lint
	run_test
}
