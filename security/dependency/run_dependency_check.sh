#!/usr/bin/env bash
# OWASP Dependency-Check scanner
set -euo pipefail
export MSYS_NO_PATHCONV=1

TARGET="${1:?Usage: $0 <target-dir> <output-dir>}"
OUT="${2:?Usage: $0 <target-dir> <output-dir>}"

mkdir -p "$OUT"
TARGET="$(cd "$TARGET" && pwd)"
OUT="$(cd "$OUT" && pwd)"
PROJECT="${PROJECT_NAME:-devsecops-project}"

DATA_DIR="${DEPENDENCY_CHECK_DATA_DIR:-$HOME/.dependency-check-data}"
mkdir -p "$DATA_DIR"
DATA_DIR="$(cd "$DATA_DIR" && pwd)"

EXTRA=()
if [ -n "${NVD_API_KEY:-}" ]; then
  EXTRA+=(--nvdApiKey "$NVD_API_KEY")
else
  echo "WARNING: NVD_API_KEY is not configured; database updates may be slow."
fi

if command -v dependency-check.sh >/dev/null 2>&1; then
  dependency-check.sh --project "$PROJECT" --scan "$TARGET" --format JSON --out "$OUT" "${EXTRA[@]}"
elif command -v dependency-check >/dev/null 2>&1; then
  dependency-check --project "$PROJECT" --scan "$TARGET" --format JSON --out "$OUT" "${EXTRA[@]}"
else
  echo "Dependency-Check not installed - using Docker."
  echo "Using database cache directory: $DATA_DIR"
  docker run --rm \
    -v "$TARGET:/src" \
    -v "$OUT:/report" \
    -v "$DATA_DIR:/usr/share/dependency-check/data" \
    owasp/dependency-check \
    --project "$PROJECT" --scan /src --format JSON --out /report "${EXTRA[@]}"
fi
