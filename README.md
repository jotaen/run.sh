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

You can access all functions that are prefixed with `run_` from your command line. In this case: `run install`, `run test` and `run server`.

You can also explore the `run.sh` task file – for example, by listing all available tasks:

```
$ run --list
install   Install dependencies
test      Execute unit tests
server    Start server in dev mode
```

## Task files (`run.sh`)

Task files are regular bash scripts. In order for `run` to understand them, they need to follow a certain structure:

- A task is a bash function whose name is prefixed with `run_`
- Directly above the task, there can be a comment:
  + The first line of the comment is the task title. The task title is shown when running `run --list`.
  + All subsequent comment lines are the task description. A the description of a task can be shown by running `run --info install` (where `install` is the task name).

```bash
# Task Title
# Task description ...
# ...
run_taskname() {
	exit
}
```

## 3 good reasons for using `run`

- Storing shell commands in shell script files is a pretty obvious thing to do.
	+ Why wrap up you shell commands in yet another language?
	+ You don’t have to learn a whole new syntax for it.
  + You can use all familiar techniques of shell scripting.
- Consistent interface that is independent of the programming language of your project.
  + 
- Your task file is perfectly self-contained, even without the `run` tool itself.
	+ Re-use your tasks in any environment, by doing `source run.sh` and then invoking the `run_` tasks directly.
  + Everyone in the team can understand the file without having to use or know about `run`.

## License

`run` is free and open-source software distributed under the [MIT license](LICENSE.txt).
