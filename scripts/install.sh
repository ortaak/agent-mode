#!/usr/bin/env bash
# Installs or updates the agent-mode kit in a project (macOS / Linux / Git Bash).
#
# Usage:
#   ./install.sh /path/to/project           # first install
#   ./install.sh /path/to/project --update  # refresh kit files
#
# Kit files go to <project>/.agent-mode/ and are overwritten on update.
# Project files (AGENTS.md, CLAUDE.md, CHANGELOG.md, docs/) are created only
# when missing and are never overwritten.

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <project-path> [--update]" >&2
  exit 1
fi

TARGET="$1"
UPDATE="${2:-}"
KIT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
KIT_DEST="$TARGET/.agent-mode"

if [ ! -d "$TARGET" ]; then
  echo "Target directory does not exist: $TARGET" >&2
  exit 1
fi

if [ -d "$KIT_DEST" ] && [ "$UPDATE" != "--update" ]; then
  echo ".agent-mode already exists in $TARGET. Use --update to refresh it." >&2
  exit 1
fi

mkdir -p "$KIT_DEST"

# Copy kit contents, skipping VCS metadata
for item in "$KIT_ROOT"/* "$KIT_ROOT"/.[!.]*; do
  [ -e "$item" ] || continue
  name="$(basename "$item")"
  [ "$name" = ".git" ] && continue
  cp -R "$item" "$KIT_DEST/"
done

copy_if_missing() {
  local src="$1" dest="$2"
  if [ ! -e "$dest" ]; then
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    echo "  created  $dest"
  else
    echo "  kept     $dest (already exists)"
  fi
}

copy_if_missing "$KIT_ROOT/AGENTS.md" "$TARGET/AGENTS.md"
copy_if_missing "$KIT_ROOT/CLAUDE.md" "$TARGET/CLAUDE.md"
copy_if_missing "$KIT_ROOT/templates/project-state.md" "$TARGET/docs/project-state.md"

if [ ! -e "$TARGET/CHANGELOG.md" ]; then
  printf '# Changelog\n\nFormat: Keep a Changelog. Versioning: SemVer.\n\n## [Unreleased]\n' > "$TARGET/CHANGELOG.md"
  echo "  created  $TARGET/CHANGELOG.md"
else
  echo "  kept     $TARGET/CHANGELOG.md (already exists)"
fi

mkdir -p "$TARGET/docs/decisions"

echo ""
echo "agent-mode v$(tr -d '[:space:]' < "$KIT_ROOT/VERSION") installed in $TARGET"
echo "Next: fill in docs/project-state.md, then run .agent-mode/scripts/check.ps1 (or the project's own checks)"
