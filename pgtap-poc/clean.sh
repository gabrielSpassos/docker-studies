#!/usr/bin/env bash
set -euo pipefail

# Go to the script's directory (so docker-compose.yml is found)
cd "$(dirname "$0")"

echo "🚀 Stopping and removing containers, networks, and volumes..."
docker compose down -v --remove-orphans

echo "🧹 Pruning dangling images (optional)..."
docker image prune -f

echo "✅ Cleanup complete."
