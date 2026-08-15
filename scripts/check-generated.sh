#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

python3 "$project_dir/scripts/generate_ts_schema.py"

if ! git -C "$project_dir" diff --exit-code -- \
  src/config/generatedConfigSchema.ts \
  py_modules/lsfg_vk/config_schema_generated.py; then
  echo "Generated configuration bindings are stale. Regenerate and commit them." >&2
  exit 1
fi

echo "Generated configuration bindings are current."
