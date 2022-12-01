#!/usr/bin/env bats
# shellcheck disable=SC2154

load setup.sh

shebang::accepts_no_shebang() { #@test
	# shellcheck disable=SC2016
	create run.sh '
run::hello() {
	echo Hello
}
'

	run main hello
	[[ "${status}" -eq 0 ]]
}

shebang::accepts_bash_shebang() { #@test
	# shellcheck disable=SC2016
	create run.sh '#!/bin/bash
run::hello() {
	echo Hello
}
'

	run main hello
	[[ "${status}" -eq 0 ]]
}

shebang::accepts_bash_shebang_alternative() { #@test
	# shellcheck disable=SC2016
	create run.sh '#!/usr/bin/env bash
run::hello() {
	echo Hello
}
'

	run main hello
	[[ "${status}" -eq 0 ]]
}

shebang::rejects_other_shebang() { #@test
	# shellcheck disable=SC2016
	create run.sh '#!/bin/sh
run::hello() {
	echo Hello
}
'

	run main hello
	[[ "${status}" -eq 1 ]]
}
