#!/usr/bin/env bash

# Check code style
# The linting tool is “shellcheck”, see:
# https://github.com/koalaman/shellcheck
run::lint() {
	shellcheck \
		run \
		run.sh \
		spec/*.bats \
		spec/resources/*.sh
}

# Run all tests
# The testing runner is “bats”, see:
# https://bats-core.readthedocs.io/en/stable/index.html
run::test() {
	bats \
		--print-output-on-failure \
		'spec/'
}

# Perform complete build
run::all() {
	set -o errexit
	run::lint
	run::test
}

# Start build/dev environment in docker container
# - The image contains all necessary tooling
# - The image will be created (and kept up to date) automatically
# - Inside the container, the `run` command is globally available
run::docker() {
	local image='jotaen/run-build-env'

	docker image rm -f "$(docker image ls -q "${image}")"

	docker build -t "${image}" .

	docker run --rm -it \
		-v "${PWD}:/app:ro" \
		-v "${PWD}/run:/usr/bin/run:ro" \
		-w /app \
		"${image}"
}
