# homebrew-lane

A [Homebrew](https://brew.sh) tap for **[lane](https://github.com/mfeminer/lane)** — run
several pieces of work side by side, each in its own git worktree.

```bash
brew install mfeminer/lane/lane
```

That taps this repository and installs lane in one step. Afterwards:

```bash
brew upgrade lane
```

macOS on Apple silicon, Sonoma or newer. Homebrew refuses cleanly on anything else
rather than installing a binary that cannot run.

## What is in here

Just the formula. `Formula/lane.rb` points at a **specific** published release of lane
and carries that asset's `sha256` — never `releases/latest/download/...`, which has no
checksum that can stay true. Each new lane release needs the `url`, `version` and
`sha256` bumped here by hand.

There is no bottle-building workflow, deliberately: a bottle caches a compiled build,
and this formula compiles nothing — it installs a binary that lane's own CD already
built and published. The CI here does the thing that would actually catch a mistake,
which is install the formula and run the binary.

lane itself — what it does, how to use it, the source — lives at
**[mfeminer/lane](https://github.com/mfeminer/lane)**.

[MIT](LICENSE).
