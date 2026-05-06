#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "Starting Postgres and Adminer..."
docker-compose up -d postgres adminer

echo "Waiting for Postgres to accept connections..."
until docker-compose exec -T postgres pg_isready -U postgres >/dev/null 2>&1; do
  sleep 1
done

echo "Postgres is ready."

echo "Building and starting landon-hotel container..."
docker-compose up -d --build landon-hotel

echo "Services status:"
docker-compose ps
