# v007m/homebrew-tap

Homebrew formulae for [Vibranium](https://v007m.github.io/vc-rs/) (`vc`), the API testing CLI.

```sh
brew install --HEAD v007m/tap/vibranium
vc --version
```

Until the first release is tagged, the formula builds `vc` and `vc-demo` from `master` (`--HEAD`). After that, `brew install v007m/tap/vibranium` installs the tagged release. Either way it also links `vibranium` to `vc`.
