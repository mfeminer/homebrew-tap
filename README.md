# homebrew-tap

A [Homebrew](https://brew.sh) tap for my projects.

```bash
brew tap mfeminer/tap
```

Once, and every formula below installs by its own name from then on.

## What is in it

### [lane](https://github.com/mfeminer/lane)

Run several pieces of work side by side, each in its own git worktree.

```bash
brew install lane          # after `brew tap mfeminer/tap`
brew install mfeminer/tap/lane   # or in one command, without tapping first
```

`brew upgrade lane` from then on. macOS on Apple silicon, Sonoma or newer —
Homebrew refuses cleanly on anything else rather than installing a binary that
cannot run.

## How the formulae here work

Each one points at a **specific** published release and carries that asset's
`sha256` — never `releases/latest/download/...`, which has no checksum that can stay
true, and which `brew audit` flags regardless of a personal tap never being reviewed.
A new upstream release means bumping the `url` and `sha256` here by hand.

There is no bottle-building workflow, deliberately: a bottle caches a *compiled*
build, and nothing here compiles — these formulae install binaries that each
project's own CD already built and published. The scaffolding `brew tap-new` writes
by default would exercise nothing real. What CI here does instead is install every
formula and run what it installed, which is what actually catches a rotted URL or a
stale checksum — before somebody else does.

[MIT](LICENSE).
