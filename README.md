# run.sh

With a `run.sh` file, you can keep your project’s CLI commands neatly organized.

## Get the Tool

1. [**Download** the latest version of the `run` tool](https://github.com/jotaen/run.sh/blob/main/run)
2. Make it executable (`chmod +x run`)
3. Put it into your `$PATH` (e.g. `mv run /usr/local/bin/run`, which might require admin privileges)

Tested on Linux and MacOS, with bash 3.2+.

## Quick Start

To get started, put a file named `run.sh` into the root of your repository. A `run.sh` file is an ordinary shell script that contains the definitions for your tasks. There are two rules:

- A task is a shell function whose name starts with `run_`. That way, it will be recognised and exposed through the `run` CLI tool.
- An (optional) preceding comment block is interpreted as the help text of a task: the first line of the comment block is the task title, all subsequent lines are additional description.

```bash
# Print greeting
run_greet() {
  echo 'Hello World'
}
```

On the CLI, you can invoke the “greet” task like so:

```
$ run greet
Hello World
```

In order to get an overview, explore all available tasks via:

```
$ run --list
greet   Print greeting
```

If you don’t want to use the `run` tool, you can also source the `run.sh` file and reference the canonical task name directly.

```
$ . run.sh
$ run_greet
Hello World
```

## Security Notice

The `run` tool will evaluate the entire `run.sh` file on every invocation. To prevent execution of malicious code on your personal computer, you should always inspect unknown `run.sh` files before using them.

## License

`run.sh` is free and open-source software distributed under the [MIT license](LICENSE.txt).
