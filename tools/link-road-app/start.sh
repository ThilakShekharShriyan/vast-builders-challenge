#!/bin/bash
set -euo pipefail
WORKDIR=/tmp/link-road
rm -rf "$WORKDIR"
mkdir -p "$WORKDIR"
tar xzf /code/bundle.tgz -C "$WORKDIR"
cd "$WORKDIR/server"
npm install --omit=dev --no-audit --no-fund
cd "$WORKDIR"
export HOST="${HOST:-0.0.0.0}"
export PORT="${PORT:-8080}"
export APP_BASE="${APP_BASE:-/app}"
if [ -n "${VSS_URL:-}" ] && [ -z "${INGRESS_URL:-}" ]; then
  export INGRESS_URL="$VSS_URL"
fi
if [ -n "${VSS_USERNAME:-}" ] && [ -z "${USERNAME:-}" ]; then
  export USERNAME="$VSS_USERNAME"
fi
if [ -n "${VSS_PASSWORD:-}" ] && [ -z "${PASSWORD:-}" ]; then
  export PASSWORD="$VSS_PASSWORD"
fi
exec node server/src/index.js
