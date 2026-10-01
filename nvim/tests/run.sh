#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
state_dir=$(mktemp -d)
trap 'rm -rf "$state_dir"' EXIT
export XDG_STATE_HOME="$state_dir/state"
export NVIM_LOG_FILE="$state_dir/nvim.log"
for test_file in tests/syntax.lua tests/core.lua tests/java.lua tests/format.lua tests/clojure.lua tests/ui.lua tests/async.lua tests/treesitter.lua tests/tree.lua; do
  nvim --headless -u NONE -i NONE -l "$test_file"
done
