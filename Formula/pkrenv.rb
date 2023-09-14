class Pkrenv < Formula
  desc "Packer version manager"
  homepage "https://github.com/ha36d/pkrenv"
  url "https://github.com/ha36d/pkrenv/archive/refs/tags/v0.0.5.tar.gz"
  sha256 "b94d0110e1a4b32bd0de930e1afb4af4d3f99cd374e01ec638d496fc401846cd"
  license "MIT"
  head "https://github.com/ha36d/pkrenv.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  uses_from_macos "unzip"

  on_macos do
    depends_on "grep"
  end

  conflicts_with "packer", because: "pkrenv symlinks packer binaries"

  def install
    prefix.install %w[bin lib libexec share]
  end

  test do
    assert_match "v1.9.4", shell_output("#{bin}/pkrenv list-remote")
    with_env(PKRENV_PACKER_VERSION: "v1.9.4", PKRENV_AUTO_INSTALL: "false") do
      assert_equal "v1.9.4", shell_output("#{bin}/pkrenv version-name").strip
    end
  end
end
