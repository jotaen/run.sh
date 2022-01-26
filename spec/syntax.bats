#!/usr/bin/env bats
# shellcheck disable=SC2154

setup() {
	cd "${BATS_TEST_TMPDIR}" || exit 1
}

main() {
	"${BATS_TEST_DIRNAME}/../run" "$@"
}

test_parses_bash_syntax_variations() { #@test
	cp "${BATS_TEST_DIRNAME}/resources/formatting.sh" run.sh
	EXPECTED_OUTPUT="1
2
3
4"

	run main --list
	[[ "${status}" -eq 0 ]]
	[[ "${output}" == "${EXPECTED_OUTPUT}" ]]
}
