setup() {
	cd "${BATS_TEST_TMPDIR}" || exit 1
}

main() {
	"${BATS_TEST_DIRNAME}/../run" "$@"
}

create() {
	FILE_PATH="$1"
	FILE_CONTENTS="$2"
	printf '%s' "$FILE_CONTENTS" > "$FILE_PATH"
	chmod +x "$FILE_PATH"
}

create_from() {
	FILE_PATH_DEST="$1"
	FILE_PATH_SRC="$2"
	create "${FILE_PATH_DEST}" "$(cat "${FILE_PATH_SRC}")"
}
