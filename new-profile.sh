#!/usr/bin/env sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <profile-name>"
  echo "  Create a profile named 'nvim-rust':"
  echo "  > $0 rust"
  exit 1
fi

set -eux

NAME="$1"
BASE_PATH=$(dirname "$0")

if [ -e "$BASE_PATH/nvim-$NAME" ]; then
  echo "Profile 'nvim-$NAME' already exists."
  exit 1
fi

cp -r "$BASE_PATH/template" "$BASE_PATH/nvim-$NAME"
pushd "$BASE_PATH"

make docs
make install

popd
