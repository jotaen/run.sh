# run

## CLI args reference

The command structure is:
`run <OPTS...> <TASK> <INPUT>`

### `OPTS`:
- `--help`, `-h`: Print help
- `--list`, `-l`: Print overview of tasks (name + first line of help text)
- `--info <TASK>`, `-i <TASK>`: Print full help text of task
- `--verbose`, `-v`: Verbose (print command before executing)
- `--file <FILE>`, `-f <FILE>`: Use FILE instead of `./run.sh`

If no arg is given, it falls back to `--help`.

### `TASK`:
The name of one of the tasks in the `run.sh` file. These are shell functions with a `run_` prefix.

### `INPUT`:
Additional arguments, that are passed through to the task as input.
