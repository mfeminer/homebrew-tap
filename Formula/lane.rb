class Lane < Formula
  desc "Run several pieces of work side by side, each in its own git worktree"
  homepage "https://github.com/mfeminer/lane"
  # Pinned to a specific release, never releases/latest/download/... — a moving
  # pointer has no sha256 that can stay true, and Homebrew's own rule for
  # versioned, verifiable sources applies on principle even though a personal tap
  # is never reviewed. There is deliberately no `version` line: brew scans 0.1.3
  # out of this URL, and stating it again is a second copy of the number that can
  # disagree with the first (`brew audit --strict` rejects it).
  url "https://github.com/mfeminer/lane/releases/download/v0.1.3/lane-macos-arm64"
  sha256 "68dba215ae4c73f478da7c3ac0a01688eea1b088e4522c8c4bf2d3feb8a0f5ab"
  license "MIT"

  # Only macOS on Apple silicon is released today. Without this, Homebrew would
  # install an arm64 binary on an Intel Mac and the failure would not show up
  # until someone ran it.
  depends_on arch: :arm64
  # Sonoma is not a guess. lane is a PyInstaller one-file binary: its bootloader
  # is built for macOS 11, but all 57 Python extension modules it carries inside
  # report minos 14.0 (`vtool -show-build`), because CD builds on a macos-14
  # runner. The payload is the binding constraint, so 14 is the floor.
  depends_on macos: :sonoma

  def install
    bin.install "lane-macos-arm64" => "lane"

    # The released binary is not notarised. Homebrew fetches formula sources with
    # its own curl and does not quarantine them the way it quarantines casks, so
    # in practice there is nothing to strip — verified by inspecting both the
    # cached download and the installed file after a real `brew install`, neither
    # of which carried any xattr at all. It is still done, because the cost is one
    # no-op call and the alternative is brew being the one install path that
    # leaves someone running `xattr` by hand.
    #
    # `quiet_system` rather than `system`, and that distinction is the whole point:
    # `xattr -d` exits non-zero when the attribute is absent, which is the normal
    # case here, so `system` would fail every single install.
    quiet_system "xattr", "-d", "com.apple.quarantine", bin/"lane"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lane --version")
    assert_match "worktree", shell_output("#{bin}/lane --help")
  end
end
