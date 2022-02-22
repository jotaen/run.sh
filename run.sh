#!/usr/bin/env bash

set -o errexit # Exit script on first error

# Check code style
# The linting tool is “shellcheck”, see:
# https://github.com/koalaman/shellcheck
run_lint() {
	shellcheck \
		run \
		run.sh \
		spec/*.bats \
		spec/resources/*.sh
}

# Run all tests
# The testing runner is “bats”, see:
# https://bats-core.readthedocs.io/en/stable/index.html
run_test() {
	bats \
		--print-output-on-failure \
		'spec/'
}

# Perform complete build
run_all() {
	run_lint
	run_test
}

# Start build environment in docker container
# - The image contains all necessary tooling
# - The image will be created (and kept up to date) automatically
# - Inside the container, the `run` command is globally available
run_docker() {
	local image='jotaen/run-build-env'

	docker image rm -f "$(docker image ls -q "${image}")"

	docker build -t "${image}" .

	docker run --rm -it \
		-v "${PWD}:/app:ro" \
		-v "${PWD}/run:/usr/bin/run:ro" \
		-w /app \
		"${image}"
}
