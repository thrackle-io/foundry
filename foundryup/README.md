# Thrackle.io's `foundryup`

Update or revert to a specific Foundry version, commit, or branch with ease.

> [!NOTE]
> This repository contains minor modifications to `foundryup` enabling `foundryup --version` 
> to download precompiled binaries from the [thrackle-io/foundry](https://github.com/thrackle-io/foundry) repository.
> This repository provides weekly _versioned releases_ which attach unmodified binaries from [foundry-rs/foundry](https://github.com/foundry-rs/foundry/releases).

## Installing

```sh
mkdir -p $HOME/.foundry/bin/
FOUNDRY_DIR=$HOME/.foundry
echo "export PATH=$HOME/.foundry/bin:$PATH" >> ~/.zshrc # or ~/.bashrc, etc.

curl -sSL https://raw.githubusercontent.com/thrackle-io/foundry/refs/heads/master/foundryup/foundryup -o $FOUNDRY_DIR/bin/foundryup
chmod +x $FOUNDRY_DIR/bin/foundryup
```

## Usage

To install the **latest** release version:

```sh
foundryup
```

To install a specific **version** (in this case the `v0.2.0` version):

```sh
foundryup --version v0.2.0
# The "v" prefix is optional:
foundryup --version 0.2.0
```

To install the version set in `foundry.lock`:

Awk is used to ignore comments.

```sh
foundryup --version $(awk '$1~/^[^#]/' foundry.lock)
```

To install a specific **branch** (in this case the `release/0.1.0` branch's latest commit):

```sh
foundryup --branch release/0.1.0
```

To install a **fork's main branch** (in this case `transmissions11/foundry`'s main branch):

```sh
foundryup --repo transmissions11/foundry
```

To install a **specific branch in a fork** (in this case the `patch-10` branch's latest commit in `transmissions11/foundry`):

```sh
foundryup --repo transmissions11/foundry --branch patch-10
```

To install from a **specific Pull Request**:

```sh
foundryup --pr 1071
```

To install from a **specific commit**:

```sh
foundryup -C 94bfdb2
```

To install a local directory or repository (e.g. one located at `~/git/foundry`, assuming you're in the home directory)

##### Note: --branch, --repo, and --version flags are ignored during local installations.

```sh
foundryup --path ./git/foundry
```

---

**Tip**: All flags have a single character shorthand equivalent! You can use `-v` instead of `--version`, etc.

---
