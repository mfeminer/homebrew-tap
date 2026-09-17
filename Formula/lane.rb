class Lane < Formula
  desc "Run several pieces of work side by side, each in its own git worktree"
  homepage "https://github.com/mfeminer/lane"
  # Pinned to a specific release, never releases/latest/download/... — a moving
  # pointer cannot have a sha256 that stays true, and Homebrew's own rule for
  # versioned, verifiable sources applies here on principle even though a
  # personal tap is never reviewed.
  url "https://github.com/mfeminer/lane/releases/download/v0.1.3/lane-macos-arm64"
  sha256 "68dba215ae4c73f478da7c3ac0a01688eea1b088e4522c8c4bf2d3feb8a0f5ab"
  version "0.1.3"
  license "MIT"

  # Sonoma is not a guess. lane is a PyInstaller one-file binary: its bootloader
  # is built for macOS 11, but every Python extension module it carries inside
  # reports minos 14.0 (`vtool -show-build`), because CD builds on a macos-14
  # runner. The payload is the binding constraint, so 14 is the floor.
  depends_on macos: :sonoma
  # Only macOS on Apple silicon is released today. Without this, Homebrew would
  # happily install an arm64 binary on an Intel Mac and the failure would only
  # show up when someone ran it.
  depends_on arch: :arm64

  def install
    bin.install "lane-macos-arm64" => "lane"

    # The released binary is not notarised. Homebrew fetches formula sources with
    # its own curl and does not quarantine them the way it quarantines casks, so
    # in practice there is nothing to strip here — verified by inspecting the
    # staged download during a real `brew install`. It is still done, because the
    # cost is one no-op call and the alternative is brew being the one install
    # path that leaves someone running `xattr` by hand. `quiet_system` rather than
    # `system`: `xattr -d` exits non-zero when the attribute is absent, which is
    # the normal case, and `system` would turn that into a failed install.
    quiet_system "xattr", "-d", "com.apple.quarantine", bin/"lane"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lane --version")
    assert_match "lane", shell_output("#{bin}/lane --help")
  end
end
