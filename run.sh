#!/usr/bin/env bash

# Check code style with shellcheck
run_lint() {
	shellcheck \
		run run.sh spec/*.bats spec/resources/*.sh
}

# Run all tests
# https://bats-core.readthedocs.io/en/stable/index.html
run_test() {
	bats \
		--print-output-on-failure \
		'spec/'
}

# Perform complete build
run_all() {
	set -o errexit # Exit on first error.
	run_lint
	run_test
}

# Start docker container
run_docker() {
	docker run --rm -it \
		-v "${PWD}:/app:ro" \
		-v "${PWD}/run:/usr/bin/run:ro" \
		-w /app \
		--entrypoint /usr/local/bin/bash \
		bats/bats:latest
}
