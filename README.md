# `run.sh`

With `run.sh`, you keep your project’s CLI commands neatly organized.

## Get the Runner

1. **[Download the latest version of the `run` tool here](https://github.com/jotaen/run.sh/releases)**
2. Make it executable (`chmod +x run`)
3. Put it into your `$PATH` (e.g. `mv run /usr/local/bin/run`, which might require `sudo` privileges)

### Requirements

- Linux or MacOS
- Bash 3.2 or higher

## Quick Start

To get started, put a file named `run.sh` into the root of your repository. There are two rules:

- All commands which are prefixed by `run_` are treated as tasks. They will be exposed through the `run` CLI tool.
- Comment blocks that precede tasks are interpreted as help text: the first line of the comment block is the task title, all subsequent lines are additional description.

Other than that, a `run.sh` file is an ordinary bash script.

```bash
# Print greeting
run_greet() {
  echo 'Hello World'
}
```

On the CLI, you can now invoke the “hello” task:

```
$ run greet
Hello World
```

In order to get an overview, explore all available tasks:

```
$ run --list
greet   Print greeting
```

If you don’t want to use the `run` tool, you can also source the `run.sh` file and reference the full task name directly.

```
$ . run.sh
run_greet
```

## Security Notice

One word about security: the `run` tool will evaluate the entire `run.sh` file on every invocation. To prevent execution of malicious code on your personal computer, you should always inspect untrusted `run.sh` files before using them.

## License

`run.sh` is free and open-source software distributed under the [MIT license](LICENSE.txt).
