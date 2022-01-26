# `run`

`run` is a utility for keeping your project’s CLI commands neatly organized.

## Get `run`

1. **[Download the latest version here](run)**
2. Make it executable (`chmod +x run`)
3. Put it into your path (e.g. `mv run /usr/local/bin/run`, which might require `sudo` privileges)

### Requirements

- Linux or MacOS
- Bash 3.2 or higher

## Example use-case

Let’s say you are developing a web server in Python. You have a bunch of CLI commands for installing dependencies, running the tests, or starting up the dev server. However, it can be tedious to memorize and type them in by hand every time.

With `run`, you can stash all these commands in a central task file (named `./run.sh`) in your project root:

```bash
# Install dependencies
run_install() {
  pip install --requirement requirements.txt
  pip install --requirement dev-requirements.txt
}

# Execute unit tests
run_test() {
  python \
    --module unittest \
    discover --pattern "*_test.py"
}

# Start server in dev mode
run_server() {
  python app/main.py \
    --port=8080 \
    --log=DEBUG \
    --devmode
}
```

You can access all functions that are prefixed with `run_` from your command line: `run install`, `run test` or `run server`.

You can also explore the `run.sh` task file – for example, by listing all available tasks:

```
$ run --list
install   Install dependencies
test      Execute unit tests
server    Start server in dev mode
```

## Task files (`run.sh`)

Task files are regular bash scripts. For `run` to understand them, they only need to follow a certain structure. Apart from that, no additional magic is involved.

```bash
GREETING='Hello World!'

# Task title
# Underneath the title, there can be more comment lines
# with arbitrary text.
run_greet() {
  echo $GREETING
}
```

## License

`run` is free and open-source software distributed under the [MIT license](LICENSE.txt).
