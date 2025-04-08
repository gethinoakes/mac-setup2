Directory structure:
└── charmbracelet-gum/
├── README.md
├── Dockerfile
├── LICENSE
├── default.nix
├── flake.lock
├── flake.nix
├── go.mod
├── go.sum
├── gum.go
├── main.go
├── .golangci-soft.yml
├── .golangci.yml
├── .goreleaser.yml
├── choose/
│ ├── choose.go
│ ├── command.go
│ └── options.go
├── completion/
│ ├── bash.go
│ ├── command.go
│ ├── fish.go
│ └── zsh.go
├── confirm/
│ ├── command.go
│ ├── confirm.go
│ └── options.go
├── cursor/
│ └── cursor.go
├── examples/
│ ├── README.md
│ ├── choose.tape
│ ├── commit.sh
│ ├── commit.tape
│ ├── confirm.tape
│ ├── convert-to-gif.sh
│ ├── customize.tape
│ ├── demo.sh
│ ├── demo.tape
│ ├── diyfetch
│ ├── fav.txt
│ ├── file.tape
│ ├── filter-key-value.sh
│ ├── flavors.txt
│ ├── format.ansi
│ ├── git-branch-manager.sh
│ ├── git-stage.sh
│ ├── gum.js
│ ├── gum.py
│ ├── gum.rb
│ ├── input.tape
│ ├── kaomoji.sh
│ ├── magic.sh
│ ├── pager.tape
│ ├── posix.sh
│ ├── skate.sh
│ ├── spin.tape
│ ├── story.txt
│ ├── test.sh
│ ├── write.tape
│ └── .gitignore
├── file/
│ ├── command.go
│ ├── file.go
│ └── options.go
├── filter/
│ ├── command.go
│ ├── filter.go
│ ├── filter_test.go
│ └── options.go
├── format/
│ ├── README.md
│ ├── command.go
│ ├── formats.go
│ └── options.go
├── input/
│ ├── command.go
│ ├── input.go
│ └── options.go
├── internal/
│ ├── decode/
│ │ └── align.go
│ ├── exit/
│ │ └── exit.go
│ ├── files/
│ │ └── files.go
│ ├── log/
│ │ └── log.go
│ ├── stack/
│ │ └── stack.go
│ ├── stdin/
│ │ └── stdin.go
│ ├── timeout/
│ │ └── context.go
│ ├── tty/
│ │ └── tty.go
│ └── utils/
│ └── utils.go
├── join/
│ ├── command.go
│ └── options.go
├── log/
│ ├── command.go
│ └── options.go
├── man/
│ └── command.go
├── pager/
│ ├── command.go
│ ├── options.go
│ ├── pager.go
│ └── search.go
├── spin/
│ ├── command.go
│ ├── options.go
│ ├── pty.go
│ ├── spin.go
│ └── spinners.go
├── style/
│ ├── ascii_a.txt
│ ├── borders.go
│ ├── command.go
│ ├── lipgloss.go
│ ├── options.go
│ └── spacing.go
├── table/
│ ├── bom.csv
│ ├── comma.csv
│ ├── command.go
│ ├── example.csv
│ ├── invalid.csv
│ ├── options.go
│ └── table.go
├── version/
│ ├── command.go
│ └── options.go
├── write/
│ ├── command.go
│ ├── options.go
│ └── write.go
└── .github/
├── CODEOWNERS
├── dependabot.yml
├── pull_request_template.md
├── ISSUE_TEMPLATE/
│ ├── bug_report.md
│ └── feature_request.md
└── workflows/
├── build.yml
├── dependabot-sync.yml
├── goreleaser.yml
├── lint-soft.yml
├── lint.yml
└── nightly.yml

Files Content:

================================================
File: README.md
================================================

# Gum

<p>
    <a href="https://stuff.charm.sh/gum/nutritional-information.png" target="_blank"><img src="https://stuff.charm.sh/gum/gum.png" alt="Gum Image" width="450" /></a>
    <br><br>
    <a href="https://github.com/charmbracelet/gum/releases"><img src="https://img.shields.io/github/release/charmbracelet/gum.svg" alt="Latest Release"></a>
    <a href="https://pkg.go.dev/github.com/charmbracelet/gum?tab=doc"><img src="https://godoc.org/github.com/golang/gddo?status.svg" alt="Go Docs"></a>
    <a href="https://github.com/charmbracelet/gum/actions"><img src="https://github.com/charmbracelet/gum/workflows/build/badge.svg" alt="Build Status"></a>
</p>

A tool for glamorous shell scripts. Leverage the power of
[Bubbles](https://github.com/charmbracelet/bubbles) and [Lip
Gloss](https://github.com/charmbracelet/lipgloss) in your scripts and aliases
without writing any Go code!

<img alt="Shell running the ./demo.sh script" width="600" src="https://vhs.charm.sh/vhs-1qY57RrQlXCuydsEgDp68G.gif">

The above example is running from a single shell script ([source](./examples/demo.sh)).

## Tutorial

Gum provides highly configurable, ready-to-use utilities to help you write
useful shell scripts and dotfiles aliases with just a few lines of code.
Let's build a simple script to help you write
[Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#summary)
for your dotfiles.

Ask for the commit type with gum choose:

```bash
gum choose "fix" "feat" "docs" "style" "refactor" "test" "chore" "revert"
```

> [!NOTE]
> This command itself will print to stdout which is not all that useful. To make use of the command later on you can save the stdout to a `$VARIABLE` or `file.txt`.

Prompt for the scope of these changes:

```bash
gum input --placeholder "scope"
```

Prompt for the summary and description of changes:

```bash
gum input --value "$TYPE$SCOPE: " --placeholder "Summary of this change"
gum write --placeholder "Details of this change"
```

Confirm before committing:

```bash
gum confirm "Commit changes?" && git commit -m "$SUMMARY" -m "$DESCRIPTION"
```

Check out the [complete example](https://github.com/charmbracelet/gum/blob/main/examples/commit.sh) for combining these commands in a single script.

<img alt="Running the ./examples/commit.sh script to commit to git" width="600" src="https://vhs.charm.sh/vhs-7rRq3LsEuJVwhwr0xf6Er7.gif">

## Installation

Use a package manager:

```bash
# macOS or Linux
brew install gum

# Arch Linux (btw)
pacman -S gum

# Nix
nix-env -iA nixpkgs.gum

# Flox
flox install gum

# Windows (via WinGet or Scoop)
winget install charmbracelet.gum
scoop install charm-gum
```

<details>
<summary>Debian/Ubuntu</summary>

```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install gum
```

</details>

<details>
<summary>Fedora/RHEL/OpenSuse</summary>

```bash
echo '[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgcheck=1
gpgkey=https://repo.charm.sh/yum/gpg.key' | sudo tee /etc/yum.repos.d/charm.repo
sudo rpm --import https://repo.charm.sh/yum/gpg.key

# yum
sudo yum install gum

# zypper
sudo zypper refresh
sudo zypper install gum
```

</details>

<details>
<summary>FreeBSD</summary>

```bash
# packages
sudo pkg install gum

# ports
cd /usr/ports/devel/gum && sudo make install clean
```

</details>

Or download it:

- [Packages][releases] are available in Debian, RPM, and Alpine formats
- [Binaries][releases] are available for Linux, macOS, Windows, FreeBSD, OpenBSD, and NetBSD

Or just install it with `go`:

```bash
go install github.com/charmbracelet/gum@latest
```

[releases]: https://github.com/charmbracelet/gum/releases

## Commands

- [`choose`](#choose): Choose an option from a list of choices
- [`confirm`](#confirm): Ask a user to confirm an action
- [`file`](#file): Pick a file from a folder
- [`filter`](#filter): Filter items from a list
- [`format`](#format): Format a string using a template
- [`input`](#input): Prompt for some input
- [`join`](#join): Join text vertically or horizontally
- [`pager`](#pager): Scroll through a file
- [`spin`](#spin): Display spinner while running a command
- [`style`](#style): Apply coloring, borders, spacing to text
- [`table`](#table): Render a table of data
- [`write`](#write): Prompt for long-form text
- [`log`](#log): Log messages to output

## Customization

You can customize `gum` options and styles with `--flags` and `$ENVIRONMENT_VARIABLES`.
See `gum <command> --help` for a full view of each command's customization and configuration options.

Customize with `--flags`:

```bash

gum input --cursor.foreground "#FF0" \
          --prompt.foreground "#0FF" \
          --placeholder "What's up?" \
          --prompt "* " \
          --width 80 \
          --value "Not much, hby?"
```

Customize with `ENVIRONMENT_VARIABLES`:

```bash
export GUM_INPUT_CURSOR_FOREGROUND="#FF0"
export GUM_INPUT_PROMPT_FOREGROUND="#0FF"
export GUM_INPUT_PLACEHOLDER="What's up?"
export GUM_INPUT_PROMPT="* "
export GUM_INPUT_WIDTH=80

# --flags can override values set with environment
gum input
```

<img alt="Gum input displaying most customization options" width="600" src="https://vhs.charm.sh/vhs-5zb9DlQYA70aL9ZpYLTwKv.gif">

## Input

Prompt for input with a simple command.

```bash
gum input > answer.txt
gum input --password > password.txt
```

<img src="https://vhs.charm.sh/vhs-1nScrStFI3BMlCp5yrLtyg.gif" width="600" alt="Shell running gum input typing Not much, you?" />

## Write

Prompt for some multi-line text (`ctrl+d` to complete text entry).

```bash
gum write > story.txt
```

<img src="https://vhs.charm.sh/vhs-7abdKKrUEukgx9aJj8O5GX.gif" width="600" alt="Shell running gum write typing a story" />

## Filter

Filter a list of values with fuzzy matching:

```bash
echo Strawberry >> flavors.txt
echo Banana >> flavors.txt
echo Cherry >> flavors.txt
gum filter < flavors.txt > selection.txt
```

<img src="https://vhs.charm.sh/vhs-61euOQtKPtQVD7nDpHQhzr.gif" width="600" alt="Shell running gum filter on different bubble gum flavors" />

Select multiple options with the `--limit` flag or `--no-limit` flag. Use `tab` or `ctrl+space` to select, `enter` to confirm.

```bash
cat flavors.txt | gum filter --limit 2
cat flavors.txt | gum filter --no-limit
```

## Choose

Choose an option from a list of choices.

```bash
echo "Pick a card, any card..."
CARD=$(gum choose --height 15 {{A,K,Q,J},{10..2}}" "{♠,♥,♣,♦})
echo "Was your card the $CARD?"
```

You can also select multiple items with the `--limit` or `--no-limit` flag, which determines
the maximum of items that can be chosen.

```bash
cat songs.txt | gum choose --limit 5
cat foods.txt | gum choose --no-limit --header "Grocery Shopping"
```

<img src="https://vhs.charm.sh/vhs-3zV1LvofA6Cbn5vBu1NHHl.gif" width="600" alt="Shell running gum choose with numbers and gum flavors" />

## Confirm

Confirm whether to perform an action. Exits with code `0` (affirmative) or `1`
(negative) depending on selection.

```bash
gum confirm && rm file.txt || echo "File not removed"
```

<img src="https://vhs.charm.sh/vhs-3xRFvbeQ4lqGerbHY7y3q2.gif" width="600" alt="Shell running gum confirm" />

## File

Prompt the user to select a file from the file tree.

```bash
EDITOR $(gum file $HOME)
```

<img src="https://vhs.charm.sh/vhs-2RMRqmnOPneneIgVJJ3mI1.gif" width="600" alt="Shell running gum file" />

## Pager

Scroll through a long document with line numbers and a fully customizable viewport.

```bash
gum pager < README.md
```

<img src="https://vhs.charm.sh/vhs-3iMDpgOLmbYr0jrYEGbk7p.gif" width="600" alt="Shell running gum pager" />

## Spin

Display a spinner while running a script or command. The spinner will
automatically stop after the given command exits.

To view or pipe the command's output, use the `--show-output` flag.

```bash
gum spin --spinner dot --title "Buying Bubble Gum..." -- sleep 5
```

<img src="https://vhs.charm.sh/vhs-3YFswCmoY4o3Q7MyzWl6sS.gif" width="600" alt="Shell running gum spin while sleeping for 5 seconds" />

Available spinner types include: `line`, `dot`, `minidot`, `jump`, `pulse`, `points`, `globe`, `moon`, `monkey`, `meter`, `hamburger`.

## Table

Select a row from some tabular data.

```bash
gum table < flavors.csv | cut -d ',' -f 1
```

<!-- <img src="https://stuff.charm.sh/gum/table.gif" width="600" alt="Shell running gum table" /> -->

## Style

Pretty print any string with any layout with one command.

```bash
gum style \
	--foreground 212 --border-foreground 212 --border double \
	--align center --width 50 --margin "1 2" --padding "2 4" \
	'Bubble Gum (1¢)' 'So sweet and so fresh!'
```

<img src="https://github.com/charmbracelet/gum/assets/42545625/67468acf-b3e0-4e78-bd89-360739eb44fa" width="600" alt="Bubble Gum, So sweet and so fresh!" />

## Join

Combine text vertically or horizontally. Use this command with `gum style` to
build layouts and pretty output.

Tip: Always wrap the output of `gum style` in quotes to preserve newlines
(`\n`) when using it as an argument in the `join` command.

```bash
I=$(gum style --padding "1 5" --border double --border-foreground 212 "I")
LOVE=$(gum style --padding "1 4" --border double --border-foreground 57 "LOVE")
BUBBLE=$(gum style --padding "1 8" --border double --border-foreground 255 "Bubble")
GUM=$(gum style --padding "1 5" --border double --border-foreground 240 "Gum")

I_LOVE=$(gum join "$I" "$LOVE")
BUBBLE_GUM=$(gum join "$BUBBLE" "$GUM")
gum join --align center --vertical "$I_LOVE" "$BUBBLE_GUM"
```

<img src="https://github.com/charmbracelet/gum/assets/42545625/68f7a25d-b495-48dd-982a-cee0c8ea5786" width="600" alt="I LOVE Bubble Gum written out in four boxes with double borders around them." />

## Format

`format` processes and formats bodies of text. `gum format` can parse markdown,
template strings, and named emojis.

```bash
# Format some markdown
gum format -- "# Gum Formats" "- Markdown" "- Code" "- Template" "- Emoji"
echo "# Gum Formats\n- Markdown\n- Code\n- Template\n- Emoji" | gum format

# Syntax highlight some code
cat main.go | gum format -t code

# Render text any way you want with templates
echo '{{ Bold "Tasty" }} {{ Italic "Bubble" }} {{ Color "99" "0" " Gum " }}' \
    | gum format -t template

# Display your favorite emojis!
echo 'I :heart: Bubble Gum :candy:' | gum format -t emoji
```

For more information on template helpers, see the [Termenv
docs](https://github.com/muesli/termenv#template-helpers). For a full list of
named emojis see the [GitHub API](https://api.github.com/emojis).

<img src="https://github.com/charmbracelet/gum/assets/42545625/5cfbb0c8-0022-460d-841b-fec37527ca66" width="300" alt="Running gum format for different types of formats" />

## Log

`log` logs messages to the terminal at using different levels and styling using
the [`charmbracelet/log`](https://github.com/charmbracelet/log) library.

```bash
# Log some debug information.
gum log --structured --level debug "Creating file..." name file.txt
# DEBUG Unable to create file. name=temp.txt

# Log some error.
gum log --structured --level error "Unable to create file." name file.txt
# ERROR Unable to create file. name=temp.txt

# Include a timestamp.
gum log --time rfc822 --level error "Unable to create file."
```

See the Go [`time` package](https://pkg.go.dev/time#pkg-constants) for acceptable `--time` formats.

See [`charmbracelet/log`](https://github.com/charmbracelet/log) for more usage.

<img src="https://vhs.charm.sh/vhs-6jupuFM0s2fXiUrBE0I1vU.gif" width="600" alt="Running gum log with debug and error levels" />

## Examples

How to use `gum` in your daily workflows:

See the [examples](./examples/) directory for more real world use cases.

- Write a commit message:

```bash
git commit -m "$(gum input --width 50 --placeholder "Summary of changes")" \
           -m "$(gum write --width 80 --placeholder "Details of changes")"
```

- Open files in your `$EDITOR`

```bash
$EDITOR $(gum filter)
```

- Connect to a `tmux` session

```bash
SESSION=$(tmux list-sessions -F \#S | gum filter --placeholder "Pick session...")
tmux switch-client -t "$SESSION" || tmux attach -t "$SESSION"
```

- Pick a commit hash from `git` history

```bash
git log --oneline | gum filter | cut -d' ' -f1 # | copy
```

- Simple [`skate`](https://github.com/charmbracelet/skate) password selector.

```
skate list -k | gum filter | xargs skate get
```

- Uninstall packages

```bash
brew list | gum choose --no-limit | xargs brew uninstall
```

- Clean up `git` branches

```bash
git branch | cut -c 3- | gum choose --no-limit | xargs git branch -D
```

- Checkout GitHub pull requests with [`gh`](https://cli.github.com/)

```bash
gh pr list | cut -f1,2 | gum choose | cut -f1 | xargs gh pr checkout
```

- Copy command from shell history

```bash
gum filter < $HISTFILE --height 20
```

- `sudo` replacement

```bash
alias please="gum input --password | sudo -nS"
```

## Feedback

We’d love to hear your thoughts on this project. Feel free to drop us a note!

- [Twitter](https://twitter.com/charmcli)
- [The Fediverse](https://mastodon.social/@charmcli)
- [Discord](https://charm.sh/chat)

## License

[MIT](https://github.com/charmbracelet/gum/raw/main/LICENSE)

---

Part of [Charm](https://charm.sh).

<a href="https://charm.sh/"><img alt="The Charm logo" src="https://stuff.charm.sh/charm-badge.jpg" width="400" /></a>

Charm 热爱开源 • Charm loves open source

================================================
File: Dockerfile
================================================
FROM gcr.io/distroless/static
COPY gum /usr/local/bin/gum
ENTRYPOINT [ "/usr/local/bin/gum" ]

================================================
File: LICENSE
================================================
MIT License

Copyright (c) 2022-2024 Charmbracelet, Inc

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

================================================
File: default.nix
================================================
{ pkgs }:

pkgs.buildGoModule rec {
pname = "gum";
version = "0.15.2";

src = ./.;

vendorHash = "sha256-TK2Fc4bTkiSpyYrg4dJOzamEnii03P7kyHZdah9izqY=";

ldflags = [ "-s" "-w" "-X=main.Version=${version}" ];
}

================================================
File: flake.lock
================================================
{
"nodes": {
"flake-utils": {
"inputs": {
"systems": "systems"
},
"locked": {
"lastModified": 1731533236,
"narHash": "sha256-l0KFg5HjrsfsO/JpG+r7fRrqm12kzFHyUHqHCVpMMbI=",
"owner": "numtide",
"repo": "flake-utils",
"rev": "11707dc2f618dd54ca8739b309ec4fc024de578b",
"type": "github"
},
"original": {
"owner": "numtide",
"repo": "flake-utils",
"type": "github"
}
},
"nixpkgs": {
"locked": {
"lastModified": 1737062831,
"narHash": "sha256-Tbk1MZbtV2s5aG+iM99U8FqwxU/YNArMcWAv6clcsBc=",
"owner": "nixos",
"repo": "nixpkgs",
"rev": "5df43628fdf08d642be8ba5b3625a6c70731c19c",
"type": "github"
},
"original": {
"owner": "nixos",
"ref": "nixos-unstable",
"repo": "nixpkgs",
"type": "github"
}
},
"root": {
"inputs": {
"flake-utils": "flake-utils",
"nixpkgs": "nixpkgs"
}
},
"systems": {
"locked": {
"lastModified": 1681028828,
"narHash": "sha256-Vy1rq5AaRuLzOxct8nz4T6wlgyUR7zLU309k9mBC768=",
"owner": "nix-systems",
"repo": "default",
"rev": "da67096a3b9bf56a91d16901293e51ba5b49a27e",
"type": "github"
},
"original": {
"owner": "nix-systems",
"repo": "default",
"type": "github"
}
}
},
"root": "root",
"version": 7
}

================================================
File: flake.nix
================================================
{
description = "A tool for glamorous shell scripts";

inputs = {
nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
flake-utils.url = "github:numtide/flake-utils";
};

outputs = { self, nixpkgs, flake-utils }:
flake-utils.lib.eachDefaultSystem (system:
let pkgs = import nixpkgs { inherit system; }; in
rec {
packages.default = import ./default.nix { inherit pkgs; };
}) // {
overlays.default = final: prev: {
gum = import ./default.nix { pkgs = final; };
};
};
}

================================================
File: go.mod
================================================
module github.com/charmbracelet/gum

go 1.23.0

toolchain go1.24.1

require (
github.com/Masterminds/semver/v3 v3.3.1
github.com/alecthomas/kong v1.9.0
github.com/alecthomas/mango-kong v0.1.0
github.com/charmbracelet/bubbles v0.20.0
github.com/charmbracelet/bubbletea v1.3.4
github.com/charmbracelet/glamour v0.9.1
github.com/charmbracelet/lipgloss v1.1.0
github.com/charmbracelet/log v0.4.1
github.com/charmbracelet/x/ansi v0.8.0
github.com/charmbracelet/x/editor v0.1.0
github.com/charmbracelet/x/term v0.2.1
github.com/charmbracelet/x/xpty v0.1.2
github.com/muesli/roff v0.1.0
github.com/muesli/termenv v0.16.0
github.com/rivo/uniseg v0.4.7
github.com/sahilm/fuzzy v0.1.1
golang.org/x/text v0.23.0
)

require (
github.com/alecthomas/chroma/v2 v2.14.0 // indirect
github.com/atotto/clipboard v0.1.4 // indirect
github.com/aymanbagabas/go-osc52/v2 v2.0.1 // indirect
github.com/aymerick/douceur v0.2.0 // indirect
github.com/charmbracelet/colorprofile v0.2.3-0.20250311203215-f60798e515dc // indirect
github.com/charmbracelet/x/cellbuf v0.0.13-0.20250311204145-2c3ea96c31dd // indirect
github.com/charmbracelet/x/conpty v0.1.0 // indirect
github.com/charmbracelet/x/errors v0.0.0-20240508181413-e8d8b6e2de86 // indirect
github.com/charmbracelet/x/termios v0.1.1 // indirect
github.com/creack/pty v1.1.24 // indirect
github.com/dlclark/regexp2 v1.11.0 // indirect
github.com/dustin/go-humanize v1.0.1 // indirect
github.com/erikgeiser/coninput v0.0.0-20211004153227-1c3628e74d0f // indirect
github.com/go-logfmt/logfmt v0.6.0 // indirect
github.com/gorilla/css v1.0.1 // indirect
github.com/lucasb-eyer/go-colorful v1.2.0 // indirect
github.com/mattn/go-isatty v0.0.20 // indirect
github.com/mattn/go-localereader v0.0.1 // indirect
github.com/mattn/go-runewidth v0.0.16 // indirect
github.com/microcosm-cc/bluemonday v1.0.27 // indirect
github.com/muesli/ansi v0.0.0-20230316100256-276c6243b2f6 // indirect
github.com/muesli/cancelreader v0.2.2 // indirect
github.com/muesli/mango v0.2.0 // indirect
github.com/muesli/reflow v0.3.0 // indirect
github.com/xo/terminfo v0.0.0-20220910002029-abceb7e1c41e // indirect
github.com/yuin/goldmark v1.7.8 // indirect
github.com/yuin/goldmark-emoji v1.0.5 // indirect
golang.org/x/exp v0.0.0-20240613232115-7f521ea00fb8 // indirect
golang.org/x/net v0.33.0 // indirect
golang.org/x/sync v0.12.0 // indirect
golang.org/x/sys v0.31.0 // indirect
golang.org/x/term v0.30.0 // indirect
)

================================================
File: go.sum
================================================
github.com/MakeNowJust/heredoc v1.0.0 h1:cXCdzVdstXyiTqTvfqk9SDHpKNjxuom+DOlyEeQ4pzQ=
github.com/MakeNowJust/heredoc v1.0.0/go.mod h1:mG5amYoWBHf8vpLOuehzbGGw0EHxpZZ6lCpQ4fNJ8LE=
github.com/Masterminds/semver/v3 v3.3.1 h1:QtNSWtVZ3nBfk8mAOu/B6v7FMJ+NHTIgUPi7rj+4nv4=
github.com/Masterminds/semver/v3 v3.3.1/go.mod h1:4V+yj/TJE1HU9XfppCwVMZq3I84lprf4nC11bSS5beM=
github.com/alecthomas/assert/v2 v2.11.0 h1:2Q9r3ki8+JYXvGsDyBXwH3LcJ+WK5D0gc5E8vS6K3D0=
github.com/alecthomas/assert/v2 v2.11.0/go.mod h1:Bze95FyfUr7x34QZrjL+XP+0qgp/zg8yS+TtBj1WA3k=
github.com/alecthomas/chroma/v2 v2.14.0 h1:R3+wzpnUArGcQz7fCETQBzO5n9IMNi13iIs46aU4V9E=
github.com/alecthomas/chroma/v2 v2.14.0/go.mod h1:QolEbTfmUHIMVpBqxeDnNBj2uoeI4EbYP4i6n68SG4I=
github.com/alecthomas/kong v1.9.0 h1:Wgg0ll5Ys7xDnpgYBuBn/wPeLGAuK0NvYmEcisJgrIs=
github.com/alecthomas/kong v1.9.0/go.mod h1:p2vqieVMeTAnaC83txKtXe8FLke2X07aruPWXyMPQrU=
github.com/alecthomas/mango-kong v0.1.0 h1:iFVfP1k1K4qpml3JUQmD5I8MCQYfIvsD9mRdrw7jJC4=
github.com/alecthomas/mango-kong v0.1.0/go.mod h1:t+TYVdsONUolf/BwVcm+15eqcdAj15h4Qe9MMFAwwT4=
github.com/alecthomas/repr v0.4.0 h1:GhI2A8MACjfegCPVq9f1FLvIBS+DrQ2KQBFZP1iFzXc=
github.com/alecthomas/repr v0.4.0/go.mod h1:Fr0507jx4eOXV7AlPV6AVZLYrLIuIeSOWtW57eE/O/4=
github.com/atotto/clipboard v0.1.4 h1:EH0zSVneZPSuFR11BlR9YppQTVDbh5+16AmcJi4g1z4=
github.com/atotto/clipboard v0.1.4/go.mod h1:ZY9tmq7sm5xIbd9bOK4onWV4S6X0u6GY7Vn0Yu86PYI=
github.com/aymanbagabas/go-osc52/v2 v2.0.1 h1:HwpRHbFMcZLEVr42D4p7XBqjyuxQH5SMiErDT4WkJ2k=
github.com/aymanbagabas/go-osc52/v2 v2.0.1/go.mod h1:uYgXzlJ7ZpABp8OJ+exZzJJhRNQ2ASbcXHWsFqH8hp8=
github.com/aymanbagabas/go-udiff v0.2.0 h1:TK0fH4MteXUDspT88n8CKzvK0X9O2xu9yQjWpi6yML8=
github.com/aymanbagabas/go-udiff v0.2.0/go.mod h1:RE4Ex0qsGkTAJoQdQQCA0uG+nAzJO/pI/QwceO5fgrA=
github.com/aymerick/douceur v0.2.0 h1:Mv+mAeH1Q+n9Fr+oyamOlAkUNPWPlA8PPGR0QAaYuPk=
github.com/aymerick/douceur v0.2.0/go.mod h1:wlT5vV2O3h55X9m7iVYN0TBM0NH/MmbLnd30/FjWUq4=
github.com/charmbracelet/bubbles v0.20.0 h1:jSZu6qD8cRQ6k9OMfR1WlM+ruM8fkPWkHvQWD9LIutE=
github.com/charmbracelet/bubbles v0.20.0/go.mod h1:39slydyswPy+uVOHZ5x/GjwVAFkCsV8IIVy+4MhzwwU=
github.com/charmbracelet/bubbletea v1.3.4 h1:kCg7B+jSCFPLYRA52SDZjr51kG/fMUEoPoZrkaDHyoI=
github.com/charmbracelet/bubbletea v1.3.4/go.mod h1:dtcUCyCGEX3g9tosuYiut3MXgY/Jsv9nKVdibKKRRXo=
github.com/charmbracelet/colorprofile v0.2.3-0.20250311203215-f60798e515dc h1:4pZI35227imm7yK2bGPcfpFEmuY1gc2YSTShr4iJBfs=
github.com/charmbracelet/colorprofile v0.2.3-0.20250311203215-f60798e515dc/go.mod h1:X4/0JoqgTIPSFcRA/P6INZzIuyqdFY5rm8tb41s9okk=
github.com/charmbracelet/glamour v0.9.1 h1:11dEfiGP8q1BEqvGoIjivuc2rBk+5qEXdPtaQ2WoiCM=
github.com/charmbracelet/glamour v0.9.1/go.mod h1:+SHvIS8qnwhgTpVMiXwn7OfGomSqff1cHBCI8jLOetk=
github.com/charmbracelet/lipgloss v1.1.0 h1:vYXsiLHVkK7fp74RkV7b2kq9+zDLoEU4MZoFqR/noCY=
github.com/charmbracelet/lipgloss v1.1.0/go.mod h1:/6Q8FR2o+kj8rz4Dq0zQc3vYf7X+B0binUUBwA0aL30=
github.com/charmbracelet/log v0.4.1 h1:6AYnoHKADkghm/vt4neaNEXkxcXLSV2g1rdyFDOpTyk=
github.com/charmbracelet/log v0.4.1/go.mod h1:pXgyTsqsVu4N9hGdHmQ0xEA4RsXof402LX9ZgiITn2I=
github.com/charmbracelet/x/ansi v0.8.0 h1:9GTq3xq9caJW8ZrBTe0LIe2fvfLR/bYXKTx2llXn7xE=
github.com/charmbracelet/x/ansi v0.8.0/go.mod h1:wdYl/ONOLHLIVmQaxbIYEC/cRKOQyjTkowiI4blgS9Q=
github.com/charmbracelet/x/cellbuf v0.0.13-0.20250311204145-2c3ea96c31dd h1:vy0GVL4jeHEwG5YOXDmi86oYw2yuYUGqz6a8sLwg0X8=
github.com/charmbracelet/x/cellbuf v0.0.13-0.20250311204145-2c3ea96c31dd/go.mod h1:xe0nKWGd3eJgtqZRaN9RjMtK7xUYchjzPr7q6kcvCCs=
github.com/charmbracelet/x/conpty v0.1.0 h1:4zc8KaIcbiL4mghEON8D72agYtSeIgq8FSThSPQIb+U=
github.com/charmbracelet/x/conpty v0.1.0/go.mod h1:rMFsDJoDwVmiYM10aD4bH2XiRgwI7NYJtQgl5yskjEQ=
github.com/charmbracelet/x/editor v0.1.0 h1:p69/dpvlwRTs9uYiPeAWruwsHqTFzHhTvQOd/WVSX98=
github.com/charmbracelet/x/editor v0.1.0/go.mod h1:oivrEbcP/AYt/Hpvk5pwDXXrQ933gQS6UzL6fxqAGSA=
github.com/charmbracelet/x/errors v0.0.0-20240508181413-e8d8b6e2de86 h1:JSt3B+U9iqk37QUU2Rvb6DSBYRLtWqFqfxf8l5hOZUA=
github.com/charmbracelet/x/errors v0.0.0-20240508181413-e8d8b6e2de86/go.mod h1:2P0UgXMEa6TsToMSuFqKFQR+fZTO9CNGUNokkPatT/0=
github.com/charmbracelet/x/exp/golden v0.0.0-20240815200342-61de596daa2b h1:MnAMdlwSltxJyULnrYbkZpp4k58Co7Tah3ciKhSNo0Q=
github.com/charmbracelet/x/exp/golden v0.0.0-20240815200342-61de596daa2b/go.mod h1:wDlXFlCrmJ8J+swcL/MnGUuYnqgQdW9rhSD61oNMb6U=
github.com/charmbracelet/x/term v0.2.1 h1:AQeHeLZ1OqSXhrAWpYUtZyX1T3zVxfpZuEQMIQaGIAQ=
github.com/charmbracelet/x/term v0.2.1/go.mod h1:oQ4enTYFV7QN4m0i9mzHrViD7TQKvNEEkHUMCmsxdUg=
github.com/charmbracelet/x/termios v0.1.1 h1:o3Q2bT8eqzGnGPOYheoYS8eEleT5ZVNYNy8JawjaNZY=
github.com/charmbracelet/x/termios v0.1.1/go.mod h1:rB7fnv1TgOPOyyKRJ9o+AsTU/vK5WHJ2ivHeut/Pcwo=
github.com/charmbracelet/x/xpty v0.1.2 h1:Pqmu4TEJ8KeA9uSkISKMU3f+C1F6OGBn8ABuGlqCbtI=
github.com/charmbracelet/x/xpty v0.1.2/go.mod h1:XK2Z0id5rtLWcpeNiMYBccNNBrP2IJnzHI0Lq13Xzq4=
github.com/creack/pty v1.1.24 h1:bJrF4RRfyJnbTJqzRLHzcGaZK1NeM5kTC9jGgovnR1s=
github.com/creack/pty v1.1.24/go.mod h1:08sCNb52WyoAwi2QDyzUCTgcvVFhUzewun7wtTfvcwE=
github.com/davecgh/go-spew v1.1.1 h1:vj9j/u1bqnvCEfJOwUhtlOARqs3+rkHYY13jYWTU97c=
github.com/davecgh/go-spew v1.1.1/go.mod h1:J7Y8YcW2NihsgmVo/mv3lAwl/skON4iLHjSsI+c5H38=
github.com/dlclark/regexp2 v1.11.0 h1:G/nrcoOa7ZXlpoa/91N3X7mM3r8eIlMBBJZvsz/mxKI=
github.com/dlclark/regexp2 v1.11.0/go.mod h1:DHkYz0B9wPfa6wondMfaivmHpzrQ3v9q8cnmRbL6yW8=
github.com/dustin/go-humanize v1.0.1 h1:GzkhY7T5VNhEkwH0PVJgjz+fX1rhBrR7pRT3mDkpeCY=
github.com/dustin/go-humanize v1.0.1/go.mod h1:Mu1zIs6XwVuF/gI1OepvI0qD18qycQx+mFykh5fBlto=
github.com/erikgeiser/coninput v0.0.0-20211004153227-1c3628e74d0f h1:Y/CXytFA4m6baUTXGLOoWe4PQhGxaX0KpnayAqC48p4=
github.com/erikgeiser/coninput v0.0.0-20211004153227-1c3628e74d0f/go.mod h1:vw97MGsxSvLiUE2X8qFplwetxpGLQrlU1Q9AUEIzCaM=
github.com/go-logfmt/logfmt v0.6.0 h1:wGYYu3uicYdqXVgoYbvnkrPVXkuLM1p1ifugDMEdRi4=
github.com/go-logfmt/logfmt v0.6.0/go.mod h1:WYhtIu8zTZfxdn5+rREduYbwxfcBr/Vr6KEVveWlfTs=
github.com/gorilla/css v1.0.1 h1:ntNaBIghp6JmvWnxbZKANoLyuXTPZ4cAMlo6RyhlbO8=
github.com/gorilla/css v1.0.1/go.mod h1:BvnYkspnSzMmwRK+b8/xgNPLiIuNZr6vbZBTPQ2A3b0=
github.com/hexops/gotextdiff v1.0.3 h1:gitA9+qJrrTCsiCl7+kh75nPqQt1cx4ZkudSTLoUqJM=
github.com/hexops/gotextdiff v1.0.3/go.mod h1:pSWU5MAI3yDq+fZBTazCSJysOMbxWL1BSow5/V2vxeg=
github.com/kylelemons/godebug v1.1.0 h1:RPNrshWIDI6G2gRW9EHilWtl7Z6Sb1BR0xunSBf0SNc=
github.com/kylelemons/godebug v1.1.0/go.mod h1:9/0rRGxNHcop5bhtWyNeEfOS8JIWk580+fNqagV/RAw=
github.com/lucasb-eyer/go-colorful v1.2.0 h1:1nnpGOrhyZZuNyfu1QjKiUICQ74+3FNCN69Aj6K7nkY=
github.com/lucasb-eyer/go-colorful v1.2.0/go.mod h1:R4dSotOR9KMtayYi1e77YzuveK+i7ruzyGqttikkLy0=
github.com/mattn/go-isatty v0.0.20 h1:xfD0iDuEKnDkl03q4limB+vH+GxLEtL/jb4xVJSWWEY=
github.com/mattn/go-isatty v0.0.20/go.mod h1:W+V8PltTTMOvKvAeJH7IuucS94S2C6jfK/D7dTCTo3Y=
github.com/mattn/go-localereader v0.0.1 h1:ygSAOl7ZXTx4RdPYinUpg6W99U8jWvWi9Ye2JC/oIi4=
github.com/mattn/go-localereader v0.0.1/go.mod h1:8fBrzywKY7BI3czFoHkuzRoWE9C+EiG4R1k4Cjx5p88=
github.com/mattn/go-runewidth v0.0.12/go.mod h1:RAqKPSqVFrSLVXbA8x7dzmKdmGzieGRCM46jaSJTDAk=
github.com/mattn/go-runewidth v0.0.16 h1:E5ScNMtiwvlvB5paMFdw9p4kSQzbXFikJ5SQO6TULQc=
github.com/mattn/go-runewidth v0.0.16/go.mod h1:Jdepj2loyihRzMpdS35Xk/zdY8IAYHsh153qUoGf23w=
github.com/microcosm-cc/bluemonday v1.0.27 h1:MpEUotklkwCSLeH+Qdx1VJgNqLlpY2KXwXFM08ygZfk=
github.com/microcosm-cc/bluemonday v1.0.27/go.mod h1:jFi9vgW+H7c3V0lb6nR74Ib/DIB5OBs92Dimizgw2cA=
github.com/muesli/ansi v0.0.0-20230316100256-276c6243b2f6 h1:ZK8zHtRHOkbHy6Mmr5D264iyp3TiX5OmNcI5cIARiQI=
github.com/muesli/ansi v0.0.0-20230316100256-276c6243b2f6/go.mod h1:CJlz5H+gyd6CUWT45Oy4q24RdLyn7Md9Vj2/ldJBSIo=
github.com/muesli/cancelreader v0.2.2 h1:3I4Kt4BQjOR54NavqnDogx/MIoWBFa0StPA8ELUXHmA=
github.com/muesli/cancelreader v0.2.2/go.mod h1:3XuTXfFS2VjM+HTLZY9Ak0l6eUKfijIfMUZ4EgX0QYo=
github.com/muesli/mango v0.2.0 h1:iNNc0c5VLQ6fsMgAqGQofByNUBH2Q2nEbD6TaI+5yyQ=
github.com/muesli/mango v0.2.0/go.mod h1:5XFpbC8jY5UUv89YQciiXNlbi+iJgt29VDC5xbzrLL4=
github.com/muesli/reflow v0.3.0 h1:IFsN6K9NfGtjeggFP+68I4chLZV2yIKsXJFNZ+eWh6s=
github.com/muesli/reflow v0.3.0/go.mod h1:pbwTDkVPibjO2kyvBQRBxTWEEGDGq0FlB1BIKtnHY/8=
github.com/muesli/roff v0.1.0 h1:YD0lalCotmYuF5HhZliKWlIx7IEhiXeSfq7hNjFqGF8=
github.com/muesli/roff v0.1.0/go.mod h1:pjAHQM9hdUUwm/krAfrLGgJkXJ+YuhtsfZ42kieB2Ig=
github.com/muesli/termenv v0.16.0 h1:S5AlUN9dENB57rsbnkPyfdGuWIlkmzJjbFf0Tf5FWUc=
github.com/muesli/termenv v0.16.0/go.mod h1:ZRfOIKPFDYQoDFF4Olj7/QJbW60Ol/kL1pU3VfY/Cnk=
github.com/pmezard/go-difflib v1.0.0 h1:4DBwDE0NGyQoBHbLQYPwSUPoCMWR5BEzIk/f1lZbAQM=
github.com/pmezard/go-difflib v1.0.0/go.mod h1:iKH77koFhYxTK1pcRnkKkqfTogsbg7gZNVY4sRDYZ/4=
github.com/rivo/uniseg v0.1.0/go.mod h1:J6wj4VEh+S6ZtnVlnTBMWIodfgj8LQOQFoIToxlJtxc=
github.com/rivo/uniseg v0.2.0/go.mod h1:J6wj4VEh+S6ZtnVlnTBMWIodfgj8LQOQFoIToxlJtxc=
github.com/rivo/uniseg v0.4.7 h1:WUdvkW8uEhrYfLC4ZzdpI2ztxP1I582+49Oc5Mq64VQ=
github.com/rivo/uniseg v0.4.7/go.mod h1:FN3SvrM+Zdj16jyLfmOkMNblXMcoc8DfTHruCPUcx88=
github.com/sahilm/fuzzy v0.1.1 h1:ceu5RHF8DGgoi+/dR5PsECjCDH1BE3Fnmpo7aVXOdRA=
github.com/sahilm/fuzzy v0.1.1/go.mod h1:VFvziUEIMCrT6A6tw2RFIXPXXmzXbOsSHF0DOI8ZK9Y=
github.com/stretchr/testify v1.10.0 h1:Xv5erBjTwe/5IxqUQTdXv5kgmIvbHo3QQyRwhJsOfJA=
github.com/stretchr/testify v1.10.0/go.mod h1:r2ic/lqez/lEtzL7wO/rwa5dbSLXVDPFyf8C91i36aY=
github.com/xo/terminfo v0.0.0-20220910002029-abceb7e1c41e h1:JVG44RsyaB9T2KIHavMF/ppJZNG9ZpyihvCd0w101no=
github.com/xo/terminfo v0.0.0-20220910002029-abceb7e1c41e/go.mod h1:RbqR21r5mrJuqunuUZ/Dhy/avygyECGrLceyNeo4LiM=
github.com/yuin/goldmark v1.7.1/go.mod h1:uzxRWxtg69N339t3louHJ7+O03ezfj6PlliRlaOzY1E=
github.com/yuin/goldmark v1.7.8 h1:iERMLn0/QJeHFhxSt3p6PeN9mGnvIKSpG9YYorDMnic=
github.com/yuin/goldmark v1.7.8/go.mod h1:uzxRWxtg69N339t3louHJ7+O03ezfj6PlliRlaOzY1E=
github.com/yuin/goldmark-emoji v1.0.5 h1:EMVWyCGPlXJfUXBXpuMu+ii3TIaxbVBnEX9uaDC4cIk=
github.com/yuin/goldmark-emoji v1.0.5/go.mod h1:tTkZEbwu5wkPmgTcitqddVxY9osFZiavD+r4AzQrh1U=
golang.org/x/exp v0.0.0-20240613232115-7f521ea00fb8 h1:yixxcjnhBmY0nkL253HFVIm0JsFHwrHdT3Yh6szTnfY=
golang.org/x/exp v0.0.0-20240613232115-7f521ea00fb8/go.mod h1:jj3sYF3dwk5D+ghuXyeI3r5MFf+NT2An6/9dOA95KSI=
golang.org/x/net v0.33.0 h1:74SYHlV8BIgHIFC/LrYkOGIwL19eTYXQ5wc6TBuO36I=
golang.org/x/net v0.33.0/go.mod h1:HXLR5J+9DxmrqMwG9qjGCxZ+zKXxBru04zlTvWlWuN4=
golang.org/x/sync v0.12.0 h1:MHc5BpPuC30uJk597Ri8TV3CNZcTLu6B6z4lJy+g6Jw=
golang.org/x/sync v0.12.0/go.mod h1:1dzgHSNfp02xaA81J2MS99Qcpr2w7fw1gpm99rleRqA=
golang.org/x/sys v0.0.0-20210809222454-d867a43fc93e/go.mod h1:oPkhp1MJrh7nUepCBck5+mAzfO9JrbApNNgaTdGDITg=
golang.org/x/sys v0.6.0/go.mod h1:oPkhp1MJrh7nUepCBck5+mAzfO9JrbApNNgaTdGDITg=
golang.org/x/sys v0.31.0 h1:ioabZlmFYtWhL+TRYpcnNlLwhyxaM9kWTDEmfnprqik=
golang.org/x/sys v0.31.0/go.mod h1:BJP2sWEmIv4KK5OTEluFJCKSidICx8ciO85XgH3Ak8k=
golang.org/x/term v0.30.0 h1:PQ39fJZ+mfadBm0y5WlL4vlM7Sx1Hgf13sMIY2+QS9Y=
golang.org/x/term v0.30.0/go.mod h1:NYYFdzHoI5wRh/h5tDMdMqCqPJZEuNqVR5xJLd/n67g=
golang.org/x/text v0.23.0 h1:D71I7dUrlY+VX0gQShAThNGHFxZ13dGLBHQLVl1mJlY=
golang.org/x/text v0.23.0/go.mod h1:/BLNzu4aZCJ1+kcD0DNRotWKage4q2rGVAg4o22unh4=
gopkg.in/yaml.v3 v3.0.1 h1:fxVm/GzAzEWqLHuvctI91KS9hhNmmWOoWu0XTYJS7CA=
gopkg.in/yaml.v3 v3.0.1/go.mod h1:K4uyk7z7BCEPqu6E+C64Yfv1cQ7kz7rIZviUmN+EgEM=

================================================
File: gum.go
================================================
package main

import (
"github.com/alecthomas/kong"

    "github.com/charmbracelet/gum/choose"
    "github.com/charmbracelet/gum/completion"
    "github.com/charmbracelet/gum/confirm"
    "github.com/charmbracelet/gum/file"
    "github.com/charmbracelet/gum/filter"
    "github.com/charmbracelet/gum/format"
    "github.com/charmbracelet/gum/input"
    "github.com/charmbracelet/gum/join"
    "github.com/charmbracelet/gum/log"
    "github.com/charmbracelet/gum/man"
    "github.com/charmbracelet/gum/pager"
    "github.com/charmbracelet/gum/spin"
    "github.com/charmbracelet/gum/style"
    "github.com/charmbracelet/gum/table"
    "github.com/charmbracelet/gum/version"
    "github.com/charmbracelet/gum/write"

)

// Gum is the command-line interface for Gum.
type Gum struct {
// Version is a flag that can be used to display the version number.
Version kong.VersionFlag `short:"v" help:"Print the version number"`

    // Completion generates Gum shell completion scripts.
    Completion completion.Completion `cmd:"" hidden:"" help:"Request shell completion"`

    // Man is a hidden command that generates Gum man pages.
    Man man.Man `cmd:"" hidden:"" help:"Generate man pages"`

    // Choose provides an interface to choose one option from a given list of
    // options. The options can be provided as (new-line separated) stdin or a
    // list of arguments.
    //
    // It is different from the filter command as it does not provide a fuzzy
    // finding input, so it is best used for smaller lists of options.
    //
    // Let's pick from a list of gum flavors:
    //
    // $ gum choose "Strawberry" "Banana" "Cherry"
    //
    Choose choose.Options `cmd:"" help:"Choose an option from a list of choices"`

    // Confirm provides an interface to ask a user to confirm an action.
    // The user is provided with an interface to choose an affirmative or
    // negative answer, which is then reflected in the exit code for use in
    // scripting.
    //
    // If the user selects the affirmative answer, the program exits with 0.
    // If the user selects the negative answer, the program exits with 1.
    //
    // I.e. confirm if the user wants to delete a file
    //
    // $ gum confirm "Are you sure?" && rm file.txt
    //
    Confirm confirm.Options `cmd:"" help:"Ask a user to confirm an action"`

    // File provides an interface to pick a file from a folder (tree).
    // The user is provided a file manager-like interface to navigate, to
    // select a file.
    //
    // Let's pick a file from the current directory:
    //
    // $ gum file
    // $ gum file .
    //
    // Let's pick a file from the home directory:
    //
    // $ gum file $HOME
    File file.Options `cmd:"" help:"Pick a file from a folder"`

    // Filter provides a fuzzy searching text input to allow filtering a list of
    // options to select one option.
    //
    // By default it will list all the files (recursively) in the current directory
    // for the user to choose one, but the script (or user) can provide different
    // new-line separated options to choose from.
    //
    // I.e. let's pick from a list of gum flavors:
    //
    // $ cat flavors.text | gum filter
    //
    Filter filter.Options `cmd:"" help:"Filter items from a list"`

    // Format allows you to render styled text from `markdown`, `code`,
    // `template` strings, or embedded `emoji` strings.
    // For more information see the format/README.md file.
    Format format.Options `cmd:"" help:"Format a string using a template"`

    // Input provides a shell script interface for the text input bubble.
    // https://github.com/charmbracelet/bubbles/tree/master/textinput
    //
    // It can be used to prompt the user for some input. The text the user
    // entered will be sent to stdout.
    //
    // $ gum input --placeholder "What's your favorite gum?" > answer.text
    //
    Input input.Options `cmd:"" help:"Prompt for some input"`

    // Join provides a shell script interface for the lipgloss JoinHorizontal
    // and JoinVertical commands. It allows you to join multi-line text to
    // build different layouts.
    //
    // For example, you can place two bordered boxes next to each other:
    // Note: We wrap the variable in quotes to ensure the new lines are part of a
    // single argument. Otherwise, the command won't work as expected.
    //
    // $ gum join --horizontal "$BUBBLE_BOX" "$GUM_BOX"
    //
    //   ╔══════════════════════╗╔═════════════╗
    //   ║                      ║║             ║
    //   ║        Bubble        ║║     Gum     ║
    //   ║                      ║║             ║
    //   ╚══════════════════════╝╚═════════════╝
    //
    Join join.Options `cmd:"" help:"Join text vertically or horizontally"`

    // Pager provides a shell script interface for the viewport bubble.
    // https://github.com/charmbracelet/bubbles/tree/master/viewport
    //
    // It allows the user to scroll through content like a pager.
    //
    // ╭────────────────────────────────────────────────╮
    // │    1 │ Gum Pager                               │
    // │    2 │ =========                               │
    // │    3 │                                         │
    // │    4 │ ```                                     │
    // │    5 │ gum pager --height 10 --width 25 < text │
    // │    6 │ ```                                     │
    // │    7 │                                         │
    // │    8 │                                         │
    // ╰────────────────────────────────────────────────╯
    //  ↓↑: navigate • q: quit
    //
    Pager pager.Options `cmd:"" help:"Scroll through a file"`

    // Spin provides a shell script interface for the spinner bubble.
    // https://github.com/charmbracelet/bubbles/tree/master/spinner
    //
    // It is useful for displaying that some task is running in the background
    // while consuming it's output so that it is not shown to the user.
    //
    // For example, let's do a long running task: $ sleep 5
    //
    // We can simply prepend a spinner to this task to show it to the user,
    // while performing the task / command in the background.
    //
    // $ gum spin -t "Taking a nap..." -- sleep 5
    //
    // The spinner will automatically exit when the task is complete.
    //
    Spin spin.Options `cmd:"" help:"Display spinner while running a command"`

    // Style provides a shell script interface for Lip Gloss.
    // https://github.com/charmbracelet/lipgloss
    //
    // It allows you to use Lip Gloss to style text without needing to use Go.
    // All of the styling options are available as flags.
    //
    // Let's make some text glamorous using bash:
    //
    // $ gum style \
    //  	--foreground 212 --border double --align center \
    //  	--width 50 --margin 2 --padding "2 4" \
    //  	"Bubble Gum (1¢)" "So sweet and so fresh\!"
    //
    //
    //    ╔══════════════════════════════════════════════════╗
    //    ║                                                  ║
    //    ║                                                  ║
    //    ║                 Bubble Gum (1¢)                  ║
    //    ║              So sweet and so fresh!              ║
    //    ║                                                  ║
    //    ║                                                  ║
    //    ╚══════════════════════════════════════════════════╝
    //
    Style style.Options `cmd:"" help:"Apply coloring, borders, spacing to text"`

    // Table provides a shell script interface for the table bubble.
    // https://github.com/charmbracelet/bubbles/tree/master/table
    //
    // It is useful to render tabular (CSV) data in a terminal and allows
    // the user to select a row from the table.
    //
    // Let's render a table of gum flavors:
    //
    // $ gum table <<< "Flavor,Price\nStrawberry,$0.50\nBanana,$0.99\nCherry,$0.75"
    //
    //  Flavor      Price
    //  Strawberry  $0.50
    //  Banana      $0.99
    //  Cherry      $0.75
    //
    Table table.Options `cmd:"" help:"Render a table of data"`

    // Write provides a shell script interface for the text area bubble.
    // https://github.com/charmbracelet/bubbles/tree/master/textarea
    //
    // It can be used to ask the user to write some long form of text
    // (multi-line) input. The text the user entered will be sent to stdout.
    //
    // $ gum write > output.text
    //
    Write write.Options `cmd:"" help:"Prompt for long-form text"`

    // Log provides a shell script interface for logging using Log.
    // https://github.com/charmbracelet/log
    //
    // It can be used to log messages to output.
    //
    // $ gum log --level info "Hello, world!"
    //
    Log log.Options `cmd:"" help:"Log messages to output"`

    // VersionCheck provides a command that checks if the current gum version
    // matches a given semantic version constraint.
    //
    // It can be used to check that a minimum gum version is installed in a
    // script.
    //
    // $ gum version-check '~> 0.15'
    //
    VersionCheck version.Options `cmd:"" help:"Semver check current gum version"`

}

================================================
File: main.go
================================================
package main

import (
"errors"
"fmt"
"os"
"runtime/debug"

    "github.com/alecthomas/kong"
    tea "github.com/charmbracelet/bubbletea"
    "github.com/charmbracelet/gum/internal/exit"
    "github.com/charmbracelet/lipgloss"
    "github.com/muesli/termenv"

)

const shaLen = 7

var (
// Version contains the application version number. It's set via ldflags
// when building.
Version = ""

    // CommitSHA contains the SHA of the commit that this application was built
    // against. It's set via ldflags when building.
    CommitSHA = ""

)

var bubbleGumPink = lipgloss.NewStyle().Foreground(lipgloss.Color("212"))

func main() {
lipgloss.SetColorProfile(termenv.NewOutput(os.Stderr).Profile)

    if Version == "" {
    	if info, ok := debug.ReadBuildInfo(); ok && info.Main.Sum != "" {
    		Version = info.Main.Version
    	} else {
    		Version = "unknown (built from source)"
    	}
    }
    version := fmt.Sprintf("gum version %s", Version)
    if len(CommitSHA) >= shaLen {
    	version += " (" + CommitSHA[:shaLen] + ")"
    }

    gum := &Gum{}
    ctx := kong.Parse(
    	gum,
    	kong.Description(fmt.Sprintf("A tool for %s shell scripts.", bubbleGumPink.Render("glamorous"))),
    	kong.UsageOnError(),
    	kong.ConfigureHelp(kong.HelpOptions{
    		Compact:             true,
    		Summary:             false,
    		NoExpandSubcommands: true,
    	}),
    	kong.Vars{
    		"version":                 version,
    		"versionNumber":           Version,
    		"defaultHeight":           "0",
    		"defaultWidth":            "0",
    		"defaultAlign":            "left",
    		"defaultBorder":           "none",
    		"defaultBorderForeground": "",
    		"defaultBorderBackground": "",
    		"defaultBackground":       "",
    		"defaultForeground":       "",
    		"defaultMargin":           "0 0",
    		"defaultPadding":          "0 0",
    		"defaultUnderline":        "false",
    		"defaultBold":             "false",
    		"defaultFaint":            "false",
    		"defaultItalic":           "false",
    		"defaultStrikethrough":    "false",
    	},
    )
    if err := ctx.Run(); err != nil {
    	var ex exit.ErrExit
    	if errors.As(err, &ex) {
    		os.Exit(int(ex))
    	}
    	if errors.Is(err, tea.ErrProgramKilled) {
    		fmt.Fprintln(os.Stderr, "timed out")
    		os.Exit(exit.StatusTimeout)
    	}
    	if errors.Is(err, tea.ErrInterrupted) {
    		os.Exit(exit.StatusAborted)
    	}
    	fmt.Fprintln(os.Stderr, err)
    	os.Exit(1)
    }

}

================================================
File: .golangci-soft.yml
================================================
run:
tests: false

issues:
include: - EXC0001 - EXC0005 - EXC0011 - EXC0012 - EXC0013

max-issues-per-linter: 0
max-same-issues: 0

linters:
enable: - exhaustive - goconst - godot - godox - mnd - gomoddirectives - goprintffuncname - misspell - nakedret - nestif - noctx - nolintlint - prealloc

# disable default linters, they are already enabled in .golangci.yml

disable: - wrapcheck - errcheck - gosimple - govet - ineffassign - staticcheck - typecheck

================================================
File: .golangci.yml
================================================
run:
tests: false

issues:
include: - EXC0001 - EXC0005 - EXC0011 - EXC0012 - EXC0013

max-issues-per-linter: 0
max-same-issues: 0

linters:
enable: - bodyclose - goimports - gosec - nilerr - predeclared - revive - rowserrcheck - sqlclosecheck - tparallel - unconvert - unparam - whitespace

================================================
File: .goreleaser.yml
================================================

# yaml-language-server: $schema=https://goreleaser.com/static/schema-pro.json

version: 2

includes:

- from_url:
  url: charmbracelet/meta/main/goreleaser-full.yaml

variables:
main: "."
scoop_name: charm-gum
description: "A tool for glamorous shell scripts"
github_url: "https://github.com/charmbracelet/gum"
maintainer: "Maas Lalani <maas@charm.sh>"
brew_commit_author_name: "Maas Lalani"
brew_commit_author_email: "maas@charm.sh"

milestones:

- close: true

================================================
File: choose/choose.go
================================================
// Package choose provides an interface to choose one option from a given list
// of options. The options can be provided as (new-line separated) stdin or a
// list of arguments.
//
// It is different from the filter command as it does not provide a fuzzy
// finding input, so it is best used for smaller lists of options.
//
// Let's pick from a list of gum flavors:
//
// $ gum choose "Strawberry" "Banana" "Cherry"
package choose

import (
"strings"

    "github.com/charmbracelet/bubbles/help"
    "github.com/charmbracelet/bubbles/key"
    "github.com/charmbracelet/bubbles/paginator"
    tea "github.com/charmbracelet/bubbletea"
    "github.com/charmbracelet/lipgloss"

)

func defaultKeymap() keymap {
return keymap{
Down: key.NewBinding(
key.WithKeys("down", "j", "ctrl+j", "ctrl+n"),
),
Up: key.NewBinding(
key.WithKeys("up", "k", "ctrl+k", "ctrl+p"),
),
Right: key.NewBinding(
key.WithKeys("right", "l", "ctrl+f"),
),
Left: key.NewBinding(
key.WithKeys("left", "h", "ctrl+b"),
),
Home: key.NewBinding(
key.WithKeys("g", "home"),
),
End: key.NewBinding(
key.WithKeys("G", "end"),
),
ToggleAll: key.NewBinding(
key.WithKeys("a", "A", "ctrl+a"),
key.WithHelp("ctrl+a", "select all"),
key.WithDisabled(),
),
Toggle: key.NewBinding(
key.WithKeys(" ", "tab", "x", "ctrl+@"),
key.WithHelp("x", "toggle"),
key.WithDisabled(),
),
Abort: key.NewBinding(
key.WithKeys("ctrl+c"),
key.WithHelp("ctrl+c", "abort"),
),
Quit: key.NewBinding(
key.WithKeys("esc"),
key.WithHelp("esc", "quit"),
),
Submit: key.NewBinding(
key.WithKeys("enter", "ctrl+q"),
key.WithHelp("enter", "submit"),
),
}
}

type keymap struct {
Down,
Up,
Right,
Left,
Home,
End,
ToggleAll,
Toggle,
Abort,
Quit,
Submit key.Binding
}

// FullHelp implements help.KeyMap.
func (k keymap) FullHelp() [][]key.Binding { return nil }

// ShortHelp implements help.KeyMap.
func (k keymap) ShortHelp() []key.Binding {
return []key.Binding{
k.Toggle,
key.NewBinding(
key.WithKeys("up", "down", "right", "left"),
key.WithHelp("←↓↑→", "navigate"),
),
k.Submit,
k.ToggleAll,
}
}

type model struct {
height int
cursor string
selectedPrefix string
unselectedPrefix string
cursorPrefix string
header string
items []item
quitting bool
submitted bool
index int
limit int
numSelected int
currentOrder int
paginator paginator.Model
showHelp bool
help help.Model
keymap keymap

    // styles
    cursorStyle       lipgloss.Style
    headerStyle       lipgloss.Style
    itemStyle         lipgloss.Style
    selectedItemStyle lipgloss.Style

}

type item struct {
text string
selected bool
order int
}

func (m model) Init() tea.Cmd { return nil }

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
switch msg := msg.(type) {
case tea.WindowSizeMsg:
return m, nil

    case tea.KeyMsg:
    	start, end := m.paginator.GetSliceBounds(len(m.items))
    	km := m.keymap
    	switch {
    	case key.Matches(msg, km.Down):
    		m.index++
    		if m.index >= len(m.items) {
    			m.index = 0
    			m.paginator.Page = 0
    		}
    		if m.index >= end {
    			m.paginator.NextPage()
    		}
    	case key.Matches(msg, km.Up):
    		m.index--
    		if m.index < 0 {
    			m.index = len(m.items) - 1
    			m.paginator.Page = m.paginator.TotalPages - 1
    		}
    		if m.index < start {
    			m.paginator.PrevPage()
    		}
    	case key.Matches(msg, km.Right):
    		m.index = clamp(m.index+m.height, 0, len(m.items)-1)
    		m.paginator.NextPage()
    	case key.Matches(msg, km.Left):
    		m.index = clamp(m.index-m.height, 0, len(m.items)-1)
    		m.paginator.PrevPage()
    	case key.Matches(msg, km.End):
    		m.index = len(m.items) - 1
    		m.paginator.Page = m.paginator.TotalPages - 1
    	case key.Matches(msg, km.Home):
    		m.index = 0
    		m.paginator.Page = 0
    	case key.Matches(msg, km.ToggleAll):
    		if m.limit <= 1 {
    			break
    		}
    		if m.numSelected < len(m.items) && m.numSelected < m.limit {
    			m = m.selectAll()
    		} else {
    			m = m.deselectAll()
    		}
    	case key.Matches(msg, km.Quit):
    		m.quitting = true
    		return m, tea.Quit
    	case key.Matches(msg, km.Abort):
    		m.quitting = true
    		return m, tea.Interrupt
    	case key.Matches(msg, km.Toggle):
    		if m.limit == 1 {
    			break // no op
    		}

    		if m.items[m.index].selected {
    			m.items[m.index].selected = false
    			m.numSelected--
    		} else if m.numSelected < m.limit {
    			m.items[m.index].selected = true
    			m.items[m.index].order = m.currentOrder
    			m.numSelected++
    			m.currentOrder++
    		}
    	case key.Matches(msg, km.Submit):
    		m.quitting = true
    		if m.limit <= 1 && m.numSelected < 1 {
    			m.items[m.index].selected = true
    		}
    		m.submitted = true
    		return m, tea.Quit
    	}
    }

    var cmd tea.Cmd
    m.paginator, cmd = m.paginator.Update(msg)
    return m, cmd

}

func (m model) selectAll() model {
for i := range m.items {
if m.numSelected >= m.limit {
break // do not exceed given limit
}
if m.items[i].selected {
continue
}
m.items[i].selected = true
m.items[i].order = m.currentOrder
m.numSelected++
m.currentOrder++
}
return m
}

func (m model) deselectAll() model {
for i := range m.items {
m.items[i].selected = false
m.items[i].order = 0
}
m.numSelected = 0
m.currentOrder = 0
return m
}

func (m model) View() string {
if m.quitting {
return ""
}

    var s strings.Builder

    start, end := m.paginator.GetSliceBounds(len(m.items))
    for i, item := range m.items[start:end] {
    	if i == m.index%m.height {
    		s.WriteString(m.cursorStyle.Render(m.cursor))
    	} else {
    		s.WriteString(strings.Repeat(" ", lipgloss.Width(m.cursor)))
    	}

    	if item.selected {
    		s.WriteString(m.selectedItemStyle.Render(m.selectedPrefix + item.text))
    	} else if i == m.index%m.height {
    		s.WriteString(m.cursorStyle.Render(m.cursorPrefix + item.text))
    	} else {
    		s.WriteString(m.itemStyle.Render(m.unselectedPrefix + item.text))
    	}
    	if i != m.height {
    		s.WriteRune('\n')
    	}
    }

    if m.paginator.TotalPages > 1 {
    	s.WriteString(strings.Repeat("\n", m.height-m.paginator.ItemsOnPage(len(m.items))+1))
    	s.WriteString("  " + m.paginator.View())
    }

    var parts []string

    if m.header != "" {
    	parts = append(parts, m.headerStyle.Render(m.header))
    }
    parts = append(parts, s.String())
    if m.showHelp {
    	parts = append(parts, "", m.help.View(m.keymap))
    }

    return lipgloss.JoinVertical(lipgloss.Left, parts...)

}

func clamp(x, low, high int) int {
if x < low {
return low
}
if x > high {
return high
}
return x
}

================================================
File: choose/command.go
================================================
package choose

import (
"errors"
"fmt"
"os"
"slices"
"sort"
"strings"

    "github.com/charmbracelet/bubbles/help"
    "github.com/charmbracelet/bubbles/paginator"
    tea "github.com/charmbracelet/bubbletea"
    "github.com/charmbracelet/gum/internal/stdin"
    "github.com/charmbracelet/gum/internal/timeout"
    "github.com/charmbracelet/gum/internal/tty"
    "github.com/charmbracelet/lipgloss"

)

// Run provides a shell script interface for choosing between different through
// options.
func (o Options) Run() error {
var (
subduedStyle = lipgloss.NewStyle().Foreground(lipgloss.AdaptiveColor{Light: "#847A85", Dark: "#979797"})
verySubduedStyle = lipgloss.NewStyle().Foreground(lipgloss.AdaptiveColor{Light: "#DDDADA", Dark: "#3C3C3C"})
)

    input, _ := stdin.Read(stdin.StripANSI(o.StripANSI))
    if len(o.Options) > 0 && len(o.Selected) == 0 {
    	o.Selected = strings.Split(input, o.InputDelimiter)
    } else if len(o.Options) == 0 {
    	if input == "" {
    		return errors.New("no options provided, see `gum choose --help`")
    	}
    	o.Options = strings.Split(input, o.InputDelimiter)
    }

    // normalize options into a map
    options := map[string]string{}
    // keep the labels in the user-provided order
    var labels []string
    for _, opt := range o.Options {
    	if o.LabelDelimiter == "" {
    		options[opt] = opt
    		continue
    	}
    	label, value, ok := strings.Cut(opt, o.LabelDelimiter)
    	if !ok {
    		return fmt.Errorf("invalid option format: %q", opt)
    	}
    	labels = append(labels, label)
    	options[label] = value
    }
    if o.LabelDelimiter != "" {
    	o.Options = labels
    }

    if o.SelectIfOne && len(o.Options) == 1 {
    	fmt.Println(options[o.Options[0]])
    	return nil
    }

    // We don't need to display prefixes if we are only picking one option.
    // Simply displaying the cursor is enough.
    if o.Limit == 1 && !o.NoLimit {
    	o.SelectedPrefix = ""
    	o.UnselectedPrefix = ""
    	o.CursorPrefix = ""
    }

    if o.NoLimit {
    	o.Limit = len(o.Options) + 1
    }

    if o.Ordered {
    	slices.SortFunc(o.Options, strings.Compare)
    }

    isSelectAll := len(o.Selected) == 1 && o.Selected[0] == "*"

    // Keep track of the selected items.
    currentSelected := 0
    // Check if selected items should be used.
    hasSelectedItems := len(o.Selected) > 0
    startingIndex := 0
    currentOrder := 0
    items := make([]item, len(o.Options))
    for i, option := range o.Options {
    	var order int
    	// Check if the option should be selected.
    	isSelected := hasSelectedItems && currentSelected < o.Limit && (isSelectAll || slices.Contains(o.Selected, option))
    	// If the option is selected then increment the current selected count.
    	if isSelected {
    		if o.Limit == 1 {
    			// When the user can choose only one option don't select the option but
    			// start with the cursor hovering over it.
    			startingIndex = i
    			isSelected = false
    		} else {
    			currentSelected++
    			order = currentOrder
    			currentOrder++
    		}
    	}
    	items[i] = item{text: option, selected: isSelected, order: order}
    }

    // Use the pagination model to display the current and total number of
    // pages.
    pager := paginator.New()
    pager.SetTotalPages((len(items) + o.Height - 1) / o.Height)
    pager.PerPage = o.Height
    pager.Type = paginator.Dots
    pager.ActiveDot = subduedStyle.Render("•")
    pager.InactiveDot = verySubduedStyle.Render("•")
    pager.KeyMap = paginator.KeyMap{}
    pager.Page = startingIndex / o.Height

    km := defaultKeymap()
    if o.NoLimit || o.Limit > 1 {
    	km.Toggle.SetEnabled(true)
    }
    if o.NoLimit {
    	km.ToggleAll.SetEnabled(true)
    }

    m := model{
    	index:             startingIndex,
    	currentOrder:      currentOrder,
    	height:            o.Height,
    	cursor:            o.Cursor,
    	header:            o.Header,
    	selectedPrefix:    o.SelectedPrefix,
    	unselectedPrefix:  o.UnselectedPrefix,
    	cursorPrefix:      o.CursorPrefix,
    	items:             items,
    	limit:             o.Limit,
    	paginator:         pager,
    	cursorStyle:       o.CursorStyle.ToLipgloss(),
    	headerStyle:       o.HeaderStyle.ToLipgloss(),
    	itemStyle:         o.ItemStyle.ToLipgloss(),
    	selectedItemStyle: o.SelectedItemStyle.ToLipgloss(),
    	numSelected:       currentSelected,
    	showHelp:          o.ShowHelp,
    	help:              help.New(),
    	keymap:            km,
    }

    ctx, cancel := timeout.Context(o.Timeout)
    defer cancel()

    // Disable Keybindings since we will control it ourselves.
    tm, err := tea.NewProgram(
    	m,
    	tea.WithOutput(os.Stderr),
    	tea.WithContext(ctx),
    ).Run()
    if err != nil {
    	return fmt.Errorf("unable to pick selection: %w", err)
    }
    m = tm.(model)
    if !m.submitted {
    	return errors.New("nothing selected")
    }
    if o.Ordered && o.Limit > 1 {
    	sort.Slice(m.items, func(i, j int) bool {
    		return m.items[i].order < m.items[j].order
    	})
    }

    var out []string
    for _, item := range m.items {
    	if item.selected {
    		out = append(out, options[item.text])
    	}
    }
    tty.Println(strings.Join(out, o.OutputDelimiter))
    return nil

}

================================================
File: choose/options.go
================================================
package choose

import (
"time"

    "github.com/charmbracelet/gum/style"

)

// Options is the customization options for the choose command.
type Options struct {
Options []string `arg:"" optional:"" help:"Options to choose from."`
Limit int `help:"Maximum number of options to pick" default:"1" group:"Selection"`
NoLimit bool `help:"Pick unlimited number of options (ignores limit)" group:"Selection"`
Ordered bool `help:"Maintain the order of the selected options" env:"GUM_CHOOSE_ORDERED"`
Height int `help:"Height of the list" default:"10" env:"GUM_CHOOSE_HEIGHT"`
Cursor string `help:"Prefix to show on item that corresponds to the cursor position" default:"> " env:"GUM_CHOOSE_CURSOR"`
ShowHelp bool `help:"Show help keybinds" default:"true" negatable:"" env:"GUM_CHOOSE_SHOW_HELP"`
Timeout time.Duration `help:"Timeout until choose returns selected element" default:"0s" env:"GUM_CCHOOSE_TIMEOUT"` // including timeout command options [Timeout,...]
Header string `help:"Header value" default:"Choose:" env:"GUM_CHOOSE_HEADER"`
CursorPrefix string `help:"Prefix to show on the cursor item (hidden if limit is 1)" default:"• " env:"GUM_CHOOSE_CURSOR_PREFIX"`
SelectedPrefix string `help:"Prefix to show on selected items (hidden if limit is 1)" default:"✓ " env:"GUM_CHOOSE_SELECTED_PREFIX"`
UnselectedPrefix string `help:"Prefix to show on unselected items (hidden if limit is 1)" default:"• " env:"GUM_CHOOSE_UNSELECTED_PREFIX"`
Selected []string `help:"Options that should start as selected (selects all if given *)" default:"" env:"GUM_CHOOSE_SELECTED"`
SelectIfOne bool `help:"Select the given option if there is only one" group:"Selection"`
InputDelimiter string `help:"Option delimiter when reading from STDIN" default:"\n" env:"GUM_CHOOSE_INPUT_DELIMITER"`
OutputDelimiter string `help:"Option delimiter when writing to STDOUT" default:"\n" env:"GUM_CHOOSE_OUTPUT_DELIMITER"`
LabelDelimiter string `help:"Allows to set a delimiter, so options can be set as label:value" default:"" env:"GUM_CHOOSE_LABEL_DELIMITER"`
StripANSI bool `help:"Strip ANSI sequences when reading from STDIN" default:"true" negatable:"" env:"GUM_CHOOSE_STRIP_ANSI"`

    CursorStyle       style.Styles `embed:"" prefix:"cursor." set:"defaultForeground=212" envprefix:"GUM_CHOOSE_CURSOR_"`
    HeaderStyle       style.Styles `embed:"" prefix:"header." set:"defaultForeground=99" envprefix:"GUM_CHOOSE_HEADER_"`
    ItemStyle         style.Styles `embed:"" prefix:"item." hidden:"" envprefix:"GUM_CHOOSE_ITEM_"`
    SelectedItemStyle style.Styles `embed:"" prefix:"selected." set:"defaultForeground=212" envprefix:"GUM_CHOOSE_SELECTED_"`

}

================================================
File: completion/bash.go
================================================
package completion

import (
"bytes"
"fmt"
"io"
"sort"
"strings"

    "github.com/alecthomas/kong"

)

// Bash is a bash completion generator.
type Bash struct{}

// Run generates bash completion script.
func (b Bash) Run(ctx \*kong.Context) error {
buf := new(bytes.Buffer)
writePreamble(buf, ctx.Model.Name)
b.gen(buf, ctx.Model.Node)
writePostscript(buf, ctx.Model.Name)

    _, err := fmt.Fprint(ctx.Stdout, buf.String())
    if err != nil {
    	return fmt.Errorf("unable to generate bash completion: %v", err)
    }
    return nil

}

// ShellCompDirective is a bit map representing the different behaviors the shell
// can be instructed to have once completions have been provided.
type ShellCompDirective int

const (
// ShellCompDirectiveError indicates an error occurred and completions should be ignored.
ShellCompDirectiveError ShellCompDirective = 1 << iota

    // ShellCompDirectiveNoSpace indicates that the shell should not add a space
    // after the completion even if there is a single completion provided.
    ShellCompDirectiveNoSpace

    // ShellCompDirectiveNoFileComp indicates that the shell should not provide
    // file completion even when no completion is provided.
    ShellCompDirectiveNoFileComp

    // ShellCompDirectiveFilterFileExt indicates that the provided completions
    // should be used as file extension filters.
    // For flags, using Command.MarkFlagFilename() and Command.MarkPersistentFlagFilename()
    // is a shortcut to using this directive explicitly.  The BashCompFilenameExt
    // annotation can also be used to obtain the same behavior for flags.
    ShellCompDirectiveFilterFileExt

    // ShellCompDirectiveFilterDirs indicates that only directory names should
    // be provided in file completion.  To request directory names within another
    // directory, the returned completions should specify the directory within
    // which to search.  The BashCompSubdirsInDir annotation can be used to
    // obtain the same behavior but only for flags.
    ShellCompDirectiveFilterDirs

    // ===========================================================================
    //
    // All directives using iota should be above this one.
    // For internal use.
    shellCompDirectiveMaxValue //nolint:deadcode,unused,varcheck

    // ShellCompDirectiveDefault indicates to let the shell perform its default
    // behavior after completions have been provided.
    // This one must be last to avoid messing up the iota count.
    ShellCompDirectiveDefault ShellCompDirective = 0

)

// Annotations for Bash completion.
const (
// ShellCompNoDescRequestCmd is the name of the hidden command that is used to request
// completion results without their description. It is used by the shell completion scripts.
ShellCompNoDescRequestCmd = "completion completeNoDesc"
BashCompFilenameExt = "kong_annotation_bash_completion_filename_extensions"
BashCompCustom = "kong_annotation_bash_completion_custom"
BashCompOneRequiredFlag = "kong_annotation_bash_completion_one_required_flag"
BashCompSubdirsInDir = "kong_annotation_bash_completion_subdirs_in_dir"

    activeHelpEnvVarSuffix = "_ACTIVE_HELP"

)

// activeHelpEnvVar returns the name of the program-specific ActiveHelp environment
// variable. It has the format <PROGRAM>_ACTIVE_HELP where <PROGRAM> is the name of the
// root command in upper case, with all - replaced by _.
func activeHelpEnvVar(name string) string {
// This format should not be changed: users will be using it explicitly.
activeHelpEnvVar := strings.ToUpper(fmt.Sprintf("%s%s", name, activeHelpEnvVarSuffix))
return strings.ReplaceAll(activeHelpEnvVar, "-", "\_")
}

func writePreamble(buf io.StringWriter, name string) {
writeString(buf, fmt.Sprintf("# bash completion for %-36s -_- shell-script -_-\n", name))
writeString(buf, fmt.Sprintf(`
\_\_%[1]s_debug()
{
if [[-n ${BASH_COMP_DEBUG_FILE:-}]]; then
echo "$*" >> "${BASH_COMP_DEBUG_FILE}"
fi
}

# Homebrew on Macs have version 1.3 of bash-completion which doesn't include

# \_init_completion. This is a very minimal version of that function.

\_\_%[1]s_init_completion()
{
COMPREPLY=()
\_get_comp_words_by_ref "$@" cur prev words cword
}

\_\_%[1]s_index_of_word()
{
local w word=$1
    shift
    index=0
    for w in "$@"; do
[[$w = "$word"]] && return
index=$((index+1))
done
index=-1
}

\_\_%[1]s_contains_word()
{
local w word=$1; shift
    for w in "$@"; do
[[$w = "$word"]] && return
done
return 1
}

**%[1]s_handle_go_custom_completion()
{
**%[1]s_debug "${FUNCNAME[0]}: cur is ${cur}, words[*] is ${words[*]}, #words[@] is ${#words[@]}"

    local shellCompDirectiveError=%[3]d
    local shellCompDirectiveNoSpace=%[4]d
    local shellCompDirectiveNoFileComp=%[5]d
    local shellCompDirectiveFilterFileExt=%[6]d
    local shellCompDirectiveFilterDirs=%[7]d

    local out requestComp lastParam lastChar comp directive args

    # Prepare the command to request completions for the program.
    # Calling ${words[0]} instead of directly %[1]s allows to handle aliases
    args=("${words[@]:1}")
    # Disable ActiveHelp which is not supported for bash completion v1
    requestComp="%[8]s=0 ${words[0]} %[2]s ${args[*]}"

    lastParam=${words[$((${#words[@]}-1))]}
    lastChar=${lastParam:$((${#lastParam}-1)):1}
    __%[1]s_debug "${FUNCNAME[0]}: lastParam ${lastParam}, lastChar ${lastChar}"

    if [ -z "${cur}" ] && [ "${lastChar}" != "=" ]; then
        # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go method.
        __%[1]s_debug "${FUNCNAME[0]}: Adding extra empty parameter"
        requestComp="${requestComp} \"\""
    fi

    __%[1]s_debug "${FUNCNAME[0]}: calling ${requestComp}"
    # Use eval to handle any environment variables and such
    out=$(eval "${requestComp}" 2>/dev/null)

    # Extract the directive integer at the very end of the output following a colon (:)
    directive=${out##*:}
    # Remove the directive
    out=${out%%:*}
    if [ "${directive}" = "${out}" ]; then
        # There is not directive specified
        directive=0
    fi
    __%[1]s_debug "${FUNCNAME[0]}: the completion directive is: ${directive}"
    __%[1]s_debug "${FUNCNAME[0]}: the completions are: ${out}"

    if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
        # Error code.  No completion.
        __%[1]s_debug "${FUNCNAME[0]}: received error from custom completion go code"
        return
    else
        if [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ]; then
            if [[ $(type -t compopt) = "builtin" ]]; then
                __%[1]s_debug "${FUNCNAME[0]}: activating no space"
                compopt -o nospace
            fi
        fi
        if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
            if [[ $(type -t compopt) = "builtin" ]]; then
                __%[1]s_debug "${FUNCNAME[0]}: activating no file completion"
                compopt +o default
            fi
        fi
    fi

    if [ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]; then
        # File extension filtering
        local fullFilter filter filteringCmd
        # Do not use quotes around the $out variable or else newline
        # characters will be kept.
        for filter in ${out}; do
            fullFilter+="$filter|"
        done

        filteringCmd="_filedir $fullFilter"
        __%[1]s_debug "File filtering command: $filteringCmd"
        $filteringCmd
    elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
        # File completion for directories only
        local subdir
        # Use printf to strip any trailing newline
        subdir=$(printf "%%s" "${out}")
        if [ -n "$subdir" ]; then
            __%[1]s_debug "Listing directories in $subdir"
            __%[1]s_handle_subdirs_in_dir_flag "$subdir"
        else
            __%[1]s_debug "Listing directories in ."
            _filedir -d
        fi
    else
        while IFS='' read -r comp; do
            COMPREPLY+=("$comp")
        done < <(compgen -W "${out}" -- "$cur")
    fi

}

**%[1]s_handle_reply()
{
**%[1]s_debug "${FUNCNAME[0]}"
    local comp
    case $cur in
        -*)
            if [[ $(type -t compopt) = "builtin" ]]; then
                compopt -o nospace
            fi
            local allflags
            if [ ${#must_have_one_flag[@]} -ne 0 ]; then
                allflags=("${must_have_one_flag[@]}")
else
allflags=("${flags[*]} ${two_word_flags[*]}")
            fi
            while IFS='' read -r comp; do
                COMPREPLY+=("$comp")
done < <(compgen -W "${allflags[*]}" -- "$cur")
if [[$(type -t compopt) = "builtin"]]; then
[["${COMPREPLY[0]}" == *=]] || compopt +o nospace
fi

            # complete after --flag=abc
            if [[ $cur == *=* ]]; then
                if [[ $(type -t compopt) = "builtin" ]]; then
                    compopt +o nospace
                fi

                local index flag
                flag="${cur%%=*}"
                __%[1]s_index_of_word "${flag}" "${flags_with_completion[@]}"
                COMPREPLY=()
                if [[ ${index} -ge 0 ]]; then
                    PREFIX=""
                    cur="${cur#*=}"
                    ${flags_completion[${index}]}
                    if [ -n "${ZSH_VERSION:-}" ]; then
                        # zsh completion needs --flag= prefix
                        eval "COMPREPLY=( \"\${COMPREPLY[@]/#/${flag}=}\" )"
                    fi
                fi
            fi

            if [[ -z "${flag_parsing_disabled}" ]]; then
                # If flag parsing is enabled, we have completed the flags and can return.
                # If flag parsing is disabled, we may not know all (or any) of the flags, so we fallthrough
                # to possibly call handle_go_custom_completion.
                return 0;
            fi
            ;;
    esac

    # check if we are handling a flag with special work handling
    local index
    __%[1]s_index_of_word "${prev}" "${flags_with_completion[@]}"
    if [[ ${index} -ge 0 ]]; then
        ${flags_completion[${index}]}
        return
    fi

    # we are parsing a flag and don't have a special handler, no completion
    if [[ ${cur} != "${words[cword]}" ]]; then
        return
    fi

    local completions
    completions=("${commands[@]}")
    if [[ ${#must_have_one_noun[@]} -ne 0 ]]; then
        completions+=("${must_have_one_noun[@]}")
    elif [[ -n "${has_completion_function}" ]]; then
        # if a go completion function is provided, defer to that function
        __%[1]s_handle_go_custom_completion
    fi
    if [[ ${#must_have_one_flag[@]} -ne 0 ]]; then
        completions+=("${must_have_one_flag[@]}")
    fi
    while IFS='' read -r comp; do
        COMPREPLY+=("$comp")
    done < <(compgen -W "${completions[*]}" -- "$cur")

    if [[ ${#COMPREPLY[@]} -eq 0 && ${#noun_aliases[@]} -gt 0 && ${#must_have_one_noun[@]} -ne 0 ]]; then
        while IFS='' read -r comp; do
            COMPREPLY+=("$comp")
        done < <(compgen -W "${noun_aliases[*]}" -- "$cur")
    fi

    if [[ ${#COMPREPLY[@]} -eq 0 ]]; then
        if declare -F __%[1]s_custom_func >/dev/null; then
            # try command name qualified custom func
            __%[1]s_custom_func
        else
            # otherwise fall back to unqualified for compatibility
            declare -F __custom_func >/dev/null && __custom_func
        fi
    fi

    # available in bash-completion >= 2, not always present on macOS
    if declare -F __ltrim_colon_completions >/dev/null; then
        __ltrim_colon_completions "$cur"
    fi

    # If there is only 1 completion and it is a flag with an = it will be completed
    # but we don't want a space after the =
    if [[ "${#COMPREPLY[@]}" -eq "1" ]] && [[ $(type -t compopt) = "builtin" ]] && [[ "${COMPREPLY[0]}" == --*= ]]; then
       compopt -o nospace
    fi

}

# The arguments should be in the form "ext1|ext2|extn"

\_\_%[1]s_handle_filename_extension_flag()
{
local ext="$1"
    _filedir "@(${ext})"
}

\_\_%[1]s_handle_subdirs_in_dir_flag()
{
local dir="$1"
    pushd "${dir}" >/dev/null 2>&1 && \_filedir -d && popd >/dev/null 2>&1 || return
}

**%[1]s_handle_flag()
{
**%[1]s_debug "${FUNCNAME[0]}: c is $c words[c] is ${words[c]}"

    # if a command required a flag, and we found it, unset must_have_one_flag()
    local flagname=${words[c]}
    local flagvalue=""
    # if the word contained an =
    if [[ ${words[c]} == *"="* ]]; then
        flagvalue=${flagname#*=} # take in as flagvalue after the =
        flagname=${flagname%%=*} # strip everything after the =
        flagname="${flagname}=" # but put the = back
    fi
    __%[1]s_debug "${FUNCNAME[0]}: looking for ${flagname}"
    if __%[1]s_contains_word "${flagname}" "${must_have_one_flag[@]}"; then
        must_have_one_flag=()
    fi

    # if you set a flag which only applies to this command, don't show subcommands
    if __%[1]s_contains_word "${flagname}" "${local_nonpersistent_flags[@]}"; then
      commands=()
    fi

    # keep flag value with flagname as flaghash
    # flaghash variable is an associative array which is only supported in bash > 3.
    if [[ -z "${BASH_VERSION:-}" || "${BASH_VERSINFO[0]:-}" -gt 3 ]]; then
        if [ -n "${flagvalue}" ] ; then
            flaghash[${flagname}]=${flagvalue}
        elif [ -n "${words[ $((c+1)) ]}" ] ; then
            flaghash[${flagname}]=${words[ $((c+1)) ]}
        else
            flaghash[${flagname}]="true" # pad "true" for bool flag
        fi
    fi

    # skip the argument to a two word flag
    if [[ ${words[c]} != *"="* ]] && __%[1]s_contains_word "${words[c]}" "${two_word_flags[@]}"; then
        __%[1]s_debug "${FUNCNAME[0]}: found a flag ${words[c]}, skip the next argument"
        c=$((c+1))
        # if we are looking for a flags value, don't show commands
        if [[ $c -eq $cword ]]; then
            commands=()
        fi
    fi

    c=$((c+1))

}

**%[1]s_handle_noun()
{
**%[1]s_debug "${FUNCNAME[0]}: c is $c words[c] is ${words[c]}"

    if __%[1]s_contains_word "${words[c]}" "${must_have_one_noun[@]}"; then
        must_have_one_noun=()
    elif __%[1]s_contains_word "${words[c]}" "${noun_aliases[@]}"; then
        must_have_one_noun=()
    fi

    nouns+=("${words[c]}")
    c=$((c+1))

}

**%[1]s_handle_command()
{
**%[1]s_debug "${FUNCNAME[0]}: c is $c words[c] is ${words[c]}"

    local next_command
    if [[ -n ${last_command} ]]; then
        next_command="_${last_command}_${words[c]//:/__}"
    else
        if [[ $c -eq 0 ]]; then
            next_command="_%[1]s_root_command"
        else
            next_command="_${words[c]//:/__}"
        fi
    fi
    c=$((c+1))
    __%[1]s_debug "${FUNCNAME[0]}: looking for ${next_command}"
    declare -F "$next_command" >/dev/null && $next_command

}

**%[1]s_handle_word()
{
if [[$c -ge $cword]]; then
**%[1]s_handle_reply
return
fi
**%[1]s_debug "${FUNCNAME[0]}: c is $c words[c] is ${words[c]}"
    if [[ "${words[c]}" == -\* ]]; then
**%[1]s_handle_flag
elif **%[1]s_contains_word "${words[c]}" "${commands[@]}"; then
**%[1]s_handle_command
elif [[$c -eq 0]]; then
**%[1]s_handle_command
elif **%[1]s_contains_word "${words[c]}" "${command_aliases[@]}"; then # aliashash variable is an associative array which is only supported in bash > 3.
if [[-z "${BASH_VERSION:-}" || "${BASH_VERSINFO[0]:-}" -gt 3]]; then
words[c]=${aliashash[${words[c]}]}
**%[1]s_handle_command
else
**%[1]s_handle_noun
fi
else
**%[1]s_handle_noun
fi
**%[1]s_handle_word
}

`, name, ShellCompNoDescRequestCmd,
ShellCompDirectiveError, ShellCompDirectiveNoSpace, ShellCompDirectiveNoFileComp,
ShellCompDirectiveFilterFileExt, ShellCompDirectiveFilterDirs, activeHelpEnvVar(name)))
}

func writePostscript(buf io.StringWriter, name string) {
name = strings.ReplaceAll(name, ":", "**")
writeString(buf, fmt.Sprintf("**start\_%s()\n", name))
writeString(buf, fmt.Sprintf(`{
local cur prev words cword split
declare -A flaghash 2>/dev/null || :
declare -A aliashash 2>/dev/null || :
if declare -F \_init_completion >/dev/null 2>&1; then
\_init_completion -s || return
else
\_\_%[1]s_init_completion -n "=" || return
fi

    local c=0
    local flag_parsing_disabled=
    local flags=()
    local two_word_flags=()
    local local_nonpersistent_flags=()
    local flags_with_completion=()
    local flags_completion=()
    local commands=("%[1]s")
    local command_aliases=()
    local must_have_one_flag=()
    local must_have_one_noun=()
    local has_completion_function=""
    local last_command=""
    local nouns=()
    local noun_aliases=()

    __%[1]s_handle_word

}

`, name))
	writeString(buf, fmt.Sprintf(`if [[$(type -t compopt) = "builtin"]]; then
complete -o default -F **start\_%s %s
else
complete -o default -o nospace -F **start\_%s %s
fi

`, name, name, name, name))
writeString(buf, "# ex: ts=4 sw=4 et filetype=sh\n")
}

func writeCommands(buf io.StringWriter, cmd \*kong.Node) {
writeString(buf, " commands=()\n")
for \_, c := range cmd.Children {
if c == nil || c.Hidden {
continue
}
writeString(buf, fmt.Sprintf(" commands+=(%q)\n", c.Name))
writeCmdAliases(buf, c)
}
writeString(buf, "\n")
}

func writeFlagHandler(buf io.StringWriter, name string, annotations map[string][]string, cmd \*kong.Node) {
for key, value := range annotations {
switch key {
case BashCompFilenameExt:
writeString(buf, fmt.Sprintf(" flags_with_completion+=(%q)\n", name))

    		var ext string
    		if len(value) > 0 {
    			ext = fmt.Sprintf("__%s_handle_filename_extension_flag ", cmd.Parent.Name) + strings.Join(value, "|")
    		} else {
    			ext = "_filedir"
    		}
    		writeString(buf, fmt.Sprintf("    flags_completion+=(%q)\n", ext))
    	case BashCompCustom:
    		writeString(buf, fmt.Sprintf("    flags_with_completion+=(%q)\n", name))

    		if len(value) > 0 {
    			handlers := strings.Join(value, "; ")
    			writeString(buf, fmt.Sprintf("    flags_completion+=(%q)\n", handlers))
    		} else {
    			writeString(buf, "    flags_completion+=(:)\n")
    		}
    	case BashCompSubdirsInDir:
    		writeString(buf, fmt.Sprintf("    flags_with_completion+=(%q)\n", name))

    		var ext string
    		if len(value) == 1 {
    			ext = fmt.Sprintf("__%s_handle_subdirs_in_dir_flag ", cmd.Parent.Name) + value[0]
    		} else {
    			ext = "_filedir -d"
    		}
    		writeString(buf, fmt.Sprintf("    flags_completion+=(%q)\n", ext))
    	}
    }

}

const cbn = "\")\n"

func writeShortFlag(buf io.StringWriter, flag *kong.Flag, cmd *kong.Node) {
name := fmt.Sprintf("%c", flag.Short)
format := " "
if len(flag.DefaultValue.String()) == 0 {
format += "two*word*"
}
format += "flags+=(\"-%s" + cbn
writeString(buf, fmt.Sprintf(format, name))
writeFlagHandler(buf, "-"+name, map[string][]string{}, cmd)
}

func writeFlag(buf io.StringWriter, flag *kong.Flag, cmd *kong.Node) {
name := flag.Name
format := " flags+=(\"--%s"
if len(flag.DefaultValue.String()) == 0 {
format += "="
}
format += cbn
writeString(buf, fmt.Sprintf(format, name))
if len(flag.DefaultValue.String()) == 0 {
format = " two_word_flags+=(\"--%s" + cbn
writeString(buf, fmt.Sprintf(format, name))
}
writeFlagHandler(buf, "--"+name, map[string][]string{}, cmd)
}

//nolint:deadcode,unused
func writeLocalNonPersistentFlag(buf io.StringWriter, flag \*kong.Flag) {
name := flag.Name
format := " local_nonpersistent_flags+=(\"--%[1]s" + cbn
if len(flag.DefaultValue.String()) == 0 {
format += " local_nonpersistent_flags+=(\"--%[1]s=" + cbn
}
writeString(buf, fmt.Sprintf(format, name))
if flag.Short > 0 {
writeString(buf, fmt.Sprintf(" local_nonpersistent_flags+=(\"-%c\")\n", flag.Short))
}
}

func writeFlags(buf io.StringWriter, cmd \*kong.Node) {
writeString(buf, ` flags=()
two_word_flags=()
local_nonpersistent_flags=()
flags_with_completion=()
flags_completion=()

`)

    for _, flag := range cmd.Flags {
    	if nonCompletableFlag(flag) {
    		continue
    	}
    	writeFlag(buf, flag, cmd)
    	if flag.Short != 0 {
    		writeShortFlag(buf, flag, cmd)
    	}
    }

    writeString(buf, "\n")

}

func writeCmdAliases(buf io.StringWriter, cmd \*kong.Node) {
if len(cmd.Aliases) == 0 {
return
}

    sort.Strings(cmd.Aliases)

    writeString(buf, fmt.Sprint(`    if [[ -z "${BASH_VERSION:-}" || "${BASH_VERSINFO[0]:-}" -gt 3 ]]; then`, "\n"))
    for _, value := range cmd.Aliases {
    	writeString(buf, fmt.Sprintf("        command_aliases+=(%q)\n", value))
    	writeString(buf, fmt.Sprintf("        aliashash[%q]=%q\n", value, cmd.Name))
    }
    writeString(buf, `    fi`)
    writeString(buf, "\n")

}
func writeArgAliases(buf io.StringWriter, cmd \*kong.Node) {
writeString(buf, " noun*aliases=()\n")
sort.Strings(cmd.Aliases)
for *, value := range cmd.Aliases {
writeString(buf, fmt.Sprintf(" noun_aliases+=(%q)\n", value))
}
}

func (b Bash) gen(buf io.StringWriter, cmd \*kong.Node) {
for _, c := range cmd.Children {
if c == nil || c.Hidden {
continue
}
b.gen(buf, c)
}
commandName := cmd.FullPath()
commandName = strings.ReplaceAll(commandName, " ", "_")
commandName = strings.ReplaceAll(commandName, ":", "\_\_")

    if cmd.Parent == nil {
    	writeString(buf, fmt.Sprintf("_%s_root_command()\n{\n", commandName))
    } else {
    	writeString(buf, fmt.Sprintf("_%s()\n{\n", commandName))
    }

    writeString(buf, fmt.Sprintf("    last_command=%q\n", commandName))
    writeString(buf, "\n")
    writeString(buf, "    command_aliases=()\n")
    writeString(buf, "\n")

    writeCommands(buf, cmd)
    writeFlags(buf, cmd)
    writeArgAliases(buf, cmd)
    writeString(buf, "}\n\n")

}

================================================
File: completion/command.go
================================================
package completion

import (
"fmt"
"io"
"os"
"strings"

    "github.com/alecthomas/kong"

)

// Completion command.
type Completion struct {
Bash Bash `cmd:"" help:"Generate the autocompletion script for bash"`
Zsh Zsh `cmd:"" help:"Generate the autocompletion script for zsh"`
Fish Fish `cmd:"" help:"Generate the autocompletion script for fish"`
}

func commandName(cmd \*kong.Node) string {
commandName := cmd.FullPath()
commandName = strings.ReplaceAll(commandName, " ", "\_")
commandName = strings.ReplaceAll(commandName, ":", "\_\_")
return commandName
}

func hasCommands(cmd \*kong.Node) bool {
for \_, c := range cmd.Children {
if !c.Hidden {
return true
}
}
return false
}

//nolint:deadcode,unused
func isArgument(cmd \*kong.Node) bool {
return cmd.Type == kong.ArgumentNode
}

// writeString writes a string into a buffer, and checks if the error is not nil.
func writeString(b io.StringWriter, s string) {
if \_, err := b.WriteString(s); err != nil {
fmt.Fprintln(os.Stderr, "Error:", err)
os.Exit(1)
}
}

func nonCompletableFlag(flag \*kong.Flag) bool {
return flag.Hidden
}

func flagPossibleValues(flag \*kong.Flag) []string {
values := make([]string, 0)
for \_, enum := range flag.EnumSlice() {
if strings.TrimSpace(enum) != "" {
values = append(values, enum)
}
}
return values
}

================================================
File: completion/fish.go
================================================
package completion

import (
"fmt"
"io"
"strings"

    "github.com/alecthomas/kong"

)

// Fish is a fish shell completion generator.
type Fish struct{}

// Run generates fish completion script.
func (f Fish) Run(ctx \*kong.Context) error {
var buf strings.Builder
buf.WriteString(`# Fish shell completion for gum

# Generated by gum completion

# disable file completion unless explicitly enabled

complete -c gum -f

`)
node := ctx.Model.Node
f.gen(&buf, node)
\_, err := fmt.Fprint(ctx.Stdout, buf.String())
if err != nil {
return fmt.Errorf("unable to generate fish completion: %w", err)
}
return nil
}

func (f Fish) gen(buf io.StringWriter, cmd \*kong.Node) {
root := cmd
for root.Parent != nil {
root = root.Parent
}
rootName := root.Name
if cmd.Parent == nil {
_, _ = buf.WriteString(fmt.Sprintf("# %s\n", rootName))
} else {
_, _ = buf.WriteString(fmt.Sprintf("# %s\n", cmd.Path()))
_, _ = buf.WriteString(
fmt.Sprintf("complete -c %s -f -n '\_\_fish_use_subcommand' -a %s -d '%s'\n",
rootName,
cmd.Name,
cmd.Help,
),
)
}

    for _, f := range cmd.Flags {
    	if f.Hidden {
    		continue
    	}
    	if cmd.Parent == nil {
    		_, _ = buf.WriteString(
    			fmt.Sprintf("complete -c %s -f",
    				rootName,
    			),
    		)
    	} else {
    		_, _ = buf.WriteString(
    			fmt.Sprintf("complete -c %s -f -n '__fish_seen_subcommand_from %s'",
    				rootName,
    				cmd.Name,
    			),
    		)
    	}
    	if !f.IsBool() {
    		enums := flagPossibleValues(f)
    		if len(enums) > 0 {
    			_, _ = buf.WriteString(fmt.Sprintf(" -xa '%s'", strings.Join(enums, " ")))
    		} else {
    			_, _ = buf.WriteString(" -x")
    		}
    	}
    	if f.Short != 0 {
    		_, _ = buf.WriteString(fmt.Sprintf(" -s %c", f.Short))
    	}
    	_, _ = buf.WriteString(fmt.Sprintf(" -l %s", f.Name))
    	_, _ = buf.WriteString(fmt.Sprintf(" -d \"%s\"", f.Help))
    	_, _ = buf.WriteString("\n")
    }
    _, _ = buf.WriteString("\n")

    for _, c := range cmd.Children {
    	if c == nil || c.Hidden {
    		continue
    	}
    	f.gen(buf, c)
    }

}

================================================
File: completion/zsh.go
================================================
package completion

import (
"fmt"
"io"
"strings"

    "github.com/alecthomas/kong"

)

// Zsh is zsh completion generator.
type Zsh struct{}

// Run generates zsh completion script.
func (z Zsh) Run(ctx \*kong.Context) error {
var out strings.Builder
format := `#compdef %[1]s

# zsh completion for %[1]s

# generated by gum completion

`
fmt.Fprintf(&out, format, ctx.Model.Name)
z.gen(&out, ctx.Model.Node)
\_, err := fmt.Fprint(ctx.Stdout, out.String())
if err != nil {
return fmt.Errorf("unable to generate zsh completion: %w", err)
}
return nil
}

func (z Zsh) writeFlag(buf io.StringWriter, f \*kong.Flag) {
var str strings.Builder
str.WriteString(" ")
if f.Short != 0 {
str.WriteString("'(")
str.WriteString(fmt.Sprintf("-%c --%s", f.Short, f.Name))
if !f.IsBool() {
str.WriteString("=")
}
str.WriteString(")'")
str.WriteString("{")
str.WriteString(fmt.Sprintf("-%c,--%s", f.Short, f.Name))
if !f.IsBool() {
str.WriteString("=")
}
str.WriteString("}")
str.WriteString("\"")
} else {
str.WriteString("\"")
str.WriteString(fmt.Sprintf("--%s", f.Name))
if !f.IsBool() {
str.WriteString("=")
}
}
str.WriteString(fmt.Sprintf("[%s]", f.Help))
if !f.IsBool() {
str.WriteString(":")
str.WriteString(strings.ToLower(f.Help))
str.WriteString(":")
}
values := flagPossibleValues(f)
if len(values) > 0 {
str.WriteString("(")
for i, v := range f.EnumSlice() {
str.WriteString(v)
if i < len(values)-1 {
str.WriteString(" ")
}
}
str.WriteString(")")
}
str.WriteString("\"")
writeString(buf, str.String())
}

func (z Zsh) writeFlags(buf io.StringWriter, cmd \*kong.Node) {
for i, f := range cmd.Flags {
if f.Hidden {
continue
}
z.writeFlag(buf, f)
if i < len(cmd.Flags)-1 {
writeString(buf, " \\\n")
}
}
}

func (z Zsh) writeCommand(buf io.StringWriter, c \*kong.Node) {
writeString(buf, fmt.Sprintf(" \"%s[%s]\"", c.Name, c.Help))
}

func (z Zsh) writeCommands(buf io.StringWriter, cmd \*kong.Node) {
for i, c := range cmd.Children {
if c == nil || c.Hidden {
continue
}
z.writeCommand(buf, c)
if i < len(cmd.Children)-1 {
_, _ = buf.WriteString(" \\")
}
writeString(buf, "\n")
}
}

func (z Zsh) gen(buf io.StringWriter, cmd \*kong.Node) {
for \_, c := range cmd.Children {
if c == nil || c.Hidden {
continue
}
z.gen(buf, c)
}
cmdName := commandName(cmd)

    writeString(buf, fmt.Sprintf("_%s() {\n", cmdName))
    if hasCommands(cmd) {
    	writeString(buf, "    local line state\n")
    }
    writeString(buf, "    _arguments -C \\\n")
    z.writeFlags(buf, cmd)
    if hasCommands(cmd) {
    	writeString(buf, " \\\n")
    	writeString(buf, "        \"1: :->cmds\" \\\n")
    	writeString(buf, "        \"*::arg:->args\"\n")
    	writeString(buf, "    case \"$state\" in\n")
    	writeString(buf, "        cmds)\n")
    	writeString(buf, fmt.Sprintf("            _values \"%s command\" \\\n", cmdName))
    	z.writeCommands(buf, cmd)
    	writeString(buf, "            ;;\n")
    	writeString(buf, "        args)\n")
    	writeString(buf, "            case \"$line[1]\" in\n")
    	for _, c := range cmd.Children {
    		if c == nil || c.Hidden {
    			continue
    		}
    		writeString(buf, fmt.Sprintf("                %s)\n", c.Name))
    		writeString(buf, fmt.Sprintf("                    _%s\n", commandName(c)))
    		writeString(buf, "                    ;;\n")
    	}
    	writeString(buf, "            esac\n")
    	writeString(buf, "            ;;\n")
    	writeString(buf, "    esac\n")
    }
    // writeArgAliases(buf, cmd)
    writeString(buf, "\n")
    writeString(buf, "}\n\n")

}

================================================
File: confirm/command.go
================================================
package confirm

import (
"fmt"
"os"

    "github.com/charmbracelet/bubbles/help"
    tea "github.com/charmbracelet/bubbletea"
    "github.com/charmbracelet/gum/internal/exit"
    "github.com/charmbracelet/gum/internal/stdin"
    "github.com/charmbracelet/gum/internal/timeout"

)

// Run provides a shell script interface for prompting a user to confirm an
// action with an affirmative or negative answer.
func (o Options) Run() error {
line, err := stdin.Read(stdin.SingleLine(true))
if err == nil {
switch line {
case "yes", "y":
return nil
default:
return exit.ErrExit(1)
}
}

    ctx, cancel := timeout.Context(o.Timeout)
    defer cancel()

    m := model{
    	affirmative:      o.Affirmative,
    	negative:         o.Negative,
    	showOutput:       o.ShowOutput,
    	confirmation:     o.Default,
    	defaultSelection: o.Default,
    	keys:             defaultKeymap(o.Affirmative, o.Negative),
    	help:             help.New(),
    	showHelp:         o.ShowHelp,
    	prompt:           o.Prompt,
    	selectedStyle:    o.SelectedStyle.ToLipgloss(),
    	unselectedStyle:  o.UnselectedStyle.ToLipgloss(),
    	promptStyle:      o.PromptStyle.ToLipgloss(),
    }
    tm, err := tea.NewProgram(
    	m,
    	tea.WithOutput(os.Stderr),
    	tea.WithContext(ctx),
    ).Run()
    if err != nil {
    	return fmt.Errorf("unable to confirm: %w", err)
    }
    m = tm.(model)

    if o.ShowOutput {
    	confirmationText := m.negative
    	if m.confirmation {
    		confirmationText = m.affirmative
    	}
    	fmt.Println(m.prompt, confirmationText)
    }

    if m.confirmation {
    	return nil
    }

    return exit.ErrExit(1)

}

================================================
File: confirm/confirm.go
================================================
// Package confirm provides an interface to ask a user to confirm an action.
// The user is provided with an interface to choose an affirmative or negative
// answer, which is then reflected in the exit code for use in scripting.
//
// If the user selects the affirmative answer, the program exits with 0. If the
// user selects the negative answer, the program exits with 1.
//
// I.e. confirm if the user wants to delete a file
//
// $ gum confirm "Are you sure?" && rm file.txt
package confirm

import (
"github.com/charmbracelet/bubbles/help"
"github.com/charmbracelet/bubbles/key"

    tea "github.com/charmbracelet/bubbletea"
    "github.com/charmbracelet/lipgloss"

)

func defaultKeymap(affirmative, negative string) keymap {
return keymap{
Abort: key.NewBinding(
key.WithKeys("ctrl+c"),
key.WithHelp("ctrl+c", "cancel"),
),
Quit: key.NewBinding(
key.WithKeys("esc"),
key.WithHelp("esc", "quit"),
),
Negative: key.NewBinding(
key.WithKeys("n", "N", "q"),
key.WithHelp("n", negative),
),
Affirmative: key.NewBinding(
key.WithKeys("y", "Y"),
key.WithHelp("y", affirmative),
),
Toggle: key.NewBinding(
key.WithKeys(
"left",
"h",
"ctrl+n",
"shift+tab",
"right",
"l",
"ctrl+p",
"tab",
),
key.WithHelp("←→", "toggle"),
),
Submit: key.NewBinding(
key.WithKeys("enter"),
key.WithHelp("enter", "submit"),
),
}
}

type keymap struct {
Abort key.Binding
Quit key.Binding
Negative key.Binding
Affirmative key.Binding
Toggle key.Binding
Submit key.Binding
}

// FullHelp implements help.KeyMap.
func (k keymap) FullHelp() [][]key.Binding { return nil }

// ShortHelp implements help.KeyMap.
func (k keymap) ShortHelp() []key.Binding {
return []key.Binding{k.Toggle, k.Submit, k.Affirmative, k.Negative}
}

type model struct {
prompt string
affirmative string
negative string
quitting bool
showHelp bool
help help.Model
keys keymap

    showOutput   bool
    confirmation bool

    defaultSelection bool

    // styles
    promptStyle     lipgloss.Style
    selectedStyle   lipgloss.Style
    unselectedStyle lipgloss.Style

}

func (m model) Init() tea.Cmd { return nil }

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
switch msg := msg.(type) {
case tea.WindowSizeMsg:
return m, nil
case tea.KeyMsg:
switch {
case key.Matches(msg, m.keys.Abort):
m.confirmation = false
return m, tea.Interrupt
case key.Matches(msg, m.keys.Quit):
m.confirmation = false
m.quitting = true
return m, tea.Quit
case key.Matches(msg, m.keys.Negative):
m.confirmation = false
m.quitting = true
return m, tea.Quit
case key.Matches(msg, m.keys.Toggle):
if m.negative == "" {
break
}
m.confirmation = !m.confirmation
case key.Matches(msg, m.keys.Submit):
m.quitting = true
return m, tea.Quit
case key.Matches(msg, m.keys.Affirmative):
m.quitting = true
m.confirmation = true
return m, tea.Quit
}
}
return m, nil
}

func (m model) View() string {
if m.quitting {
return ""
}

    var aff, neg string

    if m.confirmation {
    	aff = m.selectedStyle.Render(m.affirmative)
    	neg = m.unselectedStyle.Render(m.negative)
    } else {
    	aff = m.unselectedStyle.Render(m.affirmative)
    	neg = m.selectedStyle.Render(m.negative)
    }

    // If the option is intentionally empty, do not show it.
    if m.negative == "" {
    	neg = ""
    }

    if m.showHelp {
    	return lipgloss.JoinVertical(
    		lipgloss.Left,
    		m.promptStyle.Render(m.prompt)+"\n",
    		lipgloss.JoinHorizontal(lipgloss.Left, aff, neg),
    		"\n"+m.help.View(m.keys),
    	)
    }

    return lipgloss.JoinVertical(
    	lipgloss.Left,
    	m.promptStyle.Render(m.prompt)+"\n",
    	lipgloss.JoinHorizontal(lipgloss.Left, aff, neg),
    )

}

================================================
File: confirm/options.go
================================================
package confirm

import (
"time"

    "github.com/charmbracelet/gum/style"

)

// Options is the customization options for the confirm command.
type Options struct {
Default bool `help:"Default confirmation action" default:"true"`
ShowOutput bool `help:"Print prompt and chosen action to output" default:"false"`
Affirmative string `help:"The title of the affirmative action" default:"Yes"`
Negative string `help:"The title of the negative action" default:"No"`
Prompt string `arg:"" help:"Prompt to display." default:"Are you sure?"`
//nolint:staticcheck
PromptStyle style.Styles `embed:"" prefix:"prompt." help:"The style of the prompt" set:"defaultMargin=0 0 0 1" set:"defaultForeground=#7571F9" set:"defaultBold=true" envprefix:"GUM_CONFIRM_PROMPT_"`
//nolint:staticcheck
SelectedStyle style.Styles `embed:"" prefix:"selected." help:"The style of the selected action" set:"defaultBackground=212" set:"defaultForeground=230" set:"defaultPadding=0 3" set:"defaultMargin=0 1" envprefix:"GUM_CONFIRM_SELECTED_"`
//nolint:staticcheck
UnselectedStyle style.Styles `embed:"" prefix:"unselected." help:"The style of the unselected action" set:"defaultBackground=235" set:"defaultForeground=254" set:"defaultPadding=0 3" set:"defaultMargin=0 1" envprefix:"GUM_CONFIRM_UNSELECTED_"`
ShowHelp bool `help:"Show help key binds" negatable:"" default:"true" env:"GUM_CONFIRM_SHOW_HELP"`
Timeout time.Duration `help:"Timeout until confirm returns selected value or default if provided" default:"0s" env:"GUM_CONFIRM_TIMEOUT"`
}

================================================
File: cursor/cursor.go
================================================
package cursor

import (
"github.com/charmbracelet/bubbles/cursor"
)

// Modes maps strings to cursor modes.
var Modes = map[string]cursor.Mode{
"blink": cursor.CursorBlink,
"hide": cursor.CursorHide,
"static": cursor.CursorStatic,
}

================================================
File: examples/README.md
================================================

# Glamour

A casual introduction. 你好世界！

## Let's talk about artichokes

The artichoke is mentioned as a garden
plant in the 8th century BC by Homer
and Hesiod. The naturally occurring
variant of the artichoke, the cardoon,
which is native to the Mediterranean
area, also has records of use as a
food among the ancient Greeks and
Romans. Pliny the Elder mentioned
growing of 'carduus' in Carthage
and Cordoba.

He holds him with his skinny hand,
There was ship,' quoth he.
'Hold off! unhand me, grey-beard loon!'
An artichoke dropt he.

## Other foods worth mentioning

1. Carrots
2. Celery
3. Tacos
   • Soft
   • Hard
4. Cucumber

## Things to eat today

- Carrots
- Ramen
- Currywurst

================================================
File: examples/choose.tape
================================================
Output choose.gif

Set Width 1000
Set Height 430
Set Shell bash

Type "gum choose {1..5}"
Sleep 500ms
Enter
Sleep 500ms
Down@250ms 3
Sleep 500ms
Up@250ms 2
Enter
Sleep 1.5s
Ctrl+L
Sleep 500ms
Type "gum choose --limit 2 Banana Cherry Orange"
Sleep 500ms
Enter
Sleep 500ms
Type@250ms "jxjxk"
Sleep 1s
Enter
Sleep 2s

================================================
File: examples/commit.sh
================================================
#!/bin/sh

# This script is used to write a conventional commit message.

# It prompts the user to choose the type of commit as specified in the

# conventional commit spec. And then prompts for the summary and detailed

# description of the message and uses the values provided. as the summary and

# details of the message.

#

# If you want to add a simpler version of this script to your dotfiles, use:

#

# alias gcm='git commit -m "$(gum input)" -m "$(gum write)"'

# if [ -z "$(git status -s -uno | grep -v '^ ' | awk '{print $2}')" ]; then

# gum confirm "Stage all?" && git add .

# fi

TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" "chore" "revert")
SCOPE=$(gum input --placeholder "scope")

# Since the scope is optional, wrap it in parentheses if it has a value.

test -n "$SCOPE" && SCOPE="($SCOPE)"

# Pre-populate the input with the type(scope): so that the user may change it

SUMMARY=$(gum input --value "$TYPE$SCOPE: " --placeholder "Summary of this change")
DESCRIPTION=$(gum write --placeholder "Details of this change")

# Commit these changes if user confirms

gum confirm "Commit changes?" && git commit -m "$SUMMARY" -m "$DESCRIPTION"

================================================
File: examples/commit.tape
================================================
Output commit.gif

Set Shell "bash"
Set FontSize 32
Set Width 1200
Set Height 600

Type "./commit.sh" Sleep 500ms Enter

Sleep 1s
Down@250ms 2
Sleep 500ms
Enter

Sleep 500ms

Type "gum"

Sleep 500ms
Enter

Sleep 1s

Type "Gum is sooo tasty"
Sleep 500ms

Enter

Sleep 1s

Type@65ms "I love bubble gum."
Sleep 500ms
Alt+Enter
Sleep 500ms
Alt+Enter
Sleep 500ms
Type "This commit shows how much I love chewing bubble gum!!!"
Sleep 500ms
Enter

Sleep 1s

Left@400ms 3

Sleep 1s

================================================
File: examples/confirm.tape
================================================
Output confirm.gif

Set Width 1000
Set Height 350
Set Shell bash

Sleep 500ms
Type "gum confirm && echo 'Me too!' || echo 'Me neither.'"
Sleep 1s
Enter
Sleep 1s
Right
Sleep 500ms
Left
Sleep 500ms
Enter
Sleep 1.5s
Ctrl+L
Type "gum confirm && echo 'Me too!' || echo 'Me neither.'"
Sleep 500ms
Enter
Sleep 500ms
Right
Sleep 500ms
Enter
Sleep 1s

================================================
File: examples/convert-to-gif.sh
================================================
#!/bin/bash

# This script converts some video to a GIF. It prompts the user to select an

# video file with `gum filter` Set the frame rate, desired width, and max

# colors to use Then, converts the video to a GIF.

INPUT=$(gum filter --placeholder "Input file")
FRAMERATE=$(gum input --prompt "Frame rate: " --placeholder "Frame Rate" --prompt.foreground 240 --value "50")
WIDTH=$(gum input --prompt "Width: " --placeholder "Width" --prompt.foreground 240 --value "1200")
MAXCOLORS=$(gum input --prompt "Max Colors: " --placeholder "Max Colors" --prompt.foreground 240 --value "256")

BASENAME=$(basename "$INPUT")
BASENAME="${BASENAME%%.\*}"

gum spin --title "Converting to GIF" -- ffmpeg -i "$INPUT" -vf "fps=$FRAMERATE,scale=$WIDTH:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=$MAXCOLORS[p];[s1][p]paletteuse" "$BASENAME.gif"

================================================
File: examples/customize.tape
================================================
Output customize.gif

Set Width 1000
Set Height 350
Set Shell bash

Sleep 1s
Type `gum input --cursor.foreground "#F4AC45" \` Enter
Type `--prompt.foreground "#04B575" --prompt "What's up? " \` Enter
Type `--placeholder "Not much, you?" --value "Not much, you?" \` Enter
Type `--width 80` Enter
Sleep 1s
Ctrl+A
Sleep 1s
Ctrl+E
Sleep 1s
Ctrl+U
Sleep 1s

================================================
File: examples/demo.sh
================================================
#!/bin/bash

gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Hello, there! Welcome to $(gum style --foreground 212 'Gum')."
NAME=$(gum input --placeholder "What is your name?")

echo -e "Well, it is nice to meet you, $(gum style --foreground 212 "$NAME")."

sleep 1; clear

echo -e "Can you tell me a $(gum style --italic --foreground 99 'secret')?\n"

gum write --placeholder "I'll keep it to myself, I promise!" > /dev/null # we keep the secret to ourselves

clear; echo "What should I do with this information?"; sleep 1

READ="Read"; THINK="Think"; DISCARD="Discard"
ACTIONS=$(gum choose --no-limit "$READ" "$THINK" "$DISCARD")

clear; echo "One moment, please."

grep -q "$READ" <<< "$ACTIONS" && gum spin -s line --title "Reading the secret..." -- sleep 1
grep -q "$THINK" <<< "$ACTIONS" && gum spin -s pulse --title "Thinking about your secret..." -- sleep 1
grep -q "$DISCARD" <<< "$ACTIONS" && gum spin -s monkey --title " Discarding your secret..." -- sleep 2

sleep 1; clear

GUM=$(echo -e "Cherry\nGrape\nLime\nOrange" | gum filter --placeholder "Favorite flavor?")
echo "I'll keep that in mind!"

sleep 1; clear

echo "Do you like $(gum style --foreground "#04B575" "Bubble Gum?")"
sleep 1

CHOICE=$(gum choose --item.foreground 250 "Yes" "No" "It's complicated")

[["$CHOICE" == "Yes"]] && echo "I thought so, $(gum style --bold "Bubble Gum") is the best." || echo "I'm sorry to hear that."

sleep 1

gum spin --title "Chewing some $(gum style --foreground "#04B575" "$GUM") bubble gum..." -- sleep 2.5

clear

NICE_MEETING_YOU=$(gum style --height 5 --width 20 --padding '1 3' --border double --border-foreground 57 "Nice meeting you, $(gum style --foreground 212 "$NAME"). See you soon!")
CHEW_BUBBLE_GUM=$(gum style --width 17 --padding '1 3' --border double --border-foreground 212 "Go chew some $(gum style --foreground "#04B575" "$GUM") bubble gum.")
gum join --horizontal "$NICE_MEETING_YOU" "$CHEW_BUBBLE_GUM"

================================================
File: examples/demo.tape
================================================
Output ./demo.gif

Set Shell bash

Set FontSize 22
Set Width 800
Set Height 450

Type "./demo.sh"
Enter
Sleep 1s
Type "Walter"
Sleep 500ms
Enter

Sleep 2s

Type "Nope, sorry!"
Sleep 500ms
Alt+Enter
Sleep 200ms
Alt+Enter
Sleep 500ms
Type "I don't trust you."
Sleep 1s
Enter

Sleep 2s

Type "x" Sleep 250ms Type "j" Sleep 250ms
Type "x" Sleep 250ms Type "j" Sleep 250ms
Type "x" Sleep 1s

Enter

Sleep 6s

Type "li"
Sleep 1s
Enter

Sleep 3s
Down@500ms 2
Up@500ms 2
Sleep 1s
Enter

Sleep 6s

================================================
File: examples/diyfetch
================================================
#!/bin/sh

# \_**\_ \_\_\_** \__\_\_ _ \_

# | _ \_ _\ \ / / \_| **_| |_ \_**| |\_\_

# | | | | | \ V / |_ / _ \ **/ **| '\_ \

# | |_| | | | || _| **/ || (**| | | |

# |\_**_/_**| |_||_| \_**|\_\_\_**|_| |_|

#

# About:

# DIYfetch it the shell script template for writing fetch tool

# utilizing `gum join` command (https://github.com/charmbracelet/gum#join).

#

# This script is written in POSIX-shell for portability

# feel free to switch it to any scripting language that you prefer.

#

# Note:

# When copy ANSI string from random script make sure to replace "\033" and "\e" to ""

# or wrap it in `$(printf '%b' "<ansi_string>")`.

#

# URL: https://github.com/info-mono/diyfetch

# Prepare ------------------------------------------------------------------------------------------

# You can lookup the color codes on https://wikipedia.org/wiki/ANSI_escape_code#8-bit

main_color=4

# You can add some eye candy icons with Emoji of use Nerd Fonts (https://www.nerdfonts.com).

## info=$(gum style "[1;38;5;${main_color}m${USER}[0m@[1;38;5;${main_color}m$(hostname)[0m

[1;38;5;${main_color}mOS:        [0m<your_os>
[1;38;5;${main_color}mKERNEL: [0m$(uname -sr)
[1;38;5;${main_color}mUPTIME: [0m$(uptime -p | cut -c 4-)
[1;38;5;${main_color}mSHELL: [0m$(basename "${SHELL}")
[1;38;5;${main_color}mEDITOR:    [0m$(basename "${EDITOR:-<your_editor>}")
[1;38;5;${main_color}mDE: [0m<your_de>
[1;38;5;${main_color}mWM:        [0m<your_wm>
[1;38;5;${main_color}mTERMINAL: [0m<your_terminal>")

# You can get OS arts on https://github.com/info-mono/os-ansi

# copy the raw data of the .ansi file then paste it down below.

art=$(gum style ' [34m**\_[0m
[34m([0m.. [34m|[0m
[34m([33m<> [34m|[0m
[34m/ [0m** [34m\[0m
[34m( [0m/ \[34m/ |[0m
[33m*[34m/\ [0m\_\_)[34m/[33m*[34m)[0m
[33m\/[34m-\_\_\_\_[33m\/[0m')

# You can generate colorstrip using https://github.com/info-mono/colorstrip

color=$(gum style '[0;30m███[0;31m███[0;32m███[0;33m███[0;34m███[0;35m███[0;36m███[0;37m███[0m
[0;1;90m███[0;1;91m███[0;1;92m███[0;1;93m███[0;1;94m███[0;1;95m███[0;1;96m███[0;1;97m███[0m')

# Display ------------------------------------------------------------------------------------------

# The code in this section is to display the fetch adaptively to the terminal's size.

# If you just want a static fetch display, you can just use something like this:

#

# group_info_color=$(gum join --vertical "${info}" '' "${color}")

# gum join --horizontal --align center ' ' "${art}" '  ' "${group_info_color}"

terminal_size=$(stty size)
terminal_height=${terminal_size% _}
terminal_width=${terminal_size#_ }

# Acknowledge of how high the shell prompt is so the prompt don't push the fetch out.

prompt_height=${PROMPT_HEIGHT:-1}

print_test() {
no_color=$(printf '%b' "${1}" | sed -e 's/\x1B\[[0-9;]\*[JKmsu]//g')

    [ "$(printf '%s' "${no_color}" | wc --lines)" -gt $(( terminal_height - prompt_height )) ] && return 1
    [ "$(printf '%s' "${no_color}" | wc --max-line-length)" -gt "${terminal_width}" ] && return 1

    gum style --align center --width="${terminal_width}" "${1}" ''
    printf '%b' "\033[A"

    exit 0

}

# Paper layout

print_test "$(gum join --vertical --align center "${art}" '' "${info}" '' "${color}")"

# Classic layout

group_info_color=$(gum join --vertical "${info}" '' "${color}")
print_test "$(gum join --horizontal --align center "${art}" '  ' "${group_info_color}")"

# Hybrid layout

group_art_info=$(gum join --horizontal --align center "${art}" ' ' "${info}")
print_test "$(gum join --vertical --align center "${group_art_info}" '' "${color}")"

# Other layout

print_test "$(gum join --vertical --align center "${art}" '' "${info}")"
print_test "${group_art_info}"
print_test "${group_info_color}"
print_test "${info}"

exit 1

================================================
File: examples/fav.txt
================================================
Banana

================================================
File: examples/file.tape
================================================
Output file.gif
Set Width 800
Set Height 525
Set Shell bash

Type "gum file .."
Enter
Sleep 1s
Down@150ms 6
Sleep 1s
Enter
Sleep 1s
Type "j"
Sleep 1s

================================================
File: examples/filter-key-value.sh
================================================
#!/bin/bash

export LIST=$(cat <<END
Cow:Moo
Cat:Meow
Dog:Woof
END
)

ANIMAL=$(echo "$LIST" | cut -d':' -f1 | gum filter)
SOUND=$(echo "$LIST" | grep $ANIMAL | cut -d':' -f2)

echo "The $ANIMAL goes $SOUND"

================================================
File: examples/flavors.txt
================================================
Banana
Cherry
Orange
Strawberry

================================================
File: examples/format.ansi
================================================
[38;2;90;86;224m> [0mgum format -t code < main.go

[38;5;204m[0m[38;5;252m[0m [38;5;252m [0m[38;5;252m [0m[38;5;204mpackage[0m[38;5;251m [0m[38;5;251mmain[0m[38;5;251m[0m
[0m[38;5;252m[0m [38;5;252m [0m[38;5;252m [0m[38;5;251m[0m
[0m[38;5;204m[0m[38;5;252m[0m [38;5;252m [0m[38;5;252m [0m[38;5;204mimport[0m[38;5;251m [0m[38;5;173m"fmt"[0m[38;5;251m[0m
[0m[38;5;252m[0m [38;5;252m [0m[38;5;252m [0m[38;5;251m[0m
[0m[38;5;39m[0m[38;5;252m[0m [38;5;252m [0m[38;5;252m [0m[38;5;39mfunc[0m[38;5;251m [0m[38;5;42mmain[0m[38;5;187m()[0m[38;5;251m [0m[38;5;187m{[0m[38;5;251m[0m
[0m[38;5;252m[0m [38;5;252m [0m[38;5;252m [0m[38;5;251m [0m[38;5;251mfmt[0m[38;5;187m.[0m[38;5;42mPrintln[0m[38;5;187m([0m[38;5;173m"Charm_™ Gum"[0m[38;5;187m)[0m[38;5;251m[0m
[0m[38;5;187m[0m[38;5;252m[0m [38;5;252m [0m[38;5;252m [0m[38;5;187m}[0m[38;5;251m[0m
[0m[38;5;252m[0m [38;5;252m [0m[38;5;252m [0m[38;5;251m[0m
[0m

================================================
File: examples/git-branch-manager.sh
================================================
#! /bin/sh

# This script is used to manage git branches such as delete, update, and rebase

# them. It prompts the user to choose the branches and the action they want to

# perform.

#

# For an explanation on the script and tutorial on how to create it, watch:

# https://www.youtube.com/watch?v=tnikefEuArQ

GIT_COLOR="#f14e32"

git_color_text () {
gum style --foreground "$GIT_COLOR" "$1"
}

get_branches () {
if [ ${1+x} ]; then
gum choose --selected.foreground="$GIT_COLOR" --limit="$1" $(git branch --format="%(refname:short)")
  else
    gum choose --selected.foreground="$GIT_COLOR" --no-limit $(git branch --format="%(refname:short)")
fi
}

git rev-parse --git-dir > /dev/null 2>&1

if [ $? -ne 0 ];
then
echo "$(git_color_text "!!") Must be run in a $(git_color_text "git") repo"
exit 1
fi

gum style \
 --border normal \
 --margin "1" \
 --padding "1" \
 --border-foreground "$GIT_COLOR" \
  "$(git_color_text ' Git') Branch Manager"

echo "Choose $(git_color_text 'branches') to operate on:"
branches=$(get_branches)

echo ""
echo "Choose a $(git_color_text "command"):"
command=$(gum choose --cursor.foreground="$GIT_COLOR" rebase delete update)
echo ""

echo $branches | tr " " "\n" | while read -r branch
do
  case $command in
    rebase)
      base_branch=$(get_branches 1)
git fetch origin
git checkout "$branch"
      git rebase "origin/$base_branch"
;;
delete)
git branch -D "$branch"
      ;;
    update)
      git checkout "$branch"
git pull --ff-only
;;
esac
done

================================================
File: examples/git-stage.sh
================================================
#!/bin/bash

ADD="Add"
RESET="Reset"

ACTION=$(gum choose "$ADD" "$RESET")

if [ "$ACTION" == "$ADD" ]; then
git status --short | cut -c 4- | gum choose --no-limit | xargs git add
else
git status --short | cut -c 4- | gum choose --no-limit | xargs git restore
fi

================================================
File: examples/gum.js
================================================
const { spawn } = require("child_process");

const activities = ["walking", "running", "cycling", "driving", "transport"];

console.log("What's your favorite activity?")
const gum = spawn("gum", ["choose", ...activities]);

gum.stderr.pipe(process.stderr);

gum.stdout.on("data", data => {
const activity = data.toString().trim();
console.log(`I like ${activity} too!`);
});

================================================
File: examples/gum.py
================================================
import subprocess

print("What's your favorite language?")

result = subprocess.run(["gum", "choose", "Go", "Python"], stdout=subprocess.PIPE, text=True)

print(f"I like {result.stdout.strip()}, too!")

================================================
File: examples/gum.rb
================================================
puts 'What is your name?'
name = `gum input --placeholder "Your name"`.chomp

puts "Hello #{name}!"

puts 'Pick your 2 favorite colors'

COLORS = {
'Red' => '#FF0000',
'Blue' => '#0000FF',
'Green' => '#00FF00',
'Yellow' => '#FFFF00',
'Orange' => '#FFA500',
'Purple' => '#800080',
'Pink' => '#FF00FF'
}.freeze

colors = `gum choose #{COLORS.keys.join(' ')} --limit 2`.chomp.split("\n")

if colors.length == 2
first = `gum style --foreground '#{COLORS[colors[0]]}' '#{colors[0]}'`.chomp
second = `gum style --foreground '#{COLORS[colors[1]]}' '#{colors[1]}'`.chomp
puts "You chose #{first} and #{second}."
elsif colors.length == 1
first = `gum style --foreground '#{COLORS[colors[0]]}' '#{colors[0]}'`.chomp
puts "You chose #{first}."
else
puts "You didn't pick any colors!"
end

================================================
File: examples/input.tape
================================================
Output input.gif

Set Width 800
Set Height 250
Set Shell bash

Sleep 1s
Type `gum input --placeholder "What's up?"`
Sleep 1s
Enter
Sleep 1s
Type "Not much, you?"
Sleep 1s
Enter
Sleep 1s

================================================
File: examples/kaomoji.sh
================================================
#!/usr/bin/env bash

# If the user passes '-h', '--help', or 'help' print out a little bit of help.

# text.

case "$1" in
	"-h" | "--help" | "help")
        printf 'Generate kaomojis on request.\n\n'
        printf 'Usage: %s [kind]\n' "$(basename "$0")"
exit 1
;;
esac

# The user can pass an argument like "bear" or "angry" to specify the general

# kind of Kaomoji produced.

sentiment=""
if [[$1 != ""]]; then
sentiment=" $1"
fi

# Ask mods to generate Kaomojis. Save the output in a variable.

kaomoji="$(mods "generate 10${sentiment} kaomojis. number them and put each one on its own line.")"
if [[$kaomoji == ""]]; then
exit 1
fi

# Pipe mods output to gum so the user can choose the perfect kaomoji. Save that

# choice in a variable. Also note that we're using cut to drop the item number

# in front of the Kaomoji.

choice="$(echo "$kaomoji" | gum choose | cut -d ' ' -f 2)"
if [[$choice == ""]]; then
exit 1
fi

# If xsel (X11) or pbcopy (macOS) exists, copy to the clipboard. If not, just

# print the Kaomoji.

if command -v xsel &> /dev/null; then
printf '%s' "$choice" | xclip -sel clip # X11
elif command -v pbcopy &> /dev/null; then
	printf '%s' "$choice" | pbcopy # macOS
else # We can't copy, so just print it out.
printf 'Here you go: %s\n' "$choice"
exit 0
fi

# We're done!

printf 'Copied %s to the clipboard\n' "$choice"

================================================
File: examples/magic.sh
================================================
#!/bin/bash

# Always ask for permission!

echo "Do you want to see a magic trick?"

YES="Yes, please!"
NO="No, thank you!"

CHOICE=$(gum choose "$YES" "$NO")

if [ "$CHOICE" != "$YES" ]; then
echo "Alright, then. Have a nice day!"
exit 1
fi

# Let the magic begin.

echo "Alright, then. Let's begin!"
gum style --foreground 212 "Pick a card, any card..."

CARD=$(gum choose "Ace (A)" "Two (2)" "Three (3)" "Four (4)" "Five (5)" "Six (6)" "Seven (7)" "Eight (8)" "Nine (9)" "Ten (10)" "Jack (J)" "Queen (Q)" "King (K)")
SUIT=$(gum choose "Hearts (♥)" "Diamonds (♦)" "Clubs (♣)" "Spades (♠)")

gum style --foreground 212 "You picked the $CARD of $SUIT."

SHORT_CARD=$(echo $CARD | cut -d' ' -f2 | tr -d '()')
SHORT_SUIT=$(echo $SUIT | cut -d' ' -f2 | tr -d '()')

TOP_LEFT=$(gum join --vertical "$SHORT_CARD" "$SHORT_SUIT")
BOTTOM_RIGHT=$(gum join --vertical "$SHORT_SUIT" "$SHORT_CARD")

TOP_LEFT=$(gum style --width 10 --height 5 --align left "$TOP_LEFT")
BOTTOM_RIGHT=$(gum style --width 10 --align right "$BOTTOM_RIGHT")

if [["$SHORT_SUIT" == "♥" || "$SHORT_SUIT" == "♦"]]; then
CARD_COLOR="1" # Red
else
CARD_COLOR="7" # Black
fi

gum style --border rounded --padding "0 1" --margin 2 --border-foreground "$CARD_COLOR" --foreground "$CARD_COLOR" "$(gum join --vertical "$TOP_LEFT" "$BOTTOM_RIGHT")"

echo "Is this your card?"

gum choose "Omg, yes!" "Nope, sorry!"

================================================
File: examples/pager.tape
================================================
Output pager.gif

Set Shell bash
Set Width 900
Set Height 750

Sleep 1s
Type "gum pager < README.md"
Enter
Sleep 1.5s
Down@100ms 25
Sleep 1s
Up@100ms 25
Sleep 3s

================================================
File: examples/posix.sh
================================================
#!/bin/sh

echo "What's your favorite shell?"

gum choose "Posix" "Bash" "Zsh" "Fish" "Elvish"

================================================
File: examples/skate.sh
================================================
#!/bin/sh

# Building a simple `skate` TUI with gum to allow you to select a database and

# pick a value from skate.

DATABASE=$(skate list-dbs | gum choose)
skate list --keys-only "$DATABASE" | gum filter | xargs -I {} skate get {}"$DATABASE"

================================================
File: examples/spin.tape
================================================
Output spin.gif

Set Shell bash
Set Width 1200
Set Height 300
Set FontSize 36

Sleep 500ms
Type `gum spin --title "Buying Gum..." -- sleep 5`
Sleep 1s
Enter
Sleep 4s

================================================
File: examples/story.txt
================================================
Once upon a time
In a land far, far away....

================================================
File: examples/test.sh
================================================
#!/bin/sh

# Choose

gum choose Foo Bar Baz
gum choose Choose One Item --cursor "_ " --cursor.foreground 99 --selected.foreground 99
gum choose Pick Two Items Maximum --limit 2 --cursor "_ " --cursor-prefix "(•) " --selected-prefix "(x) " --unselected-prefix "( ) " --cursor.foreground 99 --selected.foreground 99
gum choose Unlimited Choice Of Items --no-limit --cursor "\* " --cursor-prefix "(•) " --selected-prefix "(x) " --unselected-prefix "( ) " --cursor.foreground 99 --selected.foreground 99

# Confirm

gum confirm "Testing?"
gum confirm "No?" --default=false --affirmative "Okay." --negative "Cancel."

# Filter

gum filter
echo {1..500} | sed 's/ /\n/g' | gum filter
echo {1..500} | sed 's/ /\n/g' | gum filter --indicator ">" --placeholder "Pick a number..." --indicator.foreground 1 --text.foreground 2 --match.foreground 3 --prompt.foreground 4 --height 5

# Format

echo "# Header\nBody" | gum format
echo 'package main\n\nimport "fmt"\n\nfunc main() {\n\tfmt.Println("Hello, Gum!")\n}\n' | gum format -t code
echo ":candy:" | gum format -t emoji
echo '{{ Bold "Bold" }}' | gum format -t template

# Input

gum input
gum input --prompt "Email: " --placeholder "john@doe.com" --prompt.foreground 99 --cursor.foreground 99 --width 50
gum input --password --prompt "Password: " --placeholder "hunter2" --prompt.foreground 99 --cursor.foreground 99 --width 50

# Join

gum join "Horizontal" "Join"
gum join --vertical "Vertical" "Join"

# Spin

gum spin -- sleep 1
gum spin --spinner minidot --title "Loading..." --title.foreground 99 -- sleep 1
gum spin --show-output --spinner monkey --title "Loading..." --title.foreground 99 -- sh -c 'sleep 1; echo "Hello, Gum!"'

# Style

gum style --foreground 99 --border double --border-foreground 99 --padding "1 2" --margin 1 "Hello, Gum."

# Write

gum write
gum write --width 40 --height 6 --placeholder "Type whatever you want" --prompt "| " --show-cursor-line --show-line-numbers --value "Something..." --base.padding 1 --cursor.foreground 99 --prompt.foreground 99

# Table

gum table < table/example.csv

# Pager

gum pager < README.md

# File

gum file

================================================
File: examples/write.tape
================================================
Output write.gif

Set Width 800
Set Height 350
Set Shell bash

Sleep 500ms
Type "gum write > story.txt"
Enter
Sleep 1s
Type "Once upon a time"
Sleep 1s
Alt+Enter
Type "In a land far, far away...."
Sleep 500ms
Enter
Sleep 1s
Type "cat story.txt"
Enter
Sleep 2s

================================================
File: examples/.gitignore
================================================
_.gif
_.png

================================================
File: file/command.go
================================================
package file

import (
"errors"
"fmt"
"os"
"path/filepath"

    "github.com/charmbracelet/bubbles/filepicker"
    "github.com/charmbracelet/bubbles/help"
    tea "github.com/charmbracelet/bubbletea"
    "github.com/charmbracelet/gum/internal/timeout"

)

// Run is the interface to picking a file.
func (o Options) Run() error {
if !o.File && !o.Directory {
return errors.New("at least one between --file and --directory must be set")
}

    if o.Path == "" {
    	o.Path = "."
    }

    path, err := filepath.Abs(o.Path)
    if err != nil {
    	return fmt.Errorf("file not found: %w", err)
    }

    fp := filepicker.New()
    fp.CurrentDirectory = path
    fp.Path = path
    fp.Height = o.Height
    fp.AutoHeight = o.Height == 0
    fp.Cursor = o.Cursor
    fp.DirAllowed = o.Directory
    fp.FileAllowed = o.File
    fp.ShowPermissions = o.Permissions
    fp.ShowSize = o.Size
    fp.ShowHidden = o.All
    fp.Styles = filepicker.DefaultStyles()
    fp.Styles.Cursor = o.CursorStyle.ToLipgloss()
    fp.Styles.Symlink = o.SymlinkStyle.ToLipgloss()
    fp.Styles.Directory = o.DirectoryStyle.ToLipgloss()
    fp.Styles.File = o.FileStyle.ToLipgloss()
    fp.Styles.Permission = o.PermissionsStyle.ToLipgloss()
    fp.Styles.Selected = o.SelectedStyle.ToLipgloss()
    fp.Styles.FileSize = o.FileSizeStyle.ToLipgloss()
    m := model{
    	filepicker:  fp,
    	showHelp:    o.ShowHelp,
    	help:        help.New(),
    	keymap:      defaultKeymap(),
    	headerStyle: o.HeaderStyle.ToLipgloss(),
    	header:      o.Header,
    }

    ctx, cancel := timeout.Context(o.Timeout)
    defer cancel()

    tm, err := tea.NewProgram(
    	&m,
    	tea.WithOutput(os.Stderr),
    	tea.WithContext(ctx),
    ).Run()
    if err != nil {
    	return fmt.Errorf("unable to pick selection: %w", err)
    }
    m = tm.(model)
    if m.selectedPath == "" {
    	return errors.New("no file selected")
    }

    fmt.Println(m.selectedPath)
    return nil

}

================================================
File: file/file.go
================================================
// Package file provides an interface to pick a file from a folder (tree).
// The user is provided a file manager-like interface to navigate, to
// select a file.
//
// Let's pick a file from the current directory:
//
// $ gum file
// $ gum file .
//
// Let's pick a file from the home directory:
//
// $ gum file $HOME
package file

import (
"github.com/charmbracelet/bubbles/filepicker"
"github.com/charmbracelet/bubbles/help"
"github.com/charmbracelet/bubbles/key"
tea "github.com/charmbracelet/bubbletea"
"github.com/charmbracelet/lipgloss"
)

type keymap filepicker.KeyMap

var keyQuit = key.NewBinding(
key.WithKeys("esc", "q"),
key.WithHelp("esc", "close"),
)

var keyAbort = key.NewBinding(
key.WithKeys("ctrl+c"),
key.WithHelp("ctrl+c", "abort"),
)

func defaultKeymap() keymap {
km := filepicker.DefaultKeyMap()
return keymap(km)
}

// FullHelp implements help.KeyMap.
func (k keymap) FullHelp() [][]key.Binding { return nil }

// ShortHelp implements help.KeyMap.
func (k keymap) ShortHelp() []key.Binding {
return []key.Binding{
key.NewBinding(
key.WithKeys("up", "down"),
key.WithHelp("↓↑", "navigate"),
),
keyQuit,
k.Select,
}
}

type model struct {
header string
headerStyle lipgloss.Style
filepicker filepicker.Model
selectedPath string
quitting bool
showHelp bool
help help.Model
keymap keymap
}

func (m model) Init() tea.Cmd { return m.filepicker.Init() }

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
switch msg := msg.(type) {
case tea.WindowSizeMsg:
if m.showHelp {
m.filepicker.Height -= lipgloss.Height(m.helpView())
}
case tea.KeyMsg:
switch {
case key.Matches(msg, keyAbort):
m.quitting = true
return m, tea.Interrupt
case key.Matches(msg, keyQuit):
m.quitting = true
return m, tea.Quit
}
}
var cmd tea.Cmd
m.filepicker, cmd = m.filepicker.Update(msg)
if didSelect, path := m.filepicker.DidSelectFile(msg); didSelect {
m.selectedPath = path
m.quitting = true
return m, tea.Quit
}
return m, cmd
}

func (m model) View() string {
if m.quitting {
return ""
}
var parts []string
if m.header != "" {
parts = append(parts, m.headerStyle.Render(m.header))
}
parts = append(parts, m.filepicker.View())
if m.showHelp {
parts = append(parts, m.helpView())
}
return lipgloss.JoinVertical(lipgloss.Left, parts...)
}

func (m model) helpView() string {
return m.help.View(m.keymap)
}

================================================
File: file/options.go
================================================
package file

import (
"time"

    "github.com/charmbracelet/gum/style"

)

// Options are the options for the file command.
type Options struct {
// Path is the path to the folder / directory to begin traversing.
Path string `arg:"" optional:"" name:"path" help:"The path to the folder to begin traversing" env:"GUM_FILE_PATH"`
// Cursor is the character to display in front of the current selected items.
Cursor string `short:"c" help:"The cursor character" default:">" env:"GUM_FILE_CURSOR"`
All bool `short:"a" help:"Show hidden and 'dot' files" default:"false" env:"GUM_FILE_ALL"`
Permissions bool `short:"p" help:"Show file permissions" default:"true" negatable:"" env:"GUM_FILE_PERMISSION"`
Size bool `short:"s" help:"Show file size" default:"true" negatable:"" env:"GUM_FILE_SIZE"`
File bool `help:"Allow files selection" default:"true" env:"GUM_FILE_FILE"`
Directory bool `help:"Allow directories selection" default:"false" env:"GUM_FILE_DIRECTORY"`
ShowHelp bool `help:"Show help key binds" negatable:"" default:"true" env:"GUM_FILE_SHOW_HELP"`
Timeout time.Duration `help:"Timeout until command aborts without a selection" default:"0s" env:"GUM_FILE_TIMEOUT"`
Header string `help:"Header value" default:"" env:"GUM_FILE_HEADER"`
Height int `help:"Maximum number of files to display" default:"10" env:"GUM_FILE_HEIGHT"`

    CursorStyle      style.Styles `embed:"" prefix:"cursor." help:"The cursor style" set:"defaultForeground=212" envprefix:"GUM_FILE_CURSOR_"`
    SymlinkStyle     style.Styles `embed:"" prefix:"symlink." help:"The style to use for symlinks" set:"defaultForeground=36" envprefix:"GUM_FILE_SYMLINK_"`
    DirectoryStyle   style.Styles `embed:"" prefix:"directory." help:"The style to use for directories" set:"defaultForeground=99" envprefix:"GUM_FILE_DIRECTORY_"`
    FileStyle        style.Styles `embed:"" prefix:"file." help:"The style to use for files" envprefix:"GUM_FILE_FILE_"`
    PermissionsStyle style.Styles `embed:"" prefix:"permissions." help:"The style to use for permissions" set:"defaultForeground=244" envprefix:"GUM_FILE_PERMISSIONS_"`
    SelectedStyle    style.Styles `embed:"" prefix:"selected." help:"The style to use for the selected item" set:"defaultBold=true" set:"defaultForeground=212" envprefix:"GUM_FILE_SELECTED_"`                    //nolint:staticcheck
    FileSizeStyle    style.Styles `embed:"" prefix:"file-size." help:"The style to use for file sizes" set:"defaultWidth=8" set:"defaultAlign=right" set:"defaultForeground=240"  envprefix:"GUM_FILE_FILE_SIZE_"` //nolint:staticcheck
    HeaderStyle      style.Styles `embed:"" prefix:"header." set:"defaultForeground=99" envprefix:"GUM_FILE_HEADER_"`

}

================================================
File: filter/command.go
================================================
package filter

import (
"errors"
"fmt"
"os"
"slices"
"strings"

    "github.com/charmbracelet/bubbles/help"
    "github.com/charmbracelet/bubbles/textinput"
    "github.com/charmbracelet/bubbles/viewport"
    tea "github.com/charmbracelet/bubbletea"
    "github.com/charmbracelet/gum/internal/files"
    "github.com/charmbracelet/gum/internal/stdin"
    "github.com/charmbracelet/gum/internal/timeout"
    "github.com/charmbracelet/gum/internal/tty"
    "github.com/charmbracelet/x/ansi"
    "github.com/sahilm/fuzzy"

)

// Run provides a shell script interface for filtering through options, powered
// by the textinput bubble.
func (o Options) Run() error {
i := textinput.New()
i.Focus()

    i.Prompt = o.Prompt
    i.PromptStyle = o.PromptStyle.ToLipgloss()
    i.PlaceholderStyle = o.PlaceholderStyle.ToLipgloss()
    i.Placeholder = o.Placeholder
    i.Width = o.Width

    v := viewport.New(o.Width, o.Height)

    if len(o.Options) == 0 {
    	if input, _ := stdin.Read(stdin.StripANSI(o.StripANSI)); input != "" {
    		o.Options = strings.Split(input, o.InputDelimiter)
    	} else {
    		o.Options = files.List()
    	}
    }

    if len(o.Options) == 0 {
    	return errors.New("no options provided, see `gum filter --help`")
    }

    ctx, cancel := timeout.Context(o.Timeout)
    defer cancel()

    options := []tea.ProgramOption{
    	tea.WithOutput(os.Stderr),
    	tea.WithReportFocus(),
    	tea.WithContext(ctx),
    }
    if o.Height == 0 {
    	options = append(options, tea.WithAltScreen())
    }

    var matches []fuzzy.Match
    if o.Value != "" {
    	i.SetValue(o.Value)
    }

    choices := map[string]string{}
    filteringChoices := []string{}
    for _, opt := range o.Options {
    	s := ansi.Strip(opt)
    	choices[s] = opt
    	filteringChoices = append(filteringChoices, s)
    }
    switch {
    case o.Value != "" && o.Fuzzy:
    	matches = fuzzy.Find(o.Value, filteringChoices)
    case o.Value != "" && !o.Fuzzy:
    	matches = exactMatches(o.Value, filteringChoices)
    default:
    	matches = matchAll(filteringChoices)
    }

    if o.NoLimit {
    	o.Limit = len(o.Options)
    }

    if o.SelectIfOne && len(matches) == 1 {
    	tty.Println(matches[0].Str)
    	return nil
    }

    km := defaultKeymap()
    if o.NoLimit || o.Limit > 1 {
    	km.Toggle.SetEnabled(true)
    	km.ToggleAndPrevious.SetEnabled(true)
    	km.ToggleAndNext.SetEnabled(true)
    	km.ToggleAll.SetEnabled(true)
    }

    m := model{
    	choices:               choices,
    	filteringChoices:      filteringChoices,
    	indicator:             o.Indicator,
    	matches:               matches,
    	header:                o.Header,
    	textinput:             i,
    	viewport:              &v,
    	indicatorStyle:        o.IndicatorStyle.ToLipgloss(),
    	selectedPrefixStyle:   o.SelectedPrefixStyle.ToLipgloss(),
    	selectedPrefix:        o.SelectedPrefix,
    	unselectedPrefixStyle: o.UnselectedPrefixStyle.ToLipgloss(),
    	unselectedPrefix:      o.UnselectedPrefix,
    	matchStyle:            o.MatchStyle.ToLipgloss(),
    	headerStyle:           o.HeaderStyle.ToLipgloss(),
    	textStyle:             o.TextStyle.ToLipgloss(),
    	cursorTextStyle:       o.CursorTextStyle.ToLipgloss(),
    	height:                o.Height,
    	selected:              make(map[string]struct{}),
    	limit:                 o.Limit,
    	reverse:               o.Reverse,
    	fuzzy:                 o.Fuzzy,
    	sort:                  o.Sort && o.FuzzySort,
    	strict:                o.Strict,
    	showHelp:              o.ShowHelp,
    	keymap:                km,
    	help:                  help.New(),
    }

    isSelectAll := len(o.Selected) == 1 && o.Selected[0] == "*"
    currentSelected := 0
    if len(o.Selected) > 0 {
    	for i, option := range matches {
    		if currentSelected >= o.Limit || (!isSelectAll && !slices.Contains(o.Selected, option.Str)) {
    			continue
    		}
    		if o.Limit == 1 {
    			m.cursor = i
    			m.selected[option.Str] = struct{}{}
    		} else {
    			currentSelected++
    			m.selected[option.Str] = struct{}{}
    		}
    	}
    }

    tm, err := tea.NewProgram(m, options...).Run()
    if err != nil {
    	return fmt.Errorf("unable to run filter: %w", err)
    }

    m = tm.(model)
    if !m.submitted {
    	return errors.New("nothing selected")
    }

    // allSelections contains values only if limit is greater
    // than 1 or if flag --no-limit is passed, hence there is
    // no need to further checks
    if len(m.selected) > 0 {
    	o.checkSelected(m)
    } else if len(m.matches) > m.cursor && m.cursor >= 0 {
    	tty.Println(m.matches[m.cursor].Str)
    }

    return nil

}

func (o Options) checkSelected(m model) {
out := []string{}
for k := range m.selected {
out = append(out, k)
}
tty.Println(strings.Join(out, o.OutputDelimiter))
}

================================================
File: filter/filter.go
================================================
// Package filter provides a fuzzy searching text input to allow filtering a
// list of options to select one option.
//
// By default it will list all the files (recursively) in the current directory
// for the user to choose one, but the script (or user) can provide different
// new-line separated options to choose from.
//
// I.e. let's pick from a list of gum flavors:
//
// $ cat flavors.text | gum filter
package filter

import (
"strings"

    "github.com/charmbracelet/bubbles/help"
    "github.com/charmbracelet/bubbles/key"
    "github.com/charmbracelet/bubbles/textinput"
    "github.com/charmbracelet/bubbles/viewport"
    tea "github.com/charmbracelet/bubbletea"
    "github.com/charmbracelet/lipgloss"
    "github.com/rivo/uniseg"
    "github.com/sahilm/fuzzy"

)

func defaultKeymap() keymap {
return keymap{
Down: key.NewBinding(
key.WithKeys("down", "ctrl+j", "ctrl+n"),
),
Up: key.NewBinding(
key.WithKeys("up", "ctrl+k", "ctrl+p"),
),
NDown: key.NewBinding(
key.WithKeys("j"),
),
NUp: key.NewBinding(
key.WithKeys("k"),
),
Home: key.NewBinding(
key.WithKeys("g", "home"),
),
End: key.NewBinding(
key.WithKeys("G", "end"),
),
ToggleAndNext: key.NewBinding(
key.WithKeys("tab"),
key.WithHelp("tab", "toggle"),
key.WithDisabled(),
),
ToggleAndPrevious: key.NewBinding(
key.WithKeys("shift+tab"),
key.WithHelp("shift+tab", "toggle"),
key.WithDisabled(),
),
Toggle: key.NewBinding(
key.WithKeys("ctrl+@"),
key.WithHelp("ctrl+@", "toggle"),
key.WithDisabled(),
),
ToggleAll: key.NewBinding(
key.WithKeys("ctrl+a"),
key.WithHelp("ctrl+a", "select all"),
key.WithDisabled(),
),
FocusInSearch: key.NewBinding(
key.WithKeys("/"),
key.WithHelp("/", "search"),
),
FocusOutSearch: key.NewBinding(
key.WithKeys("esc"),
key.WithHelp("esc", "blur search"),
),
Quit: key.NewBinding(
key.WithKeys("esc"),
key.WithHelp("esc", "quit"),
),
Abort: key.NewBinding(
key.WithKeys("ctrl+c"),
key.WithHelp("ctrl+c", "abort"),
),
Submit: key.NewBinding(
key.WithKeys("enter", "ctrl+q"),
key.WithHelp("enter", "submit"),
),
}
}

type keymap struct {
FocusInSearch,
FocusOutSearch,
Down,
Up,
NDown,
NUp,
Home,
End,
ToggleAndNext,
ToggleAndPrevious,
ToggleAll,
Toggle,
Abort,
Quit,
Submit key.Binding
}

// FullHelp implements help.KeyMap.
func (k keymap) FullHelp() [][]key.Binding { return nil }

// ShortHelp implements help.KeyMap.
func (k keymap) ShortHelp() []key.Binding {
return []key.Binding{
key.NewBinding(
key.WithKeys("up", "down"),
key.WithHelp("↓↑", "navigate"),
),
k.FocusInSearch,
k.FocusOutSearch,
k.ToggleAndNext,
k.ToggleAll,
k.Submit,
}
}

type model struct {
textinput textinput.Model
viewport \*viewport.Model
choices map[string]string
filteringChoices []string
matches []fuzzy.Match
cursor int
header string
selected map[string]struct{}
limit int
numSelected int
indicator string
selectedPrefix string
unselectedPrefix string
height int
quitting bool
headerStyle lipgloss.Style
matchStyle lipgloss.Style
textStyle lipgloss.Style
cursorTextStyle lipgloss.Style
indicatorStyle lipgloss.Style
selectedPrefixStyle lipgloss.Style
unselectedPrefixStyle lipgloss.Style
reverse bool
fuzzy bool
sort bool
showHelp bool
keymap keymap
help help.Model
strict bool
submitted bool
}

func (m model) Init() tea.Cmd { return textinput.Blink }

func (m model) View() string {
if m.quitting {
return ""
}

    var s strings.Builder
    var lineTextStyle lipgloss.Style

    // For reverse layout, if the number of matches is less than the viewport
    // height, we need to offset the matches so that the first match is at the
    // bottom edge of the viewport instead of in the middle.
    if m.reverse && len(m.matches) < m.viewport.Height {
    	s.WriteString(strings.Repeat("\n", m.viewport.Height-len(m.matches)))
    }

    // Since there are matches, display them so that the user can see, in real
    // time, what they are searching for.
    last := len(m.matches) - 1
    for i := range m.matches {
    	// For reverse layout, the matches are displayed in reverse order.
    	if m.reverse {
    		i = last - i
    	}
    	match := m.matches[i]

    	// If this is the current selected index, we add a small indicator to
    	// represent it. Otherwise, simply pad the string.
    	// The line's text style is set depending on whether or not the cursor
    	// points to this line.
    	if i == m.cursor {
    		s.WriteString(m.indicatorStyle.Render(m.indicator))
    		lineTextStyle = m.cursorTextStyle
    	} else {
    		s.WriteString(strings.Repeat(" ", lipgloss.Width(m.indicator)))
    		lineTextStyle = m.textStyle
    	}

    	// If there are multiple selections mark them, otherwise leave an empty space
    	if _, ok := m.selected[match.Str]; ok {
    		s.WriteString(m.selectedPrefixStyle.Render(m.selectedPrefix))
    	} else if m.limit > 1 {
    		s.WriteString(m.unselectedPrefixStyle.Render(m.unselectedPrefix))
    	} else {
    		s.WriteString(" ")
    	}

    	styledOption := m.choices[match.Str]
    	if len(match.MatchedIndexes) == 0 {
    		// No matches, just render the text.
    		s.WriteString(lineTextStyle.Render(styledOption))
    		s.WriteRune('\n')
    		continue
    	}

    	var ranges []lipgloss.Range
    	for _, rng := range matchedRanges(match.MatchedIndexes) {
    		// ansi.Cut is grapheme and ansi sequence aware, we match against a ansi.Stripped string, but we might still have graphemes.
    		// all that to say that rng is byte positions, but we need to pass it down to ansi.Cut as char positions.
    		// so we need to adjust it here:
    		start, stop := bytePosToVisibleCharPos(match.Str, rng)
    		ranges = append(ranges, lipgloss.NewRange(start, stop+1, m.matchStyle))
    	}

    	s.WriteString(lineTextStyle.Render(lipgloss.StyleRanges(styledOption, ranges...)))

    	// We have finished displaying the match with all of it's matched
    	// characters highlighted and the rest filled in.
    	// Move on to the next match.
    	s.WriteRune('\n')
    }

    m.viewport.SetContent(s.String())

    help := ""
    if m.showHelp {
    	help = m.helpView()
    }

    // View the input and the filtered choices
    header := m.headerStyle.Render(m.header)
    if m.reverse {
    	view := m.viewport.View() + "\n" + m.textinput.View()
    	if m.showHelp {
    		view += help
    	}
    	if m.header != "" {
    		return lipgloss.JoinVertical(lipgloss.Left, view, header)
    	}

    	return view
    }

    view := m.textinput.View() + "\n" + m.viewport.View()
    if m.showHelp {
    	view += help
    }
    if m.header != "" {
    	return lipgloss.JoinVertical(lipgloss.Left, header, view)
    }
    return view

}

func (m model) helpView() string {
return "\n\n" + m.help.View(m.keymap)
}

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
var cmd, icmd tea.Cmd
m.textinput, icmd = m.textinput.Update(msg)
switch msg := msg.(type) {
case tea.WindowSizeMsg:
if m.height == 0 || m.height > msg.Height {
m.viewport.Height = msg.Height - lipgloss.Height(m.textinput.View())
}
// Include the header in the height calculation.
if m.header != "" {
m.viewport.Height = m.viewport.Height - lipgloss.Height(m.headerStyle.Render(m.header))
}
// Include the help in the total height calculation.
if m.showHelp {
m.viewport.Height = m.viewport.Height - lipgloss.Height(m.helpView())
}
m.viewport.Width = msg.Width
if m.reverse {
m.viewport.YOffset = clamp(0, len(m.matches), len(m.matches)-m.viewport.Height)
}
case tea.KeyMsg:
km := m.keymap
switch {
case key.Matches(msg, km.FocusInSearch):
m.textinput.Focus()
case key.Matches(msg, km.FocusOutSearch):
m.textinput.Blur()
case key.Matches(msg, km.Quit):
m.quitting = true
return m, tea.Quit
case key.Matches(msg, km.Abort):
m.quitting = true
return m, tea.Interrupt
case key.Matches(msg, km.Submit):
m.quitting = true
m.submitted = true
return m, tea.Quit
case key.Matches(msg, km.Down, km.NDown):
m.CursorDown()
case key.Matches(msg, km.Up, km.NUp):
m.CursorUp()
case key.Matches(msg, km.Home):
m.cursor = 0
m.viewport.GotoTop()
case key.Matches(msg, km.End):
m.cursor = len(m.choices) - 1
m.viewport.GotoBottom()
case key.Matches(msg, km.ToggleAndNext):
if m.limit == 1 {
break // no op
}
m.ToggleSelection()
m.CursorDown()
case key.Matches(msg, km.ToggleAndPrevious):
if m.limit == 1 {
break // no op
}
m.ToggleSelection()
m.CursorUp()
case key.Matches(msg, km.Toggle):
if m.limit == 1 {
break // no op
}
m.ToggleSelection()
case key.Matches(msg, km.ToggleAll):
if m.limit <= 1 {
break
}
if m.numSelected < len(m.matches) && m.numSelected < m.limit {
m = m.selectAll()
} else {
m = m.deselectAll()
}
default:
// yOffsetFromBottom is the number of lines from the bottom of the
// list to the top of the viewport. This is used to keep the viewport
// at a constant position when the number of matches are reduced
// in the reverse layout.
var yOffsetFromBottom int
if m.reverse {
yOffsetFromBottom = max(0, len(m.matches)-m.viewport.YOffset)
}

    		// A character was entered, this likely means that the text input has
    		// changed. This suggests that the matches are outdated, so update them.
    		var choices []string
    		if !m.strict {
    			choices = append(choices, m.textinput.Value())
    		}
    		choices = append(choices, m.filteringChoices...)
    		if m.fuzzy {
    			if m.sort {
    				m.matches = fuzzy.Find(m.textinput.Value(), choices)
    			} else {
    				m.matches = fuzzy.FindNoSort(m.textinput.Value(), choices)
    			}
    		} else {
    			m.matches = exactMatches(m.textinput.Value(), choices)
    		}

    		// If the search field is empty, let's not display the matches
    		// (none), but rather display all possible choices.
    		if m.textinput.Value() == "" {
    			m.matches = matchAll(m.filteringChoices)
    		}

    		// For reverse layout, we need to offset the viewport so that the
    		// it remains at a constant position relative to the cursor.
    		if m.reverse {
    			maxYOffset := max(0, len(m.matches)-m.viewport.Height)
    			m.viewport.YOffset = clamp(0, maxYOffset, len(m.matches)-yOffsetFromBottom)
    		}
    	}
    }

    m.keymap.FocusInSearch.SetEnabled(!m.textinput.Focused())
    m.keymap.FocusOutSearch.SetEnabled(m.textinput.Focused())
    m.keymap.NUp.SetEnabled(!m.textinput.Focused())
    m.keymap.NDown.SetEnabled(!m.textinput.Focused())
    m.keymap.Home.SetEnabled(!m.textinput.Focused())
    m.keymap.End.SetEnabled(!m.textinput.Focused())

    // It's possible that filtering items have caused fewer matches. So, ensure
    // that the selected index is within the bounds of the number of matches.
    m.cursor = clamp(0, len(m.matches)-1, m.cursor)
    return m, tea.Batch(cmd, icmd)

}

func (m \*model) CursorUp() {
if len(m.matches) == 0 {
return
}
if m.reverse { //nolint:nestif
m.cursor = (m.cursor + 1) % len(m.matches)
if len(m.matches)-m.cursor <= m.viewport.YOffset {
m.viewport.LineUp(1)
}
if len(m.matches)-m.cursor > m.viewport.Height+m.viewport.YOffset {
m.viewport.SetYOffset(len(m.matches) - m.viewport.Height)
}
} else {
m.cursor = (m.cursor - 1 + len(m.matches)) % len(m.matches)
if m.cursor < m.viewport.YOffset {
m.viewport.LineUp(1)
}
if m.cursor >= m.viewport.YOffset+m.viewport.Height {
m.viewport.SetYOffset(len(m.matches) - m.viewport.Height)
}
}
}

func (m \*model) CursorDown() {
if len(m.matches) == 0 {
return
}
if m.reverse { //nolint:nestif
m.cursor = (m.cursor - 1 + len(m.matches)) % len(m.matches)
if len(m.matches)-m.cursor > m.viewport.Height+m.viewport.YOffset {
m.viewport.LineDown(1)
}
if len(m.matches)-m.cursor <= m.viewport.YOffset {
m.viewport.GotoTop()
}
} else {
m.cursor = (m.cursor + 1) % len(m.matches)
if m.cursor >= m.viewport.YOffset+m.viewport.Height {
m.viewport.LineDown(1)
}
if m.cursor < m.viewport.YOffset {
m.viewport.GotoTop()
}
}
}

func (m \*model) ToggleSelection() {
if \_, ok := m.selected[m.matches[m.cursor].Str]; ok {
delete(m.selected, m.matches[m.cursor].Str)
m.numSelected--
} else if m.numSelected < m.limit {
m.selected[m.matches[m.cursor].Str] = struct{}{}
m.numSelected++
}
}

func (m model) selectAll() model {
for i := range m.matches {
if m.numSelected >= m.limit {
break // do not exceed given limit
}
if \_, ok := m.selected[m.matches[i].Str]; ok {
continue
}
m.selected[m.matches[i].Str] = struct{}{}
m.numSelected++
}
return m
}

func (m model) deselectAll() model {
m.selected = make(map[string]struct{})
m.numSelected = 0
return m
}

func matchAll(options []string) []fuzzy.Match {
matches := make([]fuzzy.Match, len(options))
for i, option := range options {
matches[i] = fuzzy.Match{Str: option}
}
return matches
}

func exactMatches(search string, choices []string) []fuzzy.Match {
matches := fuzzy.Matches{}
for i, choice := range choices {
search = strings.ToLower(search)
matchedString := strings.ToLower(choice)

    	index := strings.Index(matchedString, search)
    	if index >= 0 {
    		matchedIndexes := []int{}
    		for s := range search {
    			matchedIndexes = append(matchedIndexes, index+s)
    		}
    		matches = append(matches, fuzzy.Match{
    			Str:            choice,
    			Index:          i,
    			MatchedIndexes: matchedIndexes,
    		})
    	}
    }

    return matches

}

func clamp(low, high, val int) int {
if val < low {
return low
}
if val > high {
return high
}
return val
}

func matchedRanges(in []int) [][2]int {
if len(in) == 0 {
return [][2]int{}
}
current := [2]int{in[0], in[0]}
if len(in) == 1 {
return [][2]int{current}
}
var out [][2]int
for i := 1; i < len(in); i++ {
if in[i] == current[1]+1 {
current[1] = in[i]
} else {
out = append(out, current)
current = [2]int{in[i], in[i]}
}
}
out = append(out, current)
return out
}

func bytePosToVisibleCharPos(str string, rng [2]int) (int, int) {
bytePos, byteStart, byteStop := 0, rng[0], rng[1]
pos, start, stop := 0, 0, 0
gr := uniseg.NewGraphemes(str)
for byteStart > bytePos {
if !gr.Next() {
break
}
bytePos += len(gr.Str())
pos += max(1, gr.Width())
}
start = pos
for byteStop > bytePos {
if !gr.Next() {
break
}
bytePos += len(gr.Str())
pos += max(1, gr.Width())
}
stop = pos
return start, stop
}

================================================
File: filter/filter_test.go
================================================
package filter

import (
"reflect"
"testing"

    "github.com/charmbracelet/x/ansi"

)

func TestMatchedRanges(t *testing.T) {
for name, tt := range map[string]struct {
in []int
out [][2]int
}{
"empty": {
in: []int{},
out: [][2]int{},
},
"one char": {
in: []int{1},
out: [][2]int{{1, 1}},
},
"2 char range": {
in: []int{1, 2},
out: [][2]int{{1, 2}},
},
"multiple char range": {
in: []int{1, 2, 3, 4, 5, 6},
out: [][2]int{{1, 6}},
},
"multiple char ranges": {
in: []int{1, 2, 3, 5, 6, 10, 11, 12, 13, 23, 24, 40, 42, 43, 45, 52},
out: [][2]int{{1, 3}, {5, 6}, {10, 13}, {23, 24}, {40, 40}, {42, 43}, {45, 45}, {52, 52}},
},
} {
t.Run(name, func(t *testing.T) {
match := matchedRanges(tt.in)
if !reflect.DeepEqual(match, tt.out) {
t.Errorf("expected %v, got %v", tt.out, match)
}
})
}
}

func TestByteToChar(t \*testing.T) {
stStr := "\x1b[90m\ue615\x1b[39m \x1b[3m\x1b[32mDow\x1b[0m\x1b[90m\x1b[39m\x1b[3wnloads"
str := " Downloads"
rng := [2]int{4, 7}
expect := "Dow"

    if got := str[rng[0]:rng[1]]; got != expect {
    	t.Errorf("expected %q, got %q", expect, got)
    }

    start, stop := bytePosToVisibleCharPos(str, rng)
    if got := ansi.Strip(ansi.Cut(stStr, start, stop)); got != expect {
    	t.Errorf("expected %+q, got %+q", expect, got)
    }

}

================================================
File: filter/options.go
================================================
package filter

import (
"time"

    "github.com/charmbracelet/gum/style"

)

// Options is the customization options for the filter command.
type Options struct {
Options []string `arg:"" optional:"" help:"Options to filter."`

    Indicator             string        `help:"Character for selection" default:"•" env:"GUM_FILTER_INDICATOR"`
    IndicatorStyle        style.Styles  `embed:"" prefix:"indicator." set:"defaultForeground=212" envprefix:"GUM_FILTER_INDICATOR_"`
    Limit                 int           `help:"Maximum number of options to pick" default:"1" group:"Selection"`
    NoLimit               bool          `help:"Pick unlimited number of options (ignores limit)" group:"Selection"`
    SelectIfOne           bool          `help:"Select the given option if there is only one" group:"Selection"`
    Selected              []string      `help:"Options that should start as selected (selects all if given *)" default:"" env:"GUM_FILTER_SELECTED"`
    ShowHelp              bool          `help:"Show help keybinds" default:"true" negatable:"" env:"GUM_FILTER_SHOW_HELP"`
    Strict                bool          `help:"Only returns if anything matched. Otherwise return Filter" negatable:"" default:"true" group:"Selection"`
    SelectedPrefix        string        `help:"Character to indicate selected items (hidden if limit is 1)" default:" ◉ " env:"GUM_FILTER_SELECTED_PREFIX"`
    SelectedPrefixStyle   style.Styles  `embed:"" prefix:"selected-indicator." set:"defaultForeground=212" envprefix:"GUM_FILTER_SELECTED_PREFIX_"`
    UnselectedPrefix      string        `help:"Character to indicate unselected items (hidden if limit is 1)" default:" ○ " env:"GUM_FILTER_UNSELECTED_PREFIX"`
    UnselectedPrefixStyle style.Styles  `embed:"" prefix:"unselected-prefix." set:"defaultForeground=240" envprefix:"GUM_FILTER_UNSELECTED_PREFIX_"`
    HeaderStyle           style.Styles  `embed:"" prefix:"header." set:"defaultForeground=99" envprefix:"GUM_FILTER_HEADER_"`
    Header                string        `help:"Header value" default:"" env:"GUM_FILTER_HEADER"`
    TextStyle             style.Styles  `embed:"" prefix:"text." envprefix:"GUM_FILTER_TEXT_"`
    CursorTextStyle       style.Styles  `embed:"" prefix:"cursor-text." envprefix:"GUM_FILTER_CURSOR_TEXT_"`
    MatchStyle            style.Styles  `embed:"" prefix:"match." set:"defaultForeground=212" envprefix:"GUM_FILTER_MATCH_"`
    Placeholder           string        `help:"Placeholder value" default:"Filter..." env:"GUM_FILTER_PLACEHOLDER"`
    Prompt                string        `help:"Prompt to display" default:"> " env:"GUM_FILTER_PROMPT"`
    PromptStyle           style.Styles  `embed:"" prefix:"prompt." set:"defaultForeground=240" envprefix:"GUM_FILTER_PROMPT_"`
    PlaceholderStyle      style.Styles  `embed:"" prefix:"placeholder." set:"defaultForeground=240" envprefix:"GUM_FILTER_PLACEHOLDER_"`
    Width                 int           `help:"Input width" default:"0" env:"GUM_FILTER_WIDTH"`
    Height                int           `help:"Input height" default:"0" env:"GUM_FILTER_HEIGHT"`
    Value                 string        `help:"Initial filter value" default:"" env:"GUM_FILTER_VALUE"`
    Reverse               bool          `help:"Display from the bottom of the screen" env:"GUM_FILTER_REVERSE"`
    Fuzzy                 bool          `help:"Enable fuzzy matching; otherwise match from start of word" default:"true" env:"GUM_FILTER_FUZZY" negatable:""`
    FuzzySort             bool          `help:"Sort fuzzy results by their scores" default:"true" env:"GUM_FILTER_FUZZY_SORT" negatable:""`
    Timeout               time.Duration `help:"Timeout until filter command aborts" default:"0s" env:"GUM_FILTER_TIMEOUT"`
    InputDelimiter        string        `help:"Option delimiter when reading from STDIN" default:"\n" env:"GUM_FILTER_INPUT_DELIMITER"`
    OutputDelimiter       string        `help:"Option delimiter when writing to STDOUT" default:"\n" env:"GUM_FILTER_OUTPUT_DELIMITER"`
    StripANSI             bool          `help:"Strip ANSI sequences when reading from STDIN" default:"true" negatable:"" env:"GUM_FILTER_STRIP_ANSI"`

    // Deprecated: use [FuzzySort]. This will be removed at some point.
    Sort bool `help:"Sort fuzzy results by their scores" default:"true" env:"GUM_FILTER_FUZZY_SORT" negatable:"" hidden:""`

}

================================================
File: format/README.md
================================================

# Gum Format

Gum format allows you to format different text into human readable output.

Four different parse-able formats exist:

1. [Markdown](#markdown)
2. [Code](#code)
3. [Template](#template)
4. [Emoji](#emoji)

## Markdown

Render any input as markdown text. This uses
[Glamour](https://github.com/charmbracelet/glamour) behind the scenes.

You can pass input as lines directly as arguments to the command invocation or
pass markdown over `stdin`.

```bash
gum format --type markdown < README.md
# Or, directly as arguments (useful for quick lists)
gum format --type markdown -- "# Gum Formats" "- Markdown" "- Code" "- Template" "- Emoji"
```

## Code

Render any code snippet with syntax highlighting.
[Glamour](https://github.com/charmbracelet/glamour), which uses
[Chroma](https://github.com/alecthomas/chroma) under the hood, handles styling.

Similarly to the `markdown` format, `code` can take input over `stdin`.

```bash
cat options.go | gum format --type code
```

## Template

Render styled input from a string template. Templating is handled by
[Termenv](https://github.com/muesli/termenv).

```bash
gum format --type template '{{ Bold "Tasty" }} {{ Italic "Bubble" }} {{ Color "99" "0" " Gum " }}'
# Or, via stdin
echo '{{ Bold "Tasty" }} {{ Italic "Bubble" }} {{ Color "99" "0" " Gum " }}' | gum format --type template
```

## Emoji

Parse and render emojis from their matching `:name:`s. Powered by
[Glamour](https://github.com/charmbracelet/glamour) and [Goldmark
Emoji](https://github.com/yuin/goldmark-emoji)

```bash
gum format --type emoji 'I :heart: Bubble Gum :candy:'
# You know the drill, also via stdin
echo 'I :heart: Bubble Gum :candy:' | gum format --type emoji
```

## Tables

Tables are rendered using [Glamour](https://github.com/charmbracelet/glamour).

| Bubble Gum Flavor | Price |
| ----------------- | ----- |
| Strawberry        | $0.99 |
| Cherry            | $0.50 |
| Banana            | $0.75 |
| Orange            | $0.25 |
| Lemon             | $0.50 |
| Lime              | $0.50 |
| Grape             | $0.50 |
| Watermelon        | $0.50 |
| Pineapple         | $0.50 |
| Blueberry         | $0.50 |
| Raspberry         | $0.50 |
| Cranberry         | $0.50 |
| Peach             | $0.50 |
| Apple             | $0.50 |
| Mango             | $0.50 |
| Pomegranate       | $0.50 |
| Coconut           | $0.50 |
| Cinnamon          | $0.50 |

================================================
File: format/command.go
================================================
// Package format allows you to render formatted text from the command line.
//
// It supports the following types:
//
// 1. Markdown
// 2. Code
// 3. Emoji
// 4. Template
//
// For more information, see the format/README.md file.
package format

import (
"fmt"
"strings"

    "github.com/charmbracelet/gum/internal/stdin"

)

// Run runs the format command.
func (o Options) Run() error {
var input, output string
var err error
if len(o.Template) > 0 {
input = strings.Join(o.Template, "\n")
} else {
input, \_ = stdin.Read(stdin.StripANSI(o.StripANSI))
}

    switch o.Type {
    case "code":
    	output, err = code(input, o.Language)
    case "emoji":
    	output, err = emoji(input)
    case "template":
    	output, err = template(input)
    default:
    	output, err = markdown(input, o.Theme)
    }
    if err != nil {
    	return err
    }

    fmt.Print(output)
    return nil

}

================================================
File: format/formats.go
================================================
package format

import (
"bytes"
"fmt"
tpl "text/template"

    "github.com/charmbracelet/glamour"
    "github.com/muesli/termenv"

)

func code(input, language string) (string, error) {
renderer, err := glamour.NewTermRenderer(
glamour.WithAutoStyle(),
glamour.WithWordWrap(0),
)
if err != nil {
return "", fmt.Errorf("unable to create renderer: %w", err)
}
output, err := renderer.Render(fmt.Sprintf("`%s\n%s\n`", language, input))
if err != nil {
return "", fmt.Errorf("unable to render: %w", err)
}
return output, nil
}

func emoji(input string) (string, error) {
renderer, err := glamour.NewTermRenderer(
glamour.WithEmoji(),
)
if err != nil {
return "", fmt.Errorf("unable to create renderer: %w", err)
}
output, err := renderer.Render(input)
if err != nil {
return "", fmt.Errorf("unable to render: %w", err)
}
return output, nil
}

func markdown(input string, theme string) (string, error) {
renderer, err := glamour.NewTermRenderer(
glamour.WithStylePath(theme),
glamour.WithWordWrap(0),
)
if err != nil {
return "", fmt.Errorf("unable to render: %w", err)
}
output, err := renderer.Render(input)
if err != nil {
return "", fmt.Errorf("unable to render: %w", err)
}
return output, nil
}

func template(input string) (string, error) {
f := termenv.TemplateFuncs(termenv.ANSI256)
t, err := tpl.New("tpl").Funcs(f).Parse(input)
if err != nil {
return "", fmt.Errorf("unable to parse template: %w", err)
}

    var buf bytes.Buffer
    err = t.Execute(&buf, nil)
    return buf.String(), err

}

================================================
File: format/options.go
================================================
package format

// Options is customization options for the format command.
type Options struct {
Template []string `arg:"" optional:"" help:"Template string to format (can also be provided via stdin)"`
Theme string `help:"Glamour theme to use for markdown formatting" default:"pink" env:"GUM_FORMAT_THEME"`
Language string `help:"Programming language to parse code" short:"l" default:"" env:"GUM_FORMAT_LANGUAGE"`

    StripANSI bool `help:"Strip ANSI sequences when reading from STDIN" default:"true" negatable:"" env:"GUM_FORMAT_STRIP_ANSI"`

    Type string `help:"Format to use (markdown,template,code,emoji)" enum:"markdown,template,code,emoji" short:"t" default:"markdown" env:"GUM_FORMAT_TYPE"`

}

================================================
File: input/command.go
================================================
package input

import (
"errors"
"fmt"
"os"

    "github.com/charmbracelet/bubbles/help"
    "github.com/charmbracelet/bubbles/textinput"
    tea "github.com/charmbracelet/bubbletea"
    "github.com/charmbracelet/gum/cursor"
    "github.com/charmbracelet/gum/internal/stdin"
    "github.com/charmbracelet/gum/internal/timeout"

)

// Run provides a shell script interface for the text input bubble.
// https://github.com/charmbracelet/bubbles/textinput
func (o Options) Run() error {
if o.Value == "" {
if in, \_ := stdin.Read(stdin.StripANSI(o.StripANSI)); in != "" {
o.Value = in
}
}

    i := textinput.New()
    if o.Value != "" {
    	i.SetValue(o.Value)
    } else if in, _ := stdin.Read(stdin.StripANSI(o.StripANSI)); in != "" {
    	i.SetValue(in)
    }
    i.Focus()
    i.Prompt = o.Prompt
    i.Placeholder = o.Placeholder
    i.Width = o.Width
    i.PromptStyle = o.PromptStyle.ToLipgloss()
    i.PlaceholderStyle = o.PlaceholderStyle.ToLipgloss()
    i.Cursor.Style = o.CursorStyle.ToLipgloss()
    i.Cursor.SetMode(cursor.Modes[o.CursorMode])
    i.CharLimit = o.CharLimit

    if o.Password {
    	i.EchoMode = textinput.EchoPassword
    	i.EchoCharacter = '•'
    }

    m := model{
    	textinput:   i,
    	header:      o.Header,
    	headerStyle: o.HeaderStyle.ToLipgloss(),
    	autoWidth:   o.Width < 1,
    	showHelp:    o.ShowHelp,
    	help:        help.New(),
    	keymap:      defaultKeymap(),
    }

    ctx, cancel := timeout.Context(o.Timeout)
    defer cancel()

    p := tea.NewProgram(
    	m,
    	tea.WithOutput(os.Stderr),
    	tea.WithReportFocus(),
    	tea.WithContext(ctx),
    )
    tm, err := p.Run()
    if err != nil {
    	return fmt.Errorf("failed to run input: %w", err)
    }

    m = tm.(model)
    if !m.submitted {
    	return errors.New("not submitted")
    }
    fmt.Println(m.textinput.Value())
    return nil

}

================================================
File: input/input.go
================================================
// Package input provides a shell script interface for the text input bubble.
// https://github.com/charmbracelet/bubbles/tree/master/textinput
//
// It can be used to prompt the user for some input. The text the user entered
// will be sent to stdout.
//
// $ gum input --placeholder "What's your favorite gum?" > answer.text
package input

import (
"github.com/charmbracelet/bubbles/help"
"github.com/charmbracelet/bubbles/key"
"github.com/charmbracelet/bubbles/textinput"
tea "github.com/charmbracelet/bubbletea"
"github.com/charmbracelet/lipgloss"
)

type keymap textinput.KeyMap

func defaultKeymap() keymap {
k := textinput.DefaultKeyMap
return keymap(k)
}

// FullHelp implements help.KeyMap.
func (k keymap) FullHelp() [][]key.Binding { return nil }

// ShortHelp implements help.KeyMap.
func (k keymap) ShortHelp() []key.Binding {
return []key.Binding{
key.NewBinding(
key.WithKeys("enter"),
key.WithHelp("enter", "submit"),
),
}
}

type model struct {
autoWidth bool
header string
headerStyle lipgloss.Style
textinput textinput.Model
quitting bool
submitted bool
showHelp bool
help help.Model
keymap keymap
}

func (m model) Init() tea.Cmd { return textinput.Blink }

func (m model) View() string {
if m.quitting {
return ""
}
if m.header != "" {
header := m.headerStyle.Render(m.header)
return lipgloss.JoinVertical(lipgloss.Left, header, m.textinput.View())
}

    if !m.showHelp {
    	return m.textinput.View()
    }
    return lipgloss.JoinVertical(
    	lipgloss.Top,
    	m.textinput.View(),
    	"",
    	m.help.View(m.keymap),
    )

}

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
switch msg := msg.(type) {
case tea.WindowSizeMsg:
if m.autoWidth {
m.textinput.Width = msg.Width - lipgloss.Width(m.textinput.Prompt) - 1
}
case tea.KeyMsg:
switch msg.String() {
case "ctrl+c":
m.quitting = true
return m, tea.Interrupt
case "esc":
m.quitting = true
return m, tea.Quit
case "enter":
m.quitting = true
m.submitted = true
return m, tea.Quit
}
}

    var cmd tea.Cmd
    m.textinput, cmd = m.textinput.Update(msg)
    return m, cmd

}

================================================
File: input/options.go
================================================
package input

import (
"time"

    "github.com/charmbracelet/gum/style"

)

// Options are the customization options for the input.
type Options struct {
Placeholder string `help:"Placeholder value" default:"Type something..." env:"GUM_INPUT_PLACEHOLDER"`
Prompt string `help:"Prompt to display" default:"> " env:"GUM_INPUT_PROMPT"`
PromptStyle style.Styles `embed:"" prefix:"prompt." envprefix:"GUM_INPUT_PROMPT_"`
PlaceholderStyle style.Styles `embed:"" prefix:"placeholder." set:"defaultForeground=240" envprefix:"GUM_INPUT_PLACEHOLDER_"`
CursorStyle style.Styles `embed:"" prefix:"cursor." set:"defaultForeground=212" envprefix:"GUM_INPUT_CURSOR_"`
CursorMode string `prefix:"cursor." name:"mode" help:"Cursor mode" default:"blink" enum:"blink,hide,static" env:"GUM_INPUT_CURSOR_MODE"`
Value string `help:"Initial value (can also be passed via stdin)" default:""`
CharLimit int `help:"Maximum value length (0 for no limit)" default:"400"`
Width int `help:"Input width (0 for terminal width)" default:"0" env:"GUM_INPUT_WIDTH"`
Password bool `help:"Mask input characters" default:"false"`
ShowHelp bool `help:"Show help keybinds" default:"true" negatable:"" env:"GUM_INPUT_SHOW_HELP"`
Header string `help:"Header value" default:"" env:"GUM_INPUT_HEADER"`
HeaderStyle style.Styles `embed:"" prefix:"header." set:"defaultForeground=240" envprefix:"GUM_INPUT_HEADER_"`
Timeout time.Duration `help:"Timeout until input aborts" default:"0s" env:"GUM_INPUT_TIMEOUT"`
StripANSI bool `help:"Strip ANSI sequences when reading from STDIN" default:"true" negatable:"" env:"GUM_INPUT_STRIP_ANSI"`
}

================================================
File: internal/decode/align.go
================================================
package decode

import "github.com/charmbracelet/lipgloss"

// Align maps strings to `lipgloss.Position`s.
var Align = map[string]lipgloss.Position{
"center": lipgloss.Center,
"left": lipgloss.Left,
"top": lipgloss.Top,
"bottom": lipgloss.Bottom,
"right": lipgloss.Right,
}

================================================
File: internal/exit/exit.go
================================================
package exit

import (
"strconv"
)

// StatusTimeout is the exit code for timed out commands.
const StatusTimeout = 124

// StatusAborted is the exit code for aborted commands.
const StatusAborted = 130

// ErrExit is a custom exit error.
type ErrExit int

// Error implements error.
func (e ErrExit) Error() string { return "exit " + strconv.Itoa(int(e)) }

================================================
File: internal/files/files.go
================================================
package files

import (
"os"
"path/filepath"
"strings"
)

// List returns a list of all files in the current directory.
// It ignores the .git directory.
func List() []string {
var files []string
err := filepath.Walk(".",
func(path string, info os.FileInfo, err error) error {
if shouldIgnore(path) || info.IsDir() || err != nil {
return nil //nolint:nilerr
}
files = append(files, path)
return nil
})

    if err != nil {
    	return []string{}
    }
    return files

}

var defaultIgnorePatterns = []string{"node_modules", ".git", "."}

func shouldIgnore(path string) bool {
for \_, prefix := range defaultIgnorePatterns {
if strings.HasPrefix(path, prefix) {
return true
}
}
return false
}

================================================
File: internal/log/log.go
================================================
package log

import "fmt"

// Error prints an error message to the user.
func Error(message string) {
fmt.Println("Error:", message)
}

================================================
File: internal/stack/stack.go
================================================
package stack

// Stack is a stack interface for integers.
type Stack struct {
Push func(int)
Pop func() int
Length func() int
}

// NewStack returns a new stack of integers.
func NewStack() Stack {
slice := make([]int, 0)
return Stack{
Push: func(i int) {
slice = append(slice, i)
},
Pop: func() int {
res := slice[len(slice)-1]
slice = slice[:len(slice)-1]
return res
},
Length: func() int {
return len(slice)
},
}
}

================================================
File: internal/stdin/stdin.go
================================================
package stdin

import (
"bufio"
"fmt"
"io"
"os"
"strings"

    "github.com/charmbracelet/x/ansi"

)

type options struct {
ansiStrip bool
singleLine bool
}

// Option is a read option.
type Option func(\*options)

// StripANSI optionally strips ansi sequences.
func StripANSI(b bool) Option {
return func(o \*options) {
o.ansiStrip = b
}
}

// SingleLine reads a single line.
func SingleLine(b bool) Option {
return func(o \*options) {
o.singleLine = b
}
}

// Read reads input from an stdin pipe.
func Read(opts ...Option) (string, error) {
if IsEmpty() {
return "", fmt.Errorf("stdin is empty")
}

    options := options{}
    for _, opt := range opts {
    	opt(&options)
    }

    reader := bufio.NewReader(os.Stdin)
    var b strings.Builder

    if options.singleLine {
    	line, _, err := reader.ReadLine()
    	if err != nil {
    		return "", fmt.Errorf("failed to read line: %w", err)
    	}
    	_, err = b.Write(line)
    	if err != nil {
    		return "", fmt.Errorf("failed to write: %w", err)
    	}
    }

    for !options.singleLine {
    	r, _, err := reader.ReadRune()
    	if err != nil && err == io.EOF {
    		break
    	}
    	_, err = b.WriteRune(r)
    	if err != nil {
    		return "", fmt.Errorf("failed to write rune: %w", err)
    	}
    }

    s := strings.TrimSpace(b.String())
    if options.ansiStrip {
    	return ansi.Strip(s), nil
    }
    return s, nil

}

// IsEmpty returns whether stdin is empty.
func IsEmpty() bool {
stat, err := os.Stdin.Stat()
if err != nil {
return true
}

    if stat.Mode()&os.ModeNamedPipe == 0 && stat.Size() == 0 {
    	return true
    }

    return false

}

================================================
File: internal/timeout/context.go
================================================
package timeout

import (
"context"
"time"
)

// Context setup a new context that times out if the given timeout is > 0.
func Context(timeout time.Duration) (context.Context, context.CancelFunc) {
ctx := context.Background()
if timeout == 0 {
return ctx, func() {}
}
return context.WithTimeout(ctx, timeout)
}

================================================
File: internal/tty/tty.go
================================================
// Package tty provides tty-aware printing.
package tty

import (
"fmt"
"os"
"sync"

    "github.com/charmbracelet/x/ansi"
    "github.com/charmbracelet/x/term"

)

var isTTY = sync.OnceValue(func() bool {
return term.IsTerminal(os.Stdout.Fd())
})

// Println handles println, striping ansi sequences if stdout is not a tty.
func Println(s string) {
if isTTY() {
fmt.Println(s)
return
}
fmt.Println(ansi.Strip(s))
}

================================================
File: internal/utils/utils.go
================================================
package utils

import (
"strings"

    "github.com/charmbracelet/lipgloss"

)

// LipglossPadding calculates how much padding a string is given by a style.
func LipglossPadding(style lipgloss.Style) (int, int) {
render := style.Render(" ")
before := strings.Index(render, " ")
after := len(render) - len(" ") - before
return before, after
}

================================================
File: join/command.go
================================================
// Package join provides a shell script interface for the lipgloss
// JoinHorizontal and JoinVertical commands. It allows you to join multi-line
// text to build different layouts.
//
// For example, you can place two bordered boxes next to each other: Note: We
// wrap the variable in quotes to ensure the new lines are part of a single
// argument. Otherwise, the command won't work as expected.
//
// $ gum join --horizontal "$BUBBLE_BOX" "$GUM_BOX"
//
// ╔══════════════════════╗╔═════════════╗
// ║ ║║ ║
// ║ Bubble ║║ Gum ║
// ║ ║║ ║
// ╚══════════════════════╝╚═════════════╝
package join

import (
"fmt"

    "github.com/charmbracelet/lipgloss"

    "github.com/charmbracelet/gum/internal/decode"

)

// Run is the command-line interface for the joining strings through lipgloss.
func (o Options) Run() error {
join := lipgloss.JoinHorizontal
if o.Vertical {
join = lipgloss.JoinVertical
}
fmt.Println(join(decode.Align[o.Align], o.Text...))
return nil
}

================================================
File: join/options.go
================================================
package join

// Options is the set of options that can configure a join.
type Options struct {
Text []string `arg:"" help:"Text to join."`

    Align      string `help:"Text alignment" enum:"left,center,right,bottom,middle,top" default:"left"`
    Horizontal bool   `help:"Join (potentially multi-line) strings horizontally"`
    Vertical   bool   `help:"Join (potentially multi-line) strings vertically"`

}

================================================
File: log/command.go
================================================
package log

import (
"fmt"
"math"
"os"
"strings"
"time"

    "github.com/charmbracelet/lipgloss"
    "github.com/charmbracelet/log"

)

// Run is the command-line interface for logging text.
func (o Options) Run() error {
l := log.New(os.Stderr)

    if o.File != "" {
    	f, err := os.OpenFile(o.File, os.O_CREATE|os.O_WRONLY|os.O_APPEND, os.ModePerm)
    	if err != nil {
    		return fmt.Errorf("error opening file: %w", err)
    	}

    	defer f.Close() //nolint:errcheck
    	l.SetOutput(f)
    }

    l.SetPrefix(o.Prefix)
    l.SetLevel(-math.MaxInt32) // log all levels
    l.SetReportTimestamp(o.Time != "")
    if o.MinLevel != "" {
    	lvl, err := log.ParseLevel(o.MinLevel)
    	if err != nil {
    		return err
    	}
    	l.SetLevel(lvl)
    }

    timeFormats := map[string]string{
    	"layout":      time.Layout,
    	"ansic":       time.ANSIC,
    	"unixdate":    time.UnixDate,
    	"rubydate":    time.RubyDate,
    	"rfc822":      time.RFC822,
    	"rfc822z":     time.RFC822Z,
    	"rfc850":      time.RFC850,
    	"rfc1123":     time.RFC1123,
    	"rfc1123z":    time.RFC1123Z,
    	"rfc3339":     time.RFC3339,
    	"rfc3339nano": time.RFC3339Nano,
    	"kitchen":     time.Kitchen,
    	"stamp":       time.Stamp,
    	"stampmilli":  time.StampMilli,
    	"stampmicro":  time.StampMicro,
    	"stampnano":   time.StampNano,
    	"datetime":    time.DateTime,
    	"dateonly":    time.DateOnly,
    	"timeonly":    time.TimeOnly,
    }

    tf, ok := timeFormats[strings.ToLower(o.Time)]
    if ok {
    	l.SetTimeFormat(tf)
    } else {
    	l.SetTimeFormat(o.Time)
    }

    st := log.DefaultStyles()
    lvl := levelToLog[o.Level]
    lvlStyle := o.LevelStyle.ToLipgloss()
    if lvlStyle.GetForeground() == lipgloss.Color("") {
    	lvlStyle = lvlStyle.Foreground(st.Levels[lvl].GetForeground())
    }

    st.Levels[lvl] = lvlStyle.
    	SetString(strings.ToUpper(lvl.String())).
    	Inline(true)

    st.Timestamp = o.TimeStyle.ToLipgloss().
    	Inline(true)
    st.Prefix = o.PrefixStyle.ToLipgloss().
    	Inline(true)
    st.Message = o.MessageStyle.ToLipgloss().
    	Inline(true)
    st.Key = o.KeyStyle.ToLipgloss().
    	Inline(true)
    st.Value = o.ValueStyle.ToLipgloss().
    	Inline(true)
    st.Separator = o.SeparatorStyle.ToLipgloss().
    	Inline(true)

    l.SetStyles(st)

    switch o.Formatter {
    case "json":
    	l.SetFormatter(log.JSONFormatter)
    case "logfmt":
    	l.SetFormatter(log.LogfmtFormatter)
    case "text":
    	l.SetFormatter(log.TextFormatter)
    }

    var arg0 string
    var args []interface{}
    if len(o.Text) > 0 {
    	arg0 = o.Text[0]
    }

    if len(o.Text) > 1 {
    	args = make([]interface{}, len(o.Text[1:]))
    	for i, arg := range o.Text[1:] {
    		args[i] = arg
    	}
    }

    logger := map[string]logger{
    	"none":  {printf: l.Printf, print: l.Print},
    	"debug": {printf: l.Debugf, print: l.Debug},
    	"info":  {printf: l.Infof, print: l.Info},
    	"warn":  {printf: l.Warnf, print: l.Warn},
    	"error": {printf: l.Errorf, print: l.Error},
    	"fatal": {printf: l.Fatalf, print: l.Fatal},
    }[o.Level]

    if o.Format {
    	logger.printf(arg0, args...)
    } else if o.Structured {
    	logger.print(arg0, args...)
    } else {
    	logger.print(strings.Join(o.Text, " "))
    }

    return nil

}

type logger struct {
printf func(string, ...interface{})
print func(interface{}, ...interface{})
}

var levelToLog = map[string]log.Level{
"none": log.Level(math.MaxInt32),
"debug": log.DebugLevel,
"info": log.InfoLevel,
"warn": log.WarnLevel,
"error": log.ErrorLevel,
"fatal": log.FatalLevel,
}

================================================
File: log/options.go
================================================
package log

import (
"github.com/charmbracelet/gum/style"
)

// Options is the set of options that can configure a join.
type Options struct {
Text []string `arg:"" help:"Text to log"`

    File       string `short:"o" help:"Log to file"`
    Format     bool   `short:"f" help:"Format message using printf" xor:"format,structured"`
    Formatter  string `help:"The log formatter to use" enum:"json,logfmt,text" default:"text"`
    Level      string `short:"l" help:"The log level to use" enum:"none,debug,info,warn,error,fatal" default:"none"`
    Prefix     string `help:"Prefix to print before the message"`
    Structured bool   `short:"s" help:"Use structured logging" xor:"format,structured"`
    Time       string `short:"t" help:"The time format to use (kitchen, layout, ansic, rfc822, etc...)" default:""`

    MinLevel string `help:"Minimal level to show" default:"" env:"GUM_LOG_LEVEL"`

    LevelStyle     style.Styles `embed:"" prefix:"level." help:"The style of the level being used" set:"defaultBold=true" envprefix:"GUM_LOG_LEVEL_"` //nolint:staticcheck
    TimeStyle      style.Styles `embed:"" prefix:"time." help:"The style of the time" envprefix:"GUM_LOG_TIME_"`
    PrefixStyle    style.Styles `embed:"" prefix:"prefix." help:"The style of the prefix" set:"defaultBold=true" set:"defaultFaint=true" envprefix:"GUM_LOG_PREFIX_"` //nolint:staticcheck
    MessageStyle   style.Styles `embed:"" prefix:"message." help:"The style of the message" envprefix:"GUM_LOG_MESSAGE_"`
    KeyStyle       style.Styles `embed:"" prefix:"key." help:"The style of the key" set:"defaultFaint=true" envprefix:"GUM_LOG_KEY_"`
    ValueStyle     style.Styles `embed:"" prefix:"value." help:"The style of the value" envprefix:"GUM_LOG_VALUE_"`
    SeparatorStyle style.Styles `embed:"" prefix:"separator." help:"The style of the separator" set:"defaultFaint=true" envprefix:"GUM_LOG_SEPARATOR_"`

}

================================================
File: man/command.go
================================================
package man

import (
"fmt"

    "github.com/alecthomas/kong"
    mangokong "github.com/alecthomas/mango-kong"
    "github.com/muesli/roff"

)

// Man is a gum sub-command that generates man pages.
type Man struct{}

// BeforeApply implements Kong BeforeApply hook.
func (m Man) BeforeApply(ctx \*kong.Context) error {
// Set the correct man pages description without color escape sequences.
ctx.Model.Help = "A tool for glamorous shell scripts."
man := mangokong.NewManPage(1, ctx.Model)
man = man.WithSection("Copyright", "(c) 2022-2024 Charmbracelet, Inc.\n"+
"Released under MIT license.")
_, _ = fmt.Fprint(ctx.Stdout, man.Build(roff.NewDocument()))
ctx.Exit(0)
return nil
}

================================================
File: pager/command.go
================================================
package pager

import (
"fmt"
"regexp"

    "github.com/charmbracelet/bubbles/help"
    "github.com/charmbracelet/bubbles/viewport"
    tea "github.com/charmbracelet/bubbletea"
    "github.com/charmbracelet/gum/internal/stdin"
    "github.com/charmbracelet/gum/internal/timeout"

)

// Run provides a shell script interface for the viewport bubble.
// https://github.com/charmbracelet/bubbles/viewport
func (o Options) Run() error {
vp := viewport.New(o.Style.Width, o.Style.Height)
vp.Style = o.Style.ToLipgloss()

    if o.Content == "" {
    	stdin, err := stdin.Read()
    	if err != nil {
    		return fmt.Errorf("unable to read stdin")
    	}
    	if stdin != "" {
    		// Sanitize the input from stdin by removing backspace sequences.
    		backspace := regexp.MustCompile(".\x08")
    		o.Content = backspace.ReplaceAllString(stdin, "")
    	} else {
    		return fmt.Errorf("provide some content to display")
    	}
    }

    m := model{
    	viewport:            vp,
    	help:                help.New(),
    	content:             o.Content,
    	origContent:         o.Content,
    	showLineNumbers:     o.ShowLineNumbers,
    	lineNumberStyle:     o.LineNumberStyle.ToLipgloss(),
    	softWrap:            o.SoftWrap,
    	matchStyle:          o.MatchStyle.ToLipgloss(),
    	matchHighlightStyle: o.MatchHighlightStyle.ToLipgloss(),
    	keymap:              defaultKeymap(),
    }

    ctx, cancel := timeout.Context(o.Timeout)
    defer cancel()

    _, err := tea.NewProgram(
    	m,
    	tea.WithAltScreen(),
    	tea.WithReportFocus(),
    	tea.WithContext(ctx),
    ).Run()
    if err != nil {
    	return fmt.Errorf("unable to start program: %w", err)
    }

    return nil

}

================================================
File: pager/options.go
================================================
package pager

import (
"time"

    "github.com/charmbracelet/gum/style"

)

// Options are the options for the pager.
type Options struct {
//nolint:staticcheck
Style style.Styles `embed:"" help:"Style the pager" set:"defaultBorder=rounded" set:"defaultPadding=0 1" set:"defaultBorderForeground=212" envprefix:"GUM_PAGER_"`
Content string `arg:"" optional:"" help:"Display content to scroll"`
ShowLineNumbers bool `help:"Show line numbers" default:"true"`
LineNumberStyle style.Styles `embed:"" prefix:"line-number." help:"Style the line numbers" set:"defaultForeground=237" envprefix:"GUM_PAGER_LINE_NUMBER_"`
SoftWrap bool `help:"Soft wrap lines" default:"true" negatable:""`
MatchStyle style.Styles `embed:"" prefix:"match." help:"Style the matched text" set:"defaultForeground=212" set:"defaultBold=true" envprefix:"GUM_PAGER_MATCH_"` //nolint:staticcheck
MatchHighlightStyle style.Styles `embed:"" prefix:"match-highlight." help:"Style the matched highlight text" set:"defaultForeground=235" set:"defaultBackground=225" set:"defaultBold=true" envprefix:"GUM_PAGER_MATCH_HIGH_"` //nolint:staticcheck
Timeout time.Duration `help:"Timeout until command exits" default:"0s" env:"GUM_PAGER_TIMEOUT"`

    // Deprecated: this has no effect anymore.
    HelpStyle style.Styles `embed:"" prefix:"help." help:"Style the help text" set:"defaultForeground=241" envprefix:"GUM_PAGER_HELP_" hidden:""`

}

================================================
File: pager/pager.go
================================================
// Package pager provides a pager (similar to less) for the terminal.
//
// $ cat file.txt | gum pager
package pager

import (
"fmt"
"strings"

    "github.com/charmbracelet/bubbles/help"
    "github.com/charmbracelet/bubbles/key"
    "github.com/charmbracelet/bubbles/textinput"
    "github.com/charmbracelet/bubbles/viewport"
    tea "github.com/charmbracelet/bubbletea"
    "github.com/charmbracelet/lipgloss"
    "github.com/charmbracelet/x/ansi"

)

type keymap struct {
Home,
End,
Search,
NextMatch,
PrevMatch,
Abort,
Quit,
ConfirmSearch,
CancelSearch key.Binding
}

// FullHelp implements help.KeyMap.
func (k keymap) FullHelp() [][]key.Binding {
return nil
}

// ShortHelp implements help.KeyMap.
func (k keymap) ShortHelp() []key.Binding {
return []key.Binding{
key.NewBinding(
key.WithKeys("up", "down"),
key.WithHelp("↓↑", "navigate"),
),
k.Quit,
k.Search,
k.NextMatch,
k.PrevMatch,
}
}

func defaultKeymap() keymap {
return keymap{
Home: key.NewBinding(
key.WithKeys("g", "home"),
key.WithHelp("h", "home"),
),
End: key.NewBinding(
key.WithKeys("G", "end"),
key.WithHelp("G", "end"),
),
Search: key.NewBinding(
key.WithKeys("/"),
key.WithHelp("/", "search"),
),
PrevMatch: key.NewBinding(
key.WithKeys("p", "N"),
key.WithHelp("N", "previous match"),
),
NextMatch: key.NewBinding(
key.WithKeys("n"),
key.WithHelp("n", "next match"),
),
Abort: key.NewBinding(
key.WithKeys("ctrl+c"),
key.WithHelp("ctrl+c", "abort"),
),
Quit: key.NewBinding(
key.WithKeys("q", "esc"),
key.WithHelp("esc", "quit"),
),
ConfirmSearch: key.NewBinding(
key.WithKeys("enter"),
key.WithHelp("enter", "confirm"),
),
CancelSearch: key.NewBinding(
key.WithKeys("ctrl+c", "ctrl+d", "esc"),
key.WithHelp("ctrl+c", "cancel"),
),
}
}

type model struct {
content string
origContent string
viewport viewport.Model
help help.Model
showLineNumbers bool
lineNumberStyle lipgloss.Style
softWrap bool
search search
matchStyle lipgloss.Style
matchHighlightStyle lipgloss.Style
maxWidth int
keymap keymap
}

func (m model) Init() tea.Cmd { return nil }

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
switch msg := msg.(type) {
case tea.WindowSizeMsg:
m.processText(msg)
case tea.KeyMsg:
return m.keyHandler(msg)
}

    m.keymap.PrevMatch.SetEnabled(m.search.query != nil)
    m.keymap.NextMatch.SetEnabled(m.search.query != nil)

    var cmd tea.Cmd
    m.search.input, cmd = m.search.input.Update(msg)
    return m, cmd

}

func (m \*model) helpView() string {
return m.help.View(m.keymap)
}

func (m \*model) processText(msg tea.WindowSizeMsg) {
m.viewport.Height = msg.Height - lipgloss.Height(m.helpView())
m.viewport.Width = msg.Width
textStyle := lipgloss.NewStyle().Width(m.viewport.Width)
var text strings.Builder

    // Determine max width of a line.
    m.maxWidth = m.viewport.Width
    if m.softWrap {
    	vpStyle := m.viewport.Style
    	m.maxWidth -= vpStyle.GetHorizontalBorderSize() + vpStyle.GetHorizontalMargins() + vpStyle.GetHorizontalPadding()
    	if m.showLineNumbers {
    		m.maxWidth -= lipgloss.Width("     │ ")
    	}
    }

    for i, line := range strings.Split(m.content, "\n") {
    	line = strings.ReplaceAll(line, "\t", "    ")
    	if m.showLineNumbers {
    		text.WriteString(m.lineNumberStyle.Render(fmt.Sprintf("%4d │ ", i+1)))
    	}
    	idx := 0
    	if w := ansi.StringWidth(line); m.softWrap && w > m.maxWidth {
    		for w > idx {
    			if m.showLineNumbers && idx != 0 {
    				text.WriteString(m.lineNumberStyle.Render("     │ "))
    			}
    			truncatedLine := ansi.Cut(line, idx, m.maxWidth+idx)
    			idx += m.maxWidth
    			text.WriteString(textStyle.Render(truncatedLine))
    			text.WriteString("\n")
    		}
    	} else {
    		text.WriteString(textStyle.Render(line)) //nolint: gosec
    		text.WriteString("\n")
    	}
    }

    diffHeight := m.viewport.Height - lipgloss.Height(text.String())
    if diffHeight > 0 && m.showLineNumbers {
    	remainingLines := "   ~ │ " + strings.Repeat("\n   ~ │ ", diffHeight-1)
    	text.WriteString(m.lineNumberStyle.Render(remainingLines))
    }
    m.viewport.SetContent(text.String())

}

const heightOffset = 2

func (m model) keyHandler(msg tea.KeyMsg) (model, tea.Cmd) {
km := m.keymap
var cmd tea.Cmd
if m.search.active {
switch {
case key.Matches(msg, km.ConfirmSearch):
if m.search.input.Value() != "" {
m.content = m.origContent
m.search.Execute(&m)

    			// Trigger a view update to highlight the found matches.
    			m.search.NextMatch(&m)
    			m.processText(tea.WindowSizeMsg{Height: m.viewport.Height + heightOffset, Width: m.viewport.Width})
    		} else {
    			m.search.Done()
    		}
    	case key.Matches(msg, km.CancelSearch):
    		m.search.Done()
    	default:
    		m.search.input, cmd = m.search.input.Update(msg)
    	}
    } else {
    	switch {
    	case key.Matches(msg, km.Home):
    		m.viewport.GotoTop()
    	case key.Matches(msg, km.End):
    		m.viewport.GotoBottom()
    	case key.Matches(msg, km.Search):
    		m.search.Begin()
    		return m, textinput.Blink
    	case key.Matches(msg, km.PrevMatch):
    		m.search.PrevMatch(&m)
    		m.processText(tea.WindowSizeMsg{Height: m.viewport.Height + heightOffset, Width: m.viewport.Width})
    	case key.Matches(msg, km.NextMatch):
    		m.search.NextMatch(&m)
    		m.processText(tea.WindowSizeMsg{Height: m.viewport.Height + heightOffset, Width: m.viewport.Width})
    	case key.Matches(msg, km.Quit):
    		return m, tea.Quit
    	case key.Matches(msg, km.Abort):
    		return m, tea.Interrupt
    	}
    	m.viewport, cmd = m.viewport.Update(msg)
    }

    return m, cmd

}

func (m model) View() string {
if m.search.active {
return m.viewport.View() + "\n " + m.search.input.View()
}

    return m.viewport.View() + "\n" + m.helpView()

}

================================================
File: pager/search.go
================================================
package pager

import (
"fmt"
"regexp"
"strings"

    "github.com/charmbracelet/bubbles/textinput"
    "github.com/charmbracelet/gum/internal/utils"
    "github.com/charmbracelet/lipgloss"
    "github.com/charmbracelet/x/ansi"

)

type search struct {
active bool
input textinput.Model
query \*regexp.Regexp
matchIndex int
matchLipglossStr string
matchString string
}

func (s \*search) new() {
input := textinput.New()
input.Placeholder = "search"
input.Prompt = "/"
input.PromptStyle = lipgloss.NewStyle().Foreground(lipgloss.Color("240"))
s.input = input
}

func (s \*search) Begin() {
s.new()
s.active = true
s.input.Focus()
}

// Execute find all lines in the model with a match.
func (s *search) Execute(m *model) {
defer s.Done()
if s.input.Value() == "" {
s.query = nil
return
}

    var err error
    s.query, err = regexp.Compile(s.input.Value())
    if err != nil {
    	s.query = nil
    	return
    }
    query := regexp.MustCompile(fmt.Sprintf("(%s)", s.query.String()))
    m.content = query.ReplaceAllString(m.content, m.matchStyle.Render("$1"))

    // Recompile the regex to match the an replace the highlights.
    leftPad, _ := utils.LipglossPadding(m.matchStyle)
    matchingString := regexp.QuoteMeta(m.matchStyle.Render()[:leftPad]) + s.query.String() + regexp.QuoteMeta(m.matchStyle.Render()[leftPad:])
    s.query, err = regexp.Compile(matchingString)
    if err != nil {
    	s.query = nil
    }

}

func (s \*search) Done() {
s.active = false

    // To account for the first match is always executed.
    s.matchIndex = -1

}

func (s *search) NextMatch(m *model) {
// Check that we are within bounds.
if s.query == nil {
return
}

    // Remove previous highlight.
    m.content = strings.Replace(m.content, s.matchLipglossStr, s.matchString, 1)

    // Highlight the next match.
    allMatches := s.query.FindAllStringIndex(m.content, -1)
    if len(allMatches) == 0 {
    	return
    }

    leftPad, rightPad := utils.LipglossPadding(m.matchStyle)
    s.matchIndex = (s.matchIndex + 1) % len(allMatches)
    match := allMatches[s.matchIndex]
    lhs := m.content[:match[0]]
    rhs := m.content[match[0]:]
    s.matchString = m.content[match[0]:match[1]]
    s.matchLipglossStr = m.matchHighlightStyle.Render(s.matchString[leftPad : len(s.matchString)-rightPad])
    m.content = lhs + strings.Replace(rhs, m.content[match[0]:match[1]], s.matchLipglossStr, 1)

    // Update the viewport position.
    var line int
    formatStr := softWrapEm(m.content, m.maxWidth, m.softWrap)
    index := strings.Index(formatStr, s.matchLipglossStr)
    if index != -1 {
    	line = strings.Count(formatStr[:index], "\n")
    }

    // Only update if the match is not within the viewport.
    if index != -1 && (line > m.viewport.YOffset-1+m.viewport.VisibleLineCount()-1 || line < m.viewport.YOffset) {
    	m.viewport.SetYOffset(line)
    }

}

func (s *search) PrevMatch(m *model) {
// Check that we are within bounds.
if s.query == nil {
return
}

    // Remove previous highlight.
    m.content = strings.Replace(m.content, s.matchLipglossStr, s.matchString, 1)

    // Highlight the previous match.
    allMatches := s.query.FindAllStringIndex(m.content, -1)
    if len(allMatches) == 0 {
    	return
    }

    s.matchIndex = (s.matchIndex - 1) % len(allMatches)
    if s.matchIndex < 0 {
    	s.matchIndex = len(allMatches) - 1
    }

    leftPad, rightPad := utils.LipglossPadding(m.matchStyle)
    match := allMatches[s.matchIndex]
    lhs := m.content[:match[0]]
    rhs := m.content[match[0]:]
    s.matchString = m.content[match[0]:match[1]]
    s.matchLipglossStr = m.matchHighlightStyle.Render(s.matchString[leftPad : len(s.matchString)-rightPad])
    m.content = lhs + strings.Replace(rhs, m.content[match[0]:match[1]], s.matchLipglossStr, 1)

    // Update the viewport position.
    var line int
    formatStr := softWrapEm(m.content, m.maxWidth, m.softWrap)
    index := strings.Index(formatStr, s.matchLipglossStr)
    if index != -1 {
    	line = strings.Count(formatStr[:index], "\n")
    }

    // Only update if the match is not within the viewport.
    if index != -1 && (line > m.viewport.YOffset-1+m.viewport.VisibleLineCount()-1 || line < m.viewport.YOffset) {
    	m.viewport.SetYOffset(line)
    }

}

func softWrapEm(str string, maxWidth int, softWrap bool) string {
var text strings.Builder
for \_, line := range strings.Split(str, "\n") {
idx := 0
if w := ansi.StringWidth(line); softWrap && w > maxWidth {
for w > idx {
truncatedLine := ansi.Cut(line, idx, maxWidth+idx)
idx += maxWidth
text.WriteString(truncatedLine)
text.WriteString("\n")
}
} else {
text.WriteString(line) //nolint: gosec
text.WriteString("\n")
}
}

    return text.String()

}

================================================
File: spin/command.go
================================================
package spin

import (
"fmt"
"os"

    "github.com/charmbracelet/bubbles/spinner"
    tea "github.com/charmbracelet/bubbletea"
    "github.com/charmbracelet/gum/internal/exit"
    "github.com/charmbracelet/gum/internal/timeout"
    "github.com/charmbracelet/x/term"

)

// Run provides a shell script interface for the spinner bubble.
// https://github.com/charmbracelet/bubbles/spinner
func (o Options) Run() error {
isOutTTY := term.IsTerminal(os.Stdout.Fd())
isErrTTY := term.IsTerminal(os.Stderr.Fd())

    s := spinner.New()
    s.Style = o.SpinnerStyle.ToLipgloss()
    s.Spinner = spinnerMap[o.Spinner]
    m := model{
    	spinner:    s,
    	title:      o.TitleStyle.ToLipgloss().Render(o.Title),
    	command:    o.Command,
    	align:      o.Align,
    	showStdout: (o.ShowOutput || o.ShowStdout) && isOutTTY,
    	showStderr: (o.ShowOutput || o.ShowStderr) && isErrTTY,
    	showError:  o.ShowError,
    	isTTY:      isErrTTY,
    }

    ctx, cancel := timeout.Context(o.Timeout)
    defer cancel()

    tm, err := tea.NewProgram(
    	m,
    	tea.WithOutput(os.Stderr),
    	tea.WithContext(ctx),
    	tea.WithInput(nil),
    ).Run()
    if err != nil {
    	return fmt.Errorf("unable to run action: %w", err)
    }

    m = tm.(model)
    // If the command succeeds, and we are printing output and we are in a TTY then push the STDOUT we got to the actual
    // STDOUT for piping or other things.
    //nolint:nestif
    if m.err != nil {
    	if _, err := fmt.Fprintf(os.Stderr, "%s\n", m.err.Error()); err != nil {
    		return fmt.Errorf("failed to write to stdout: %w", err)
    	}
    	return exit.ErrExit(1)
    } else if m.status == 0 {
    	var output string
    	if o.ShowOutput || (o.ShowStdout && o.ShowStderr) {
    		output = m.output
    	} else if o.ShowStdout {
    		output = m.stdout
    	} else if o.ShowStderr {
    		output = m.stderr
    	}
    	if output != "" {
    		if _, err := os.Stdout.WriteString(output); err != nil {
    			return fmt.Errorf("failed to write to stdout: %w", err)
    		}
    	}
    } else if o.ShowError {
    	// Otherwise if we are showing errors and the command did not exit with a 0 status code then push all of the command
    	// output to the terminal. This way failed commands can be debugged.
    	if _, err := os.Stdout.WriteString(m.output); err != nil {
    		return fmt.Errorf("failed to write to stdout: %w", err)
    	}
    }

    return exit.ErrExit(m.status)

}

================================================
File: spin/options.go
================================================
package spin

import (
"time"

    "github.com/charmbracelet/gum/style"

)

// Options is the customization options for the spin command.
type Options struct {
Command []string `arg:"" help:"Command to run"`

    ShowOutput   bool          `help:"Show or pipe output of command during execution (shows both STDOUT and STDERR)" default:"false" env:"GUM_SPIN_SHOW_OUTPUT"`
    ShowError    bool          `help:"Show output of command only if the command fails" default:"false" env:"GUM_SPIN_SHOW_ERROR"`
    ShowStdout   bool          `help:"Show STDOUT output" default:"false" env:"GUM_SPIN_SHOW_STDOUT"`
    ShowStderr   bool          `help:"Show STDERR errput" default:"false" env:"GUM_SPIN_SHOW_STDERR"`
    Spinner      string        `help:"Spinner type" short:"s" type:"spinner" enum:"line,dot,minidot,jump,pulse,points,globe,moon,monkey,meter,hamburger" default:"dot" env:"GUM_SPIN_SPINNER"`
    SpinnerStyle style.Styles  `embed:"" prefix:"spinner." set:"defaultForeground=212" envprefix:"GUM_SPIN_SPINNER_"`
    Title        string        `help:"Text to display to user while spinning" default:"Loading..." env:"GUM_SPIN_TITLE"`
    TitleStyle   style.Styles  `embed:"" prefix:"title." envprefix:"GUM_SPIN_TITLE_"`
    Align        string        `help:"Alignment of spinner with regard to the title" short:"a" type:"align" enum:"left,right" default:"left" env:"GUM_SPIN_ALIGN"`
    Timeout      time.Duration `help:"Timeout until spin command aborts" default:"0s" env:"GUM_SPIN_TIMEOUT"`

}

================================================
File: spin/pty.go
================================================
package spin

import (
"os"

    "github.com/charmbracelet/x/term"
    "github.com/charmbracelet/x/xpty"

)

func openPty(f \*os.File) (pty xpty.Pty, err error) {
width, height, err := term.GetSize(f.Fd())
if err != nil {
return nil, err
}

    pty, err = xpty.NewPty(width, height)
    if err != nil {
    	return nil, err
    }

    return pty, nil

}

================================================
File: spin/spin.go
================================================
// Package spin provides a shell script interface for the spinner bubble.
// https://github.com/charmbracelet/bubbles/tree/master/spinner
//
// It is useful for displaying that some task is running in the background
// while consuming it's output so that it is not shown to the user.
//
// For example, let's do a long running task: $ sleep 5
//
// We can simply prepend a spinner to this task to show it to the user, while
// performing the task / command in the background.
//
// $ gum spin -t "Taking a nap..." -- sleep 5
//
// The spinner will automatically exit when the task is complete.
package spin

import (
"bytes"
"context"
"io"
"os"
"os/exec"
"runtime"
"syscall"

    "github.com/charmbracelet/bubbles/spinner"
    tea "github.com/charmbracelet/bubbletea"
    "github.com/charmbracelet/x/term"
    "github.com/charmbracelet/x/xpty"

)

type model struct {
spinner spinner.Model
title string
align string
command []string
quitting bool
isTTY bool
status int
stdout string
stderr string
output string
showStdout bool
showStderr bool
showError bool
err error
}

var (
bothbuf bytes.Buffer
outbuf bytes.Buffer
errbuf bytes.Buffer

    executing *exec.Cmd

)

type errorMsg error

type finishCommandMsg struct {
stdout string
stderr string
output string
status int
}

func commandStart(command []string) tea.Cmd {
return func() tea.Msg {
var args []string
if len(command) > 1 {
args = command[1:]
}

    	executing = exec.Command(command[0], args...) //nolint:gosec
    	executing.Stdin = os.Stdin

    	isTerminal := term.IsTerminal(os.Stdout.Fd())

    	// NOTE(@andreynering): We had issues with Git Bash on Windows
    	// when it comes to handling PTYs, so we're falling back to
    	// to redirecting stdout/stderr as usual to avoid issues.
    	//nolint:nestif
    	if isTerminal && runtime.GOOS == "windows" {
    		executing.Stdout = io.MultiWriter(&bothbuf, &outbuf)
    		executing.Stderr = io.MultiWriter(&bothbuf, &errbuf)
    		_ = executing.Run()
    	} else if isTerminal {
    		stdoutPty, err := openPty(os.Stdout)
    		if err != nil {
    			return errorMsg(err)
    		}
    		defer stdoutPty.Close() //nolint:errcheck

    		stderrPty, err := openPty(os.Stderr)
    		if err != nil {
    			return errorMsg(err)
    		}
    		defer stderrPty.Close() //nolint:errcheck

    		if outUnixPty, isOutUnixPty := stdoutPty.(*xpty.UnixPty); isOutUnixPty {
    			executing.Stdout = outUnixPty.Slave()
    		}
    		if errUnixPty, isErrUnixPty := stderrPty.(*xpty.UnixPty); isErrUnixPty {
    			executing.Stderr = errUnixPty.Slave()
    		}

    		go io.Copy(io.MultiWriter(&bothbuf, &outbuf), stdoutPty) //nolint:errcheck
    		go io.Copy(io.MultiWriter(&bothbuf, &errbuf), stderrPty) //nolint:errcheck

    		if err = stdoutPty.Start(executing); err != nil {
    			return errorMsg(err)
    		}
    		_ = xpty.WaitProcess(context.Background(), executing)
    	} else {
    		executing.Stdout = os.Stdout
    		executing.Stderr = os.Stderr
    		_ = executing.Run()
    	}

    	status := executing.ProcessState.ExitCode()
    	if status == -1 {
    		status = 1
    	}

    	return finishCommandMsg{
    		stdout: outbuf.String(),
    		stderr: errbuf.String(),
    		output: bothbuf.String(),
    		status: status,
    	}
    }

}

func commandAbort() tea.Msg {
if executing != nil && executing.Process != nil {
\_ = executing.Process.Signal(syscall.SIGINT)
}
return tea.InterruptMsg{}
}

func (m model) Init() tea.Cmd {
return tea.Batch(
m.spinner.Tick,
commandStart(m.command),
)
}

func (m model) View() string {
if m.quitting {
return ""
}

    var out string
    if m.showStderr {
    	out += errbuf.String()
    }
    if m.showStdout {
    	out += outbuf.String()
    }

    if !m.isTTY {
    	return m.title
    }

    var header string
    if m.align == "left" {
    	header = m.spinner.View() + " " + m.title
    } else {
    	header = m.title + " " + m.spinner.View()
    }
    return header + "\n" + out

}

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
switch msg := msg.(type) {
case finishCommandMsg:
m.stdout = msg.stdout
m.stderr = msg.stderr
m.output = msg.output
m.status = msg.status
m.quitting = true
return m, tea.Quit
case tea.KeyMsg:
switch msg.String() {
case "ctrl+c":
return m, commandAbort
}
case errorMsg:
m.err = msg
m.quitting = true
return m, tea.Quit
}

    var cmd tea.Cmd
    m.spinner, cmd = m.spinner.Update(msg)
    return m, cmd

}

================================================
File: spin/spinners.go
================================================
package spin

import "github.com/charmbracelet/bubbles/spinner"

var spinnerMap = map[string]spinner.Spinner{
"line": spinner.Line,
"dot": spinner.Dot,
"minidot": spinner.MiniDot,
"jump": spinner.Jump,
"pulse": spinner.Pulse,
"points": spinner.Points,
"globe": spinner.Globe,
"moon": spinner.Moon,
"monkey": spinner.Monkey,
"meter": spinner.Meter,
"hamburger": spinner.Hamburger,
}

================================================
File: style/ascii_a.txt
================================================

#

#

#

#

#######

#

#

================================================
File: style/borders.go
================================================
package style

import "github.com/charmbracelet/lipgloss"

// Border maps strings to `lipgloss.Border`s.
var Border map[string]lipgloss.Border = map[string]lipgloss.Border{
"double": lipgloss.DoubleBorder(),
"hidden": lipgloss.HiddenBorder(),
"none": {},
"normal": lipgloss.NormalBorder(),
"rounded": lipgloss.RoundedBorder(),
"thick": lipgloss.ThickBorder(),
}

================================================
File: style/command.go
================================================
// Package style provides a shell script interface for Lip Gloss.
// https://github.com/charmbracelet/lipgloss
//
// It allows you to use Lip Gloss to style text without needing to use Go. All
// of the styling options are available as flags.
package style

import (
"errors"
"fmt"
"strings"

    "github.com/charmbracelet/gum/internal/stdin"

)

// Run provides a shell script interface for the Lip Gloss styling.
// https://github.com/charmbracelet/lipgloss
func (o Options) Run() error {
var text string
if len(o.Text) > 0 {
text = strings.Join(o.Text, "\n")
} else {
text, _ = stdin.Read(stdin.StripANSI(o.StripANSI))
if text == "" {
return errors.New("no input provided, see `gum style --help`")
}
}
if o.Trim {
var lines []string
for _, line := range strings.Split(text, "\n") {
lines = append(lines, strings.TrimSpace(line))
}
text = strings.Join(lines, "\n")
}
fmt.Println(o.Style.ToLipgloss().Render(text))
return nil
}

================================================
File: style/lipgloss.go
================================================
package style

import (
"github.com/charmbracelet/lipgloss"

    "github.com/charmbracelet/gum/internal/decode"

)

// ToLipgloss takes a Styles flag set and returns the corresponding
// lipgloss.Style.
func (s Styles) ToLipgloss() lipgloss.Style {
return lipgloss.NewStyle().
Background(lipgloss.Color(s.Background)).
Foreground(lipgloss.Color(s.Foreground)).
BorderBackground(lipgloss.Color(s.BorderBackground)).
BorderForeground(lipgloss.Color(s.BorderForeground)).
Align(decode.Align[s.Align]).
Border(Border[s.Border]).
Height(s.Height).
Width(s.Width).
Margin(parseMargin(s.Margin)).
Padding(parsePadding(s.Padding)).
Bold(s.Bold).
Faint(s.Faint).
Italic(s.Italic).
Strikethrough(s.Strikethrough).
Underline(s.Underline)
}

// ToLipgloss takes a Styles flag set and returns the corresponding
// lipgloss.Style.
func (s StylesNotHidden) ToLipgloss() lipgloss.Style {
return lipgloss.NewStyle().
Background(lipgloss.Color(s.Background)).
Foreground(lipgloss.Color(s.Foreground)).
BorderBackground(lipgloss.Color(s.BorderBackground)).
BorderForeground(lipgloss.Color(s.BorderForeground)).
Align(decode.Align[s.Align]).
Border(Border[s.Border]).
Height(s.Height).
Width(s.Width).
Margin(parseMargin(s.Margin)).
Padding(parsePadding(s.Padding)).
Bold(s.Bold).
Faint(s.Faint).
Italic(s.Italic).
Strikethrough(s.Strikethrough).
Underline(s.Underline)
}

================================================
File: style/options.go
================================================
package style

// Options is the customization options for the style command.
type Options struct {
Text []string `arg:"" optional:"" help:"Text to which to apply the style"`
Trim bool `help:"Trim whitespaces on every input line" default:"false"`
StripANSI bool `help:"Strip ANSI sequences when reading from STDIN" default:"true" negatable:"" env:"GUM_STYLE_STRIP_ANSI"`
Style StylesNotHidden `embed:""`
}

// Styles is a flag set of possible styles.
//
// It corresponds to the available options in the lipgloss.Style struct.
//
// This flag set is used in other parts of the application to embed styles for
// components, through embedding and prefixing.
type Styles struct {
// Colors
Foreground string `help:"Foreground Color" default:"${defaultForeground}" group:"Style Flags" env:"FOREGROUND"`
Background string `help:"Background Color" default:"${defaultBackground}" group:"Style Flags" env:"BACKGROUND"`

    // Border
    Border           string `help:"Border Style" enum:"none,hidden,normal,rounded,thick,double" default:"${defaultBorder}" group:"Style Flags" env:"BORDER" hidden:"true"`
    BorderBackground string `help:"Border Background Color" group:"Style Flags" default:"${defaultBorderBackground}" env:"BORDER_BACKGROUND" hidden:"true"`
    BorderForeground string `help:"Border Foreground Color" group:"Style Flags" default:"${defaultBorderForeground}" env:"BORDER_FOREGROUND" hidden:"true"`

    // Layout
    Align   string `help:"Text Alignment" enum:"left,center,right,bottom,middle,top" default:"${defaultAlign}" group:"Style Flags" env:"ALIGN" hidden:"true"`
    Height  int    `help:"Text height" default:"${defaultHeight}" group:"Style Flags" env:"HEIGHT" hidden:"true"`
    Width   int    `help:"Text width" default:"${defaultWidth}" group:"Style Flags" env:"WIDTH" hidden:"true"`
    Margin  string `help:"Text margin" default:"${defaultMargin}" group:"Style Flags" env:"MARGIN" hidden:"true"`
    Padding string `help:"Text padding" default:"${defaultPadding}" group:"Style Flags" env:"PADDING" hidden:"true"`

    // Format
    Bold          bool `help:"Bold text" default:"${defaultBold}" group:"Style Flags" env:"BOLD" hidden:"true"`
    Faint         bool `help:"Faint text" default:"${defaultFaint}" group:"Style Flags" env:"FAINT" hidden:"true"`
    Italic        bool `help:"Italicize text" default:"${defaultItalic}" group:"Style Flags" env:"ITALIC" hidden:"true"`
    Strikethrough bool `help:"Strikethrough text" default:"${defaultStrikethrough}" group:"Style Flags" env:"STRIKETHROUGH" hidden:"true"`
    Underline     bool `help:"Underline text" default:"${defaultUnderline}" group:"Style Flags" env:"UNDERLINE" hidden:"true"`

}

// StylesNotHidden allows the style struct to display full help when not-embedded.
//
// NB: We must duplicate this struct to ensure that `gum style` does not hide
// flags when an error pops up. Ideally, we can dynamically hide or show flags
// based on the command run: https://github.com/alecthomas/kong/issues/316
type StylesNotHidden struct {
// Colors
Foreground string `help:"Foreground Color" default:"${defaultForeground}" group:"Style Flags" env:"FOREGROUND"`
Background string `help:"Background Color" default:"${defaultBackground}" group:"Style Flags" env:"BACKGROUND"`

    // Border
    Border           string `help:"Border Style" enum:"none,hidden,normal,rounded,thick,double" default:"${defaultBorder}" group:"Style Flags" env:"BORDER"`
    BorderBackground string `help:"Border Background Color" group:"Style Flags" default:"${defaultBorderBackground}" env:"BORDER_BACKGROUND"`
    BorderForeground string `help:"Border Foreground Color" group:"Style Flags" default:"${defaultBorderForeground}" env:"BORDER_FOREGROUND"`

    // Layout
    Align   string `help:"Text Alignment" enum:"left,center,right,bottom,middle,top" default:"${defaultAlign}" group:"Style Flags" env:"ALIGN"`
    Height  int    `help:"Text height" default:"${defaultHeight}" group:"Style Flags" env:"HEIGHT"`
    Width   int    `help:"Text width" default:"${defaultWidth}" group:"Style Flags" env:"WIDTH"`
    Margin  string `help:"Text margin" default:"${defaultMargin}" group:"Style Flags" env:"MARGIN"`
    Padding string `help:"Text padding" default:"${defaultPadding}" group:"Style Flags" env:"PADDING"`

    // Format
    Bold          bool `help:"Bold text" default:"${defaultBold}" group:"Style Flags" env:"BOLD"`
    Faint         bool `help:"Faint text" default:"${defaultFaint}" group:"Style Flags" env:"FAINT"`
    Italic        bool `help:"Italicize text" default:"${defaultItalic}" group:"Style Flags" env:"ITALIC"`
    Strikethrough bool `help:"Strikethrough text" default:"${defaultStrikethrough}" group:"Style Flags" env:"STRIKETHROUGH"`
    Underline     bool `help:"Underline text" default:"${defaultUnderline}" group:"Style Flags" env:"UNDERLINE"`

}

================================================
File: style/spacing.go
================================================
package style

import (
"strconv"
"strings"
)

const minTokens = 1
const halfTokens = 2
const maxTokens = 4

// parsePadding parses 1 - 4 integers from a string and returns them in a top,
// right, bottom, left order for use in the lipgloss.Padding() method.
func parsePadding(s string) (int, int, int, int) {
var ints [maxTokens]int

    tokens := strings.Split(s, " ")

    if len(tokens) > maxTokens {
    	return 0, 0, 0, 0
    }

    // All tokens must be an integer
    for i, token := range tokens {
    	parsed, err := strconv.Atoi(token)
    	if err != nil {
    		return 0, 0, 0, 0
    	}
    	ints[i] = parsed
    }

    if len(tokens) == minTokens {
    	return ints[0], ints[0], ints[0], ints[0]
    }

    if len(tokens) == halfTokens {
    	return ints[0], ints[1], ints[0], ints[1]
    }

    if len(tokens) == maxTokens {
    	return ints[0], ints[1], ints[2], ints[3]
    }

    return 0, 0, 0, 0

}

// parseMargin is an alias for parsePadding since they involve the same logic
// to parse integers to the same format.
var parseMargin = parsePadding

================================================
File: table/bom.csv
================================================
﻿"first_name","last_name","username"
"Rob","Pike",rob
Ken,Thompson,ken
"Robert","Griesemer","gri"

================================================
File: table/comma.csv
================================================
Bubble Gum,Price,Ingredients
Strawberry,$0.88,"Water,Sugar"
Guava,$1.00,"Guava Flavoring,Food Coloring,Xanthan Gum"
Orange,$0.99,"Sugar,Dextrose,Glucose"
Cinnamon,$0.50,"Cin""na""mon"

================================================
File: table/command.go
================================================
package table

import (
"encoding/csv"
"fmt"
"os"

    "github.com/charmbracelet/bubbles/help"
    "github.com/charmbracelet/bubbles/table"
    tea "github.com/charmbracelet/bubbletea"
    "github.com/charmbracelet/gum/internal/stdin"
    "github.com/charmbracelet/gum/internal/timeout"
    "github.com/charmbracelet/gum/style"
    "github.com/charmbracelet/lipgloss"
    ltable "github.com/charmbracelet/lipgloss/table"
    "golang.org/x/text/encoding"
    "golang.org/x/text/encoding/unicode"
    "golang.org/x/text/transform"

)

// Run provides a shell script interface for rendering tabular data (CSV).
func (o Options) Run() error {
var input \*os.File
if o.File != "" {
var err error
input, err = os.Open(o.File)
if err != nil {
return fmt.Errorf("could not render file: %w", err)
}
} else {
if stdin.IsEmpty() {
return fmt.Errorf("no data provided")
}
input = os.Stdin
}
defer input.Close() //nolint: errcheck

    transformer := unicode.BOMOverride(encoding.Nop.NewDecoder())
    reader := csv.NewReader(transform.NewReader(input, transformer))
    reader.LazyQuotes = o.LazyQuotes
    reader.FieldsPerRecord = o.FieldsPerRecord
    separatorRunes := []rune(o.Separator)
    if len(separatorRunes) != 1 {
    	return fmt.Errorf("separator must be single character")
    }
    reader.Comma = separatorRunes[0]

    writer := csv.NewWriter(os.Stdout)
    writer.Comma = separatorRunes[0]

    var columnNames []string
    var err error
    // If no columns are provided we'll use the first row of the CSV as the
    // column names.
    if len(o.Columns) <= 0 {
    	columnNames, err = reader.Read()
    	if err != nil {
    		return fmt.Errorf("unable to parse columns")
    	}
    } else {
    	columnNames = o.Columns
    }

    data, err := reader.ReadAll()
    if err != nil {
    	return fmt.Errorf("invalid data provided")
    }
    columns := make([]table.Column, 0, len(columnNames))

    for i, title := range columnNames {
    	width := lipgloss.Width(title)
    	if len(o.Widths) > i {
    		width = o.Widths[i]
    	}
    	columns = append(columns, table.Column{
    		Title: title,
    		Width: width,
    	})
    }

    defaultStyles := table.DefaultStyles()

    styles := table.Styles{
    	Cell:     defaultStyles.Cell.Inherit(o.CellStyle.ToLipgloss()),
    	Header:   defaultStyles.Header.Inherit(o.HeaderStyle.ToLipgloss()),
    	Selected: o.SelectedStyle.ToLipgloss(),
    }

    rows := make([]table.Row, 0, len(data))
    for row := range data {
    	if len(data[row]) > len(columns) {
    		return fmt.Errorf("invalid number of columns")
    	}

    	// fixes the data in case we have more columns than rows:
    	for len(data[row]) < len(columns) {
    		data[row] = append(data[row], "")
    	}

    	for i, col := range data[row] {
    		if len(o.Widths) == 0 {
    			width := lipgloss.Width(col)
    			if width > columns[i].Width {
    				columns[i].Width = width
    			}
    		}
    	}

    	rows = append(rows, table.Row(data[row]))
    }

    if o.Print {
    	table := ltable.New().
    		Headers(columnNames...).
    		Rows(data...).
    		BorderStyle(o.BorderStyle.ToLipgloss()).
    		Border(style.Border[o.Border]).
    		StyleFunc(func(row, _ int) lipgloss.Style {
    			if row == 0 {
    				return styles.Header
    			}
    			return styles.Cell
    		})

    	fmt.Println(table.Render())
    	return nil
    }

    opts := []table.Option{
    	table.WithColumns(columns),
    	table.WithFocused(true),
    	table.WithRows(rows),
    	table.WithStyles(styles),
    }
    if o.Height > 0 {
    	opts = append(opts, table.WithHeight(o.Height))
    }

    table := table.New(opts...)

    ctx, cancel := timeout.Context(o.Timeout)
    defer cancel()

    m := model{
    	table:     table,
    	showHelp:  o.ShowHelp,
    	hideCount: o.HideCount,
    	help:      help.New(),
    	keymap:    defaultKeymap(),
    }
    tm, err := tea.NewProgram(
    	m,
    	tea.WithOutput(os.Stderr),
    	tea.WithContext(ctx),
    ).Run()
    if err != nil {
    	return fmt.Errorf("failed to start tea program: %w", err)
    }

    if tm == nil {
    	return fmt.Errorf("failed to get selection")
    }

    m = tm.(model)
    if o.ReturnColumn > 0 && o.ReturnColumn <= len(m.selected) {
    	if err = writer.Write([]string{m.selected[o.ReturnColumn-1]}); err != nil {
    		return fmt.Errorf("failed to write col %d of selected row: %w", o.ReturnColumn, err)
    	}
    } else {
    	if err = writer.Write([]string(m.selected)); err != nil {
    		return fmt.Errorf("failed to write selected row: %w", err)
    	}
    }

    writer.Flush()

    return nil

}

================================================
File: table/example.csv
================================================
Bubble Gum Flavor,Price
Strawberry,$0.99
Cherry,$0.50
Banana,$0.75
Orange,$0.25
Lemon,$0.50
Lime,$0.50
Grape,$0.50
Watermelon,$0.50
Pineapple,$0.50
Blueberry,$0.50
Raspberry,$0.50
Cranberry,$0.50
Peach,$0.50
Apple,$0.50
Mango,$0.50
Pomegranate,$0.50
Coconut,$0.50
Cinnamon,$0.50

================================================
File: table/invalid.csv
================================================
Bubble Gum Flavor
Strawberry,$0.99
Cherry,$0.50
Banana,$0.75
Orange
Lemon,$0.50
Lime,$0.50
Grape,$0.50
Watermelon,$0.50
Pineapple,$0.50
Blueberry,$0.50
Raspberry,$0.50
Cranberry,$0.50
Peach,$0.50
Apple,$0.50
Mango,$0.50
Pomegranate,$0.50
Coconut,$0.50
Cinnamon,$0.50

================================================
File: table/options.go
================================================
package table

import (
"time"

    "github.com/charmbracelet/gum/style"

)

// Options is the customization options for the table command.
type Options struct {
Separator string `short:"s" help:"Row separator" default:","`
Columns []string `short:"c" help:"Column names"`
Widths []int `short:"w" help:"Column widths"`
Height int `help:"Table height" default:"0"`
Print bool `short:"p" help:"static print" default:"false"`
File string `short:"f" help:"file path" default:""`
Border string `short:"b" help:"border style" default:"rounded" enum:"rounded,thick,normal,hidden,double,none"`
ShowHelp bool `help:"Show help keybinds" default:"true" negatable:"" env:"GUM_TABLE_SHOW_HELP"`
HideCount bool `help:"Hide item count on help keybinds" default:"false" negatable:"" env:"GUM_TABLE_HIDE_COUNT"`
LazyQuotes bool `help:"If LazyQuotes is true, a quote may appear in an unquoted field and a non-doubled quote may appear in a quoted field" default:"false" env:"GUM_TABLE_LAZY_QUOTES"`
FieldsPerRecord int `help:"Sets the number of expected fields per record" default:"0" env:"GUM_TABLE_FIELDS_PER_RECORD"`

    BorderStyle   style.Styles  `embed:"" prefix:"border." envprefix:"GUM_TABLE_BORDER_"`
    CellStyle     style.Styles  `embed:"" prefix:"cell." envprefix:"GUM_TABLE_CELL_"`
    HeaderStyle   style.Styles  `embed:"" prefix:"header." envprefix:"GUM_TABLE_HEADER_"`
    SelectedStyle style.Styles  `embed:"" prefix:"selected." set:"defaultForeground=212" envprefix:"GUM_TABLE_SELECTED_"`
    ReturnColumn  int           `short:"r" help:"Which column number should be returned instead of whole row as string. Default=0 returns whole Row" default:"0"`
    Timeout       time.Duration `help:"Timeout until choose returns selected element" default:"0s" env:"GUM_TABLE_TIMEOUT"`

}

================================================
File: table/table.go
================================================
// Package table provides a shell script interface for the table bubble.
// https://github.com/charmbracelet/bubbles/tree/master/table
//
// It is useful to render tabular (CSV) data in a terminal and allows
// the user to select a row from the table.
//
// Let's render a table of gum flavors:
//
// $ gum table <<< "Flavor,Price\nStrawberry,$0.50\nBanana,$0.99\nCherry,$0.75"
//
// Flavor Price
// Strawberry $0.50
// Banana $0.99
// Cherry $0.75
package table

import (
"fmt"
"strconv"

    "github.com/charmbracelet/bubbles/help"
    "github.com/charmbracelet/bubbles/key"
    "github.com/charmbracelet/bubbles/table"
    tea "github.com/charmbracelet/bubbletea"

)

type keymap struct {
Navigate,
Select,
Quit,
Abort key.Binding
}

// FullHelp implements help.KeyMap.
func (k keymap) FullHelp() [][]key.Binding { return nil }

// ShortHelp implements help.KeyMap.
func (k keymap) ShortHelp() []key.Binding {
return []key.Binding{
k.Navigate,
k.Select,
k.Quit,
}
}

func defaultKeymap() keymap {
return keymap{
Navigate: key.NewBinding(
key.WithKeys("up", "down"),
key.WithHelp("↓↑", "navigate"),
),
Select: key.NewBinding(
key.WithKeys("enter"),
key.WithHelp("enter", "select"),
),
Quit: key.NewBinding(
key.WithKeys("esc", "ctrl+q", "q"),
key.WithHelp("esc", "quit"),
),
Abort: key.NewBinding(
key.WithKeys("ctrl+c"),
key.WithHelp("ctrl+c", "abort"),
),
}
}

type model struct {
table table.Model
selected table.Row
quitting bool
showHelp bool
hideCount bool
help help.Model
keymap keymap
}

func (m model) Init() tea.Cmd { return nil }

func (m model) countView() string {
if m.hideCount {
return ""
}

    padding := strconv.Itoa(numLen(len(m.table.Rows())))
    return m.help.Styles.FullDesc.Render(fmt.Sprintf(
    	"%"+padding+"d/%d%s",
    	m.table.Cursor()+1,
    	len(m.table.Rows()),
    	m.help.ShortSeparator,
    ))

}

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
var cmd tea.Cmd

    switch msg := msg.(type) {
    case tea.KeyMsg:
    	km := m.keymap
    	switch {
    	case key.Matches(msg, km.Select):
    		m.selected = m.table.SelectedRow()
    		m.quitting = true
    		return m, tea.Quit
    	case key.Matches(msg, km.Quit):
    		m.quitting = true
    		return m, tea.Quit
    	case key.Matches(msg, km.Abort):
    		m.quitting = true
    		return m, tea.Interrupt
    	}
    }

    m.table, cmd = m.table.Update(msg)
    return m, cmd

}

func (m model) View() string {
if m.quitting {
return ""
}
s := m.table.View()
if m.showHelp {
s += "\n" + m.countView() + m.help.View(m.keymap)
}
return s
}

func numLen(i int) int {
if i == 0 {
return 1
}
count := 0
for i != 0 {
i /= 10
count++
}
return count
}

================================================
File: version/command.go
================================================
package version

import (
"fmt"

    "github.com/Masterminds/semver/v3"
    "github.com/alecthomas/kong"

)

// Run check that a given version matches a semantic version constraint.
func (o Options) Run(ctx \*kong.Context) error {
c, err := semver.NewConstraint(o.Constraint)
if err != nil {
return fmt.Errorf("could not parse range %s: %w", o.Constraint, err)
}
current := ctx.Model.Vars()["versionNumber"]
v, err := semver.NewVersion(current)
if err != nil {
return fmt.Errorf("could not parse version %s: %w", current, err)
}
if !c.Check(v) {
return fmt.Errorf("gum version %q is not within given range %q", current, o.Constraint)
}
return nil
}

================================================
File: version/options.go
================================================
package version

// Options is the set of options that can be used with version.
type Options struct {
Constraint string `arg:"" help:"Semantic version constraint"`
}

================================================
File: write/command.go
================================================
package write

import (
"errors"
"fmt"
"os"
"strings"

    "github.com/charmbracelet/bubbles/help"
    "github.com/charmbracelet/bubbles/textarea"
    tea "github.com/charmbracelet/bubbletea"
    "github.com/charmbracelet/gum/cursor"
    "github.com/charmbracelet/gum/internal/stdin"
    "github.com/charmbracelet/gum/internal/timeout"

)

// Run provides a shell script interface for the text area bubble.
// https://github.com/charmbracelet/bubbles/textarea
func (o Options) Run() error {
in, \_ := stdin.Read(stdin.StripANSI(o.StripANSI))
if in != "" && o.Value == "" {
o.Value = strings.ReplaceAll(in, "\r", "")
}

    a := textarea.New()
    a.Focus()

    a.Prompt = o.Prompt
    a.Placeholder = o.Placeholder
    a.ShowLineNumbers = o.ShowLineNumbers
    a.CharLimit = o.CharLimit
    a.MaxHeight = o.MaxLines

    style := textarea.Style{
    	Base:             o.BaseStyle.ToLipgloss(),
    	Placeholder:      o.PlaceholderStyle.ToLipgloss(),
    	CursorLine:       o.CursorLineStyle.ToLipgloss(),
    	CursorLineNumber: o.CursorLineNumberStyle.ToLipgloss(),
    	EndOfBuffer:      o.EndOfBufferStyle.ToLipgloss(),
    	LineNumber:       o.LineNumberStyle.ToLipgloss(),
    	Prompt:           o.PromptStyle.ToLipgloss(),
    }

    a.BlurredStyle = style
    a.FocusedStyle = style
    a.Cursor.Style = o.CursorStyle.ToLipgloss()
    a.Cursor.SetMode(cursor.Modes[o.CursorMode])

    a.SetWidth(o.Width)
    a.SetHeight(o.Height)
    a.SetValue(o.Value)

    m := model{
    	textarea:    a,
    	header:      o.Header,
    	headerStyle: o.HeaderStyle.ToLipgloss(),
    	autoWidth:   o.Width < 1,
    	help:        help.New(),
    	showHelp:    o.ShowHelp,
    	keymap:      defaultKeymap(),
    }

    m.textarea.KeyMap.InsertNewline = m.keymap.InsertNewline

    ctx, cancel := timeout.Context(o.Timeout)
    defer cancel()

    p := tea.NewProgram(
    	m,
    	tea.WithOutput(os.Stderr),
    	tea.WithReportFocus(),
    	tea.WithContext(ctx),
    )
    tm, err := p.Run()
    if err != nil {
    	return fmt.Errorf("failed to run write: %w", err)
    }
    m = tm.(model)
    if !m.submitted {
    	return errors.New("not submitted")
    }
    fmt.Println(m.textarea.Value())
    return nil

}

================================================
File: write/options.go
================================================
package write

import (
"time"

    "github.com/charmbracelet/gum/style"

)

// Options are the customization options for the textarea.
type Options struct {
Width int `help:"Text area width (0 for terminal width)" default:"0" env:"GUM_WRITE_WIDTH"`
Height int `help:"Text area height" default:"5" env:"GUM_WRITE_HEIGHT"`
Header string `help:"Header value" default:"" env:"GUM_WRITE_HEADER"`
Placeholder string `help:"Placeholder value" default:"Write something..." env:"GUM_WRITE_PLACEHOLDER"`
Prompt string `help:"Prompt to display" default:"┃ " env:"GUM_WRITE_PROMPT"`
ShowCursorLine bool `help:"Show cursor line" default:"false" env:"GUM_WRITE_SHOW_CURSOR_LINE"`
ShowLineNumbers bool `help:"Show line numbers" default:"false" env:"GUM_WRITE_SHOW_LINE_NUMBERS"`
Value string `help:"Initial value (can be passed via stdin)" default:"" env:"GUM_WRITE_VALUE"`
CharLimit int `help:"Maximum value length (0 for no limit)" default:"0"`
MaxLines int `help:"Maximum number of lines (0 for no limit)" default:"0"`
ShowHelp bool `help:"Show help key binds" negatable:"" default:"true" env:"GUM_WRITE_SHOW_HELP"`
CursorMode string `prefix:"cursor." name:"mode" help:"Cursor mode" default:"blink" enum:"blink,hide,static" env:"GUM_WRITE_CURSOR_MODE"`
Timeout time.Duration `help:"Timeout until choose returns selected element" default:"0s" env:"GUM_WRITE_TIMEOUT"`
StripANSI bool `help:"Strip ANSI sequences when reading from STDIN" default:"true" negatable:"" env:"GUM_WRITE_STRIP_ANSI"`

    BaseStyle             style.Styles `embed:"" prefix:"base." envprefix:"GUM_WRITE_BASE_"`
    CursorLineNumberStyle style.Styles `embed:"" prefix:"cursor-line-number." set:"defaultForeground=7" envprefix:"GUM_WRITE_CURSOR_LINE_NUMBER_"`
    CursorLineStyle       style.Styles `embed:"" prefix:"cursor-line." envprefix:"GUM_WRITE_CURSOR_LINE_"`
    CursorStyle           style.Styles `embed:"" prefix:"cursor." set:"defaultForeground=212" envprefix:"GUM_WRITE_CURSOR_"`
    EndOfBufferStyle      style.Styles `embed:"" prefix:"end-of-buffer." set:"defaultForeground=0" envprefix:"GUM_WRITE_END_OF_BUFFER_"`
    LineNumberStyle       style.Styles `embed:"" prefix:"line-number." set:"defaultForeground=7" envprefix:"GUM_WRITE_LINE_NUMBER_"`
    HeaderStyle           style.Styles `embed:"" prefix:"header." set:"defaultForeground=240" envprefix:"GUM_WRITE_HEADER_"`
    PlaceholderStyle      style.Styles `embed:"" prefix:"placeholder." set:"defaultForeground=240" envprefix:"GUM_WRITE_PLACEHOLDER_"`
    PromptStyle           style.Styles `embed:"" prefix:"prompt." set:"defaultForeground=7" envprefix:"GUM_WRITE_PROMPT_"`

}

================================================
File: write/write.go
================================================
// Package write provides a shell script interface for the text area bubble.
// https://github.com/charmbracelet/bubbles/tree/master/textarea
//
// It can be used to ask the user to write some long form of text (multi-line)
// input. The text the user entered will be sent to stdout.
// Text entry is completed with CTRL+D and aborted with CTRL+C or Escape.
//
// $ gum write > output.text
package write

import (
"io"
"os"

    "github.com/charmbracelet/bubbles/help"
    "github.com/charmbracelet/bubbles/key"
    "github.com/charmbracelet/bubbles/textarea"
    tea "github.com/charmbracelet/bubbletea"
    "github.com/charmbracelet/lipgloss"
    "github.com/charmbracelet/x/editor"

)

type keymap struct {
textarea.KeyMap
Submit key.Binding
Quit key.Binding
Abort key.Binding
OpenInEditor key.Binding
}

// FullHelp implements help.KeyMap.
func (k keymap) FullHelp() [][]key.Binding { return nil }

// ShortHelp implements help.KeyMap.
func (k keymap) ShortHelp() []key.Binding {
return []key.Binding{
k.InsertNewline,
k.OpenInEditor,
k.Submit,
}
}

func defaultKeymap() keymap {
km := textarea.DefaultKeyMap
km.InsertNewline = key.NewBinding(
key.WithKeys("ctrl+j"),
key.WithHelp("ctrl+j", "insert newline"),
)
return keymap{
KeyMap: km,
Quit: key.NewBinding(
key.WithKeys("esc"),
key.WithHelp("esc", "quit"),
),
Abort: key.NewBinding(
key.WithKeys("ctrl+c"),
key.WithHelp("ctrl+c", "cancel"),
),
OpenInEditor: key.NewBinding(
key.WithKeys("ctrl+e"),
key.WithHelp("ctrl+e", "open editor"),
),
Submit: key.NewBinding(
key.WithKeys("enter"),
key.WithHelp("enter", "submit"),
),
}
}

type model struct {
autoWidth bool
header string
headerStyle lipgloss.Style
quitting bool
submitted bool
textarea textarea.Model
showHelp bool
help help.Model
keymap keymap
}

func (m model) Init() tea.Cmd { return textarea.Blink }

func (m model) View() string {
if m.quitting {
return ""
}

    var parts []string

    // Display the header above the text area if it is not empty.
    if m.header != "" {
    	parts = append(parts, m.headerStyle.Render(m.header))
    }
    parts = append(parts, m.textarea.View())
    if m.showHelp {
    	parts = append(parts, "", m.help.View(m.keymap))
    }
    return lipgloss.JoinVertical(lipgloss.Left, parts...)

}

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
switch msg := msg.(type) {
case tea.WindowSizeMsg:
if m.autoWidth {
m.textarea.SetWidth(msg.Width)
}
case tea.FocusMsg, tea.BlurMsg:
var cmd tea.Cmd
m.textarea, cmd = m.textarea.Update(msg)
return m, cmd
case startEditorMsg:
return m, openEditor(msg.path, msg.lineno)
case editorFinishedMsg:
if msg.err != nil {
m.quitting = true
return m, tea.Interrupt
}
m.textarea.SetValue(msg.content)
case tea.KeyMsg:
km := m.keymap
switch {
case key.Matches(msg, km.Abort):
m.quitting = true
return m, tea.Interrupt
case key.Matches(msg, km.Quit):
m.quitting = true
return m, tea.Quit
case key.Matches(msg, km.Submit):
m.quitting = true
m.submitted = true
return m, tea.Quit
case key.Matches(msg, km.OpenInEditor):
//nolint: gosec
return m, createTempFile(m.textarea.Value(), uint(m.textarea.Line())+1)
}
}

    var cmd tea.Cmd
    m.textarea, cmd = m.textarea.Update(msg)
    return m, cmd

}

type startEditorMsg struct {
path string
lineno uint
}

type editorFinishedMsg struct {
content string
err error
}

func createTempFile(content string, lineno uint) tea.Cmd {
return func() tea.Msg {
f, err := os.CreateTemp("", "gum.\*.md")
if err != nil {
return editorFinishedMsg{err: err}
}
_, err = io.WriteString(f, content)
if err != nil {
return editorFinishedMsg{err: err}
}
_ = f.Close()
return startEditorMsg{
path: f.Name(),
lineno: lineno,
}
}
}

func openEditor(path string, lineno uint) tea.Cmd {
cb := func(err error) tea.Msg {
if err != nil {
return editorFinishedMsg{
err: err,
}
}
bts, err := os.ReadFile(path)
if err != nil {
return editorFinishedMsg{err: err}
}
return editorFinishedMsg{
content: string(bts),
}
}
cmd, err := editor.Cmd(
"Gum",
path,
editor.LineNumber(lineno),
editor.EndOfLine(),
)
if err != nil {
return func() tea.Msg { return cb(err) }
}
return tea.ExecProcess(cmd, cb)
}

================================================
File: .github/CODEOWNERS
================================================

- @charmbracelet/everyone

================================================
File: .github/dependabot.yml
================================================
version: 2

updates:

- package-ecosystem: "gomod"
  directory: "/"
  schedule:
  interval: "weekly"
  day: "monday"
  time: "05:00"
  timezone: "America/New_York"
  labels:

  - "dependencies"
    commit-message:
    prefix: "chore"
    include: "scope"

- package-ecosystem: "github-actions"
  directory: "/"
  schedule:
  interval: "weekly"
  day: "monday"
  time: "05:00"
  timezone: "America/New_York"
  labels:

  - "dependencies"
    commit-message:
    prefix: "chore"
    include: "scope"

- package-ecosystem: "docker"
  directory: "/"
  schedule:
  interval: "weekly"
  day: "monday"
  time: "05:00"
  timezone: "America/New_York"
  labels:
  - "dependencies"
    commit-message:
    prefix: "feat"
    include: "scope"

================================================
File: .github/pull_request_template.md
================================================
Fixes #...

### Changes

-
-
-

================================================
File: .github/ISSUE_TEMPLATE/bug_report.md
================================================

---

name: Bug report
about: Create a report to help us improve
title: ''
labels: ''
assignees: ''

---

**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:

1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

**Expected behavior**
A clear and concise description of what you expected to happen.

**Screenshots**
If applicable, add screenshots to help explain your problem.

**Desktop (please complete the following information):**

- OS: [e.g. iOS]
- Browser [e.g. chrome, safari]
- Version [e.g. 22]

**Smartphone (please complete the following information):**

- Device: [e.g. iPhone6]
- OS: [e.g. iOS8.1]
- Browser [e.g. stock browser, safari]
- Version [e.g. 22]

**Additional context**
Add any other context about the problem here.

================================================
File: .github/ISSUE_TEMPLATE/feature_request.md
================================================

---

name: Feature request
about: Suggest an idea for this project
title: ''
labels: ''
assignees: ''

---

**Is your feature request related to a problem? Please describe.**
A clear and concise description of what the problem is. Ex. I'm always frustrated when [...]

**Describe the solution you'd like**
A clear and concise description of what you want to happen.

**Describe alternatives you've considered**
A clear and concise description of any alternative solutions or features you've considered.

**Additional context**
Add any other context or screenshots about the feature request here.

================================================
File: .github/workflows/build.yml
================================================
name: build

on: [push, pull_request]

jobs:
build:
strategy:
matrix:
os: [ubuntu-latest, macos-latest, windows-latest]
runs-on: ${{ matrix.os }}
env:
GO111MODULE: "on"
steps: - name: Install Go
uses: actions/setup-go@v5
with:
go-version: ~1.21

      - name: Checkout code
        uses: actions/checkout@v4

      - name: Download Go modules
        run: go mod download

      - name: Build
        run: go build -v ./...

      - name: Test
        run: go test -v -cover -timeout=30s ./...

snapshot:
uses: charmbracelet/meta/.github/workflows/snapshot.yml@main
secrets:
goreleaser_key: ${{ secrets.GORELEASER_KEY }}

dependabot:
needs: [build]
runs-on: ubuntu-latest
permissions:
pull-requests: write
contents: write
if: ${{ github.actor == 'dependabot[bot]' && github.event_name == 'pull_request'}}
    steps:
      - id: metadata
        uses: dependabot/fetch-metadata@v2
        with:
          github-token: "${{ secrets.GITHUB_TOKEN }}" - run: |
gh pr review --approve "$PR_URL"
          gh pr merge --squash --auto "$PR_URL"
env:
PR_URL: ${{github.event.pull_request.html_url}}
GITHUB_TOKEN: ${{secrets.GITHUB_TOKEN}}

================================================
File: .github/workflows/dependabot-sync.yml
================================================
name: dependabot-sync
on:
schedule: - cron: "0 0 \* \* 0" # every Sunday at midnight
workflow_dispatch: # allows manual triggering

permissions:
contents: write
pull-requests: write

jobs:
dependabot-sync:
uses: charmbracelet/meta/.github/workflows/dependabot-sync.yml@main
with:
repo_name: ${{ github.event.repository.name }}
secrets:
gh_token: ${{ secrets.PERSONAL_ACCESS_TOKEN }}

================================================
File: .github/workflows/goreleaser.yml
================================================

# yaml-language-server: $schema=https://json.schemastore.org/github-workflow.json

name: goreleaser

on:
push:
tags: - v*.*.\*

concurrency:
group: goreleaser
cancel-in-progress: true

jobs:
goreleaser:
uses: charmbracelet/meta/.github/workflows/goreleaser.yml@main
secrets:
docker_username: ${{ secrets.DOCKERHUB_USERNAME }}
docker_token: ${{ secrets.DOCKERHUB_TOKEN }}
gh_pat: ${{ secrets.PERSONAL_ACCESS_TOKEN }}
goreleaser_key: ${{ secrets.GORELEASER_KEY }}
fury_token: ${{ secrets.FURY_TOKEN }}
nfpm_gpg_key: ${{ secrets.NFPM_GPG_KEY }}
nfpm_passphrase: ${{ secrets.NFPM_PASSPHRASE }}
macos_sign_p12: ${{ secrets.MACOS_SIGN_P12 }}
macos_sign_password: ${{ secrets.MACOS_SIGN_PASSWORD }}
macos_notary_issuer_id: ${{ secrets.MACOS_NOTARY_ISSUER_ID }}
macos_notary_key_id: ${{ secrets.MACOS_NOTARY_KEY_ID }}
macos_notary_key: ${{ secrets.MACOS_NOTARY_KEY }}

================================================
File: .github/workflows/lint-soft.yml
================================================
name: lint-soft
on:
push:
pull_request:

permissions:
contents: read

# Optional: allow read access to pull request. Use with `only-new-issues` option.

pull-requests: read

jobs:
golangci:
name: lint-soft
runs-on: ubuntu-latest
steps: - name: Install Go
uses: actions/setup-go@v5
with:
go-version: ^1

      - uses: actions/checkout@v4
      - name: golangci-lint
        uses: golangci/golangci-lint-action@v6
        with:
          # Optional: golangci-lint command line arguments.
          args: --config .golangci-soft.yml --issues-exit-code=0
          # Optional: show only new issues if it's a pull request. The default value is `false`.
          only-new-issues: true

================================================
File: .github/workflows/lint.yml
================================================
name: lint
on:
push:
pull_request:

permissions:
contents: read

# Optional: allow read access to pull request. Use with `only-new-issues` option.

pull-requests: read

jobs:
golangci:
name: lint
runs-on: ubuntu-latest
steps: - name: Install Go
uses: actions/setup-go@v5
with:
go-version: ^1

      - uses: actions/checkout@v4
      - name: golangci-lint
        uses: golangci/golangci-lint-action@v6
        with:
          # Optional: golangci-lint command line arguments.
          #args:
          # Optional: show only new issues if it's a pull request. The default value is `false`.
          only-new-issues: true

================================================
File: .github/workflows/nightly.yml
================================================
name: nightly

on:
push:
branches: - main

jobs:
nightly:
uses: charmbracelet/meta/.github/workflows/nightly.yml@main
secrets:
docker_username: ${{ secrets.DOCKERHUB_USERNAME }}
docker_token: ${{ secrets.DOCKERHUB_TOKEN }}
goreleaser_key: ${{ secrets.GORELEASER_KEY }}
macos_sign_p12: ${{ secrets.MACOS_SIGN_P12 }}
macos_sign_password: ${{ secrets.MACOS_SIGN_PASSWORD }}
macos_notary_issuer_id: ${{ secrets.MACOS_NOTARY_ISSUER_ID }}
macos_notary_key_id: ${{ secrets.MACOS_NOTARY_KEY_ID }}
macos_notary_key: ${{ secrets.MACOS_NOTARY_KEY }}
