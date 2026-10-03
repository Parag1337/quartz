#!/usr/bin/env bash

set -euo pipefail

script_path="${BASH_SOURCE[0]}"
while [ -L "$script_path" ]; do
  script_dir="$(cd -P "$(dirname "$script_path")" && pwd)"
  script_path="$(readlink "$script_path")"
  [[ "$script_path" != /* ]] && script_path="$script_dir/$script_path"
done

project_dir="$(cd -P "$(dirname "$script_path")" && pwd)"
cd "$project_dir"

npx quartz sync -m "Sync $(date '+%Y-%m-%d %H:%M:%S')"
