#!/usr/bin/env bash

set -ex

################################################################################
# Tests for crate-crypto/Ed448-Goldilocks
################################################################################
git clone https://github.com/divergentdave/Ed448-Goldilocks.git --branch=fiat-crypto-0.2 Ed448-Goldilocks || exit $?

pushd Ed448-Goldilocks >/dev/null || exit $?
git checkout 31a5230b8635fff6f4d118a1d36ac85d531d3c56 || exit $?

mv Cargo.toml Cargo.toml.old
head -n -3 Cargo.toml.old > Cargo.toml
cat >> Cargo.toml <<EOF

[patch.crates-io]
fiat-crypto = { path = "../fiat-rust" }
EOF

cargo test --features="fiat_u64_backend" --no-default-features || exit $?

popd >/dev/null
