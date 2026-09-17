# homebrew-tap

A [Homebrew](https://brew.sh) tap for my projects.

```bash
brew install mfeminer/tap/lane
```

**Install by the full `mfeminer/tap/<formula>` name the first time.** Homebrew 6 will
not load a formula from a tap you have not trusted, and `brew tap` on its own does not
grant that trust — `brew tap mfeminer/tap && brew install lane` is refused with
*"Refusing to load formula from untrusted tap"*. Naming the formula in full is the
trust grant, and there is no prompt to answer. After that first install the short name
works for everything: `brew install lane`, `brew upgrade lane`.

## What is in it

### [lane](https://github.com/mfeminer/lane)

Run several pieces of work side by side, each in its own git worktree.

```bash
brew install mfeminer/tap/lane
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
