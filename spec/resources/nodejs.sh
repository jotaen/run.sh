#!/bin/bash

# Install NodeJS dependencies
run::install() {
	npm i
}

# Execute unit tests
run::test() {
	./node_modules/.bin/mocha \
		--recursive \
		'src/**/*.spec.js'
}

# Start web server
#
# Pass a port number optionally as argument, otherwise
# it falls back to 8080.
run::server() {
	node src/index.js \
		--port="${1:=8080}" \
		--debug=0 \
		--logging=INFO
}
