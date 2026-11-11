class Vibranium < Formula
  desc "Functional, contract and load tests for HTTP APIs, written as YAML"
  homepage "https://v007m.github.io/vc-rs/"
  license "Apache-2.0"
  head "https://github.com/v007m/vc-rs.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/apps/cli")
    system "cargo", "install", *std_cargo_args(path: "crates/apps/demo")
    bin.install_symlink "vc" => "vibranium"
  end

  test do
    assert_match "vc", shell_output("#{bin}/vc --version")
    assert_match "vc", shell_output("#{bin}/vibranium --version")
    system bin/"vc", "--project", testpath/"shop", "init"
    assert_path_exists testpath/"shop/vibranium.config.yaml"
    system bin/"vc", "--project", testpath/"shop", "check"
  end
end
