class Vibranium < Formula
  desc "Functional, contract and load tests for HTTP APIs, written as YAML"
  homepage "https://v007m.github.io/vc-rs/"
  license "Apache-2.0"
  head "https://github.com/v007m/vc-rs.git", branch: "master"

  depends_on "node" => :build
  depends_on "pnpm" => :build
  depends_on "rust" => :build

  def install
    system "pnpm", "install", "--frozen-lockfile", "--filter", "web"
    system "pnpm", "--filter", "web", "run", "build"
    system "cargo", "install", *std_cargo_args(path: "crates/apps/cli"), "--features", "web-ui", "--bin", "vc"
    system "cargo", "install", *std_cargo_args(path: "crates/apps/demo")
    bin.install_symlink "vc" => "vibranium"
  end

  test do
    assert_match "vc", shell_output("#{bin}/vc --version")
    assert_match "vc", shell_output("#{bin}/vibranium --version")
    assert_match "ui", shell_output("#{bin}/vc ui --help")
    system bin/"vc", "--project", testpath/"shop", "init"
    assert_path_exists testpath/"shop/vibranium.config.yaml"
    system bin/"vc", "--project", testpath/"shop", "check"
  end
end
