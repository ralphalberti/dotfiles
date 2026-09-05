# Understanding the `hst` Zsh History Function

This reference explains the `hst` function piece by piece, with special
attention to Zsh syntax, shell `case` statements, positional parameters,
parameter expansion, pattern matching, pipelines, `grep`, and exit
status.

## Complete Function

``` zsh
hst() {
  local count="${1:-20}"

  case "$1" in
    "")
      fc -l -"$count"
      ;;

    -h|--help)
      cat <<'EOF'
Usage:
  hst [count]
  hst -g <search terms>
  hst -w <search terms>
  hst -h | --help

Options:
  -g    Search history for a substring
  -w    Search history for whole words
  -h    Show this help

Examples:
  hst
  hst 50
  hst -g git switch -c
  hst -w hist
EOF
      ;;

    -g)
      shift
      fc -l 1 | grep --color=auto -i -- " $*"
      ;;

    -w)
      shift
      fc -l 1 | grep --color=auto -iw -- " $*"
      ;;

    <->)
      fc -l -"$count"
      ;;

    *)
      print "hst: invalid argument: $1"
      print "Try 'hst --help' for usage."
      return 1
      ;;
  esac
}
```

## 1. Defining the Function

``` zsh
hst() {
```

This defines a shell function named `hst`. The general form is:

``` zsh
function_name() {
  commands
}
```

After Zsh reads the definition, typing `hst` runs these commands inside
the current shell rather than launching a separate executable script.

## 2. Local Variable, `$1`, and the Default

``` zsh
local count="${1:-20}"
```

`local` creates a variable whose scope is limited to this function.

Inside a function, `$1` is the first positional parameter---the first
argument passed to the function. `$2` is the second, `$3` the third, and
so on.

For:

``` bash
hst 50
```

`$1` is `50`.

For:

``` bash
hst -g git switch -c
```

the arguments initially are:

``` text
$1 = -g
$2 = git
$3 = switch
$4 = -c
```

`${1:-20}` is **parameter expansion**. The form:

``` zsh
${parameter:-default}
```

means: use the parameter if it is set and nonempty; otherwise use the
default.

Thus `hst 50` sets `count=50`, while plain `hst` sets `count=20`.

### `${1:-20}` is not `${1:20}`

These expressions mean completely different things:

``` zsh
${1:-20}
```

means "use `$1`, or default to `20`."

``` zsh
${1:20}
```

uses substring/array slicing syntax and means roughly "take `$1`
beginning at offset 20." It does **not** establish a default.

## 3. The Shell `case` Statement

``` zsh
case "$1" in
```

A shell `case` resembles a `switch` statement in other languages, but
its key feature is **pattern matching**.

General structure:

``` zsh
case VALUE in
  PATTERN)
    commands
    ;;

  PATTERN)
    commands
    ;;

  *)
    commands
    ;;
esac
```

The value being examined appears once after `case`. Each section
underneath is a branch containing a pattern. Zsh checks patterns from
top to bottom until one matches.

`esac` closes the statement. It is literally `case` spelled backward.

## 4. Multiple `case` Branches

A `case` statement can contain as many branches as needed:

``` zsh
case "$1" in
  start)
    print "Starting"
    ;;

  stop)
    print "Stopping"
    ;;

  restart)
    print "Restarting"
    ;;

  *)
    print "Unknown command"
    ;;
esac
```

Think of `start)`, `stop)`, and `restart)` as branches of **one** `case`
statement, not separate `case` statements.

The useful mental model is:

> Match one value against a sequence of patterns.

## 5. Combining Patterns with `|`

``` zsh
-h|--help)
```

Inside a `case` pattern, `|` means **OR**. This branch matches either
`-h` or `--help`.

Combining patterns is useful when multiple inputs should perform exactly
the same operation.

The same character has a different meaning between commands:

``` zsh
fc -l 1 | grep ...
```

There, `|` is a pipeline.

## 6. Empty Argument Branch

``` zsh
"")
  fc -l -"$count"
  ;;
```

`""` matches an empty `$1`, which occurs when you run:

``` bash
hst
```

Because `count` defaults to 20, this effectively executes:

``` bash
fc -l -20
```

## 7. `;;`

Each normal `case` branch ends with:

``` zsh
;;
```

Conceptually, this means: this branch is finished; stop processing the
`case` statement.

## 8. The Heredoc

The help branch uses:

``` zsh
cat <<'EOF'
Usage:
  ...
EOF
```

This is a **here-document**, usually called a **heredoc**. It supplies
all following lines to `cat` until a line containing exactly `EOF` is
reached.

Quoting the delimiter:

``` zsh
<<'EOF'
```

prevents shell expansion inside the text. For example, `$HOME` would
remain literal instead of expanding to a path. This is useful for static
help text.

## 9. The `-g` Search Branch

``` zsh
-g)
  shift
  fc -l 1 | grep --color=auto -i -- " $*"
  ;;
```

This performs a case-insensitive substring search of available shell
history.

For:

``` bash
hst -g git switch -c
```

the function initially receives `-g`, `git`, `switch`, and `-c` as
separate positional parameters.

## 10. `shift`

``` zsh
shift
```

`shift` discards `$1` and moves every remaining positional parameter one
position to the left.

Before:

``` text
$1 = -g
$2 = git
$3 = switch
$4 = -c
```

After:

``` text
$1 = git
$2 = switch
$3 = -c
```

This is a common shell technique for consuming command-line options.

## 11. `$*`

After `shift`, the function uses:

``` zsh
"$*"
```

In this context, `$*` combines all remaining positional parameters into
one string.

That lets this natural command work:

``` bash
hst -g git switch -c
```

without requiring:

``` bash
hst -g "git switch -c"
```

## 12. `fc -l 1`

``` zsh
fc -l 1
```

`fc` is a shell builtin for working with command history.

Here, `-l` means list history and `1` means begin with history event 1.
This lets `grep` search the available history rather than only the most
recent entries.

That is why searches such as `hst -w yay` can locate very old history
events.

## 13. Recent History vs. Oldest History

The minus sign in:

``` zsh
fc -l -"$count"
```

is unrelated to the `:-` in `${1:-20}`.

With `count=20`:

``` bash
fc -l -20
```

starts 20 events back from the recent end of history.

By contrast:

``` bash
fc -l 1 20
```

requests history events 1 through 20, assuming they are still retained.

So:

``` text
${1:-20}      default count is 20
fc -l -20     start 20 events back from recent history
fc -l 1 20    list history events 1 through 20
```

## 14. The Pipeline

``` zsh
fc -l 1 | grep ...
```

A pipe takes the standard output of the command on its left and makes it
the standard input of the command on its right:

``` text
Zsh history
     |
     v
  fc -l 1
     |
     v
    grep
     |
     v
matching history lines
```

This is a fundamental Unix shell idea: combine small tools to perform
more sophisticated operations.

## 15. `grep` Options

``` zsh
grep --color=auto -i -- " $*"
```

-   `--color=auto` highlights matching text when appropriate for
    terminal output.
-   `-i` makes matching case-insensitive.
-   `--` means "stop interpreting subsequent arguments as command
    options." This prevents user search text beginning with `-` from
    being mistaken for a `grep` option.

## 16. Why `" $*"` Starts with a Space

The search uses:

``` zsh
" $*"
```

rather than:

``` zsh
"$*"
```

The leading space is intentional. `fc -l` prints history numbers
followed by command text. Requiring a preceding space helps target the
command portion and, during development of `hst`, eliminated noisy
matches from text buried inside multi-line history entries.

## 17. Whole-Word Search

``` zsh
-w)
  shift
  fc -l 1 | grep --color=auto -iw -- " $*"
  ;;
```

This is almost identical to `-g`, but `grep -w` requires whole-word
matches.

Thus a broad search for `hist` can match `history`, while whole-word
search is intended to match `hist` as a word by itself.

## 18. Zsh's `<->` Numeric Pattern

``` zsh
<->)
  fc -l -"$count"
  ;;
```

`<->` is a **Zsh pattern** matching a decimal number.

It matches:

``` text
1
20
50
500
```

but not:

``` text
foo
-g
20x
```

So `hst 50` reaches this branch and effectively executes:

``` bash
fc -l -50
```

This is Zsh-specific pattern syntax rather than generic POSIX `sh`.

## 19. Pattern Matching Is the Key to `case`

Patterns do not need to be literal strings:

``` zsh
case "$1" in
  *.md)
    print "Markdown file"
    ;;

  *.lua)
    print "Lua file"
    ;;

  *.zsh)
    print "Zsh file"
    ;;

  *)
    print "Something else"
    ;;
esac
```

The shell is asking what **shape** the value has.

That same idea explains the patterns used by `hst`:

``` text
""
-h|--help
-g
-w
<->
*
```

## 20. The `*` Catch-All

``` zsh
*)
  print "hst: invalid argument: $1"
  print "Try 'hst --help' for usage."
  return 1
  ;;
```

`*` matches essentially anything. Since it appears last, it acts as the
error handler for inputs that did not match any valid branch.

## 21. `print`

`print` is a Zsh builtin for producing output. It fills a role similar
to `echo`, but provides well-defined Zsh behavior.

## 22. `return 1` and Exit Status

``` zsh
return 1
```

stops the function and reports an exit status of `1`.

Unix convention is:

``` text
0          success
nonzero    failure
```

The most recent exit status is available through `$?`.

For example:

``` bash
hst banana
echo $?
```

should report `1`.

After a successful command:

``` bash
hst 10
echo $?
```

the status will ordinarily be `0`.

## 23. Closing the Structures

``` zsh
  esac
}
```

`esac` closes the `case` statement and `}` closes the function.

Structurally:

``` text
function
|
+-- create local variable
|
+-- examine first argument with case
    |
    +-- empty         -> show last 20
    +-- -h/--help     -> show help
    +-- -g            -> substring search
    +-- -w            -> whole-word search
    +-- number        -> show that many entries
    +-- anything else -> report an error
```

## 24. Plain-English Reading

> Define `hst`. Set `count` to the first argument, or 20 if there is no
> first argument. Examine the first argument. If there is none, show 20
> recent history entries. If it is a help option, display help. If it is
> `-g`, remove that option and search the available history for the
> remaining text. If it is `-w`, do the same thing but require
> whole-word matches. If it is a number, display that many recent
> history entries. Anything else is an error.

Being able to reduce the source code mentally to that paragraph is a
good sign that the syntax is becoming readable rather than merely
recognizable.

## Quick Syntax Reference

  Syntax              Meaning in `hst`
  ------------------- ------------------------------------------------
  `hst() { ... }`     Define a Zsh function
  `local count=...`   Create a function-local variable
  `$1`, `$2`, ...     Positional parameters
  `${1:-20}`          Use `$1`, defaulting to `20` if unset/empty
  `case "$1" in`      Match `$1` against patterns
  `pattern)`          Begin a matching `case` branch
  `-h\|--help)`       Match either `-h` or `--help`
  `;;`                Finish the current `case` branch
  `esac`              End a `case` statement
  `<<'EOF'`           Begin a literal heredoc
  `shift`             Remove `$1` and shift remaining arguments left
  `$*`                All remaining positional parameters
  `\|`                Pipe output from one command to another
  `--`                Stop command-option parsing
  `<->`               Zsh pattern matching a decimal number
  `*`                 Catch-all pattern
  `print`             Zsh builtin for output
  `return 1`          Stop the function and report failure
  `$?`                Exit status of the previous command

## Useful Experiments

``` bash
hst
hst 10
hst -h
hst --help
hst -g git switch -c
hst -w git
hst banana
echo $?
```

To see `shift` in isolation:

``` zsh
args_demo() {
  print "Before:"
  print "1=$1"
  print "2=$2"
  print "3=$3"

  shift

  print "After shift:"
  print "1=$1"
  print "2=$2"
  print "All=$*"
}
```

Then:

``` bash
args_demo one two three
```

## Key Ideas to Remember

1.  **`case` is fundamentally a pattern matcher.** Think "match this
    value against these patterns."
2.  **Positional parameters are the function's arguments.** `$1` is
    first, `$2` second, and so on.
3.  **`shift` consumes an argument.** It is especially useful after
    recognizing an option such as `-g`.
4.  **Parameter expansion is punctuation-sensitive.** `${1:-20}` and
    `${1:20}` are entirely different operations.
5.  **Pipelines are central to shell programming.** `fc` produces
    history; `grep` filters it.
6.  **Exit status communicates success or failure.** `0` means success;
    nonzero means failure.
7.  **Zsh adds useful pattern syntax.** `<->` lets the `case` statement
    recognize numeric input cleanly.

`hst` is small enough to understand as a whole, but rich enough to serve
as a practical introduction to Zsh scripting.
