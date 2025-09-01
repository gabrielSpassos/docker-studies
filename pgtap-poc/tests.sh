#!/usr/bin/env bash
set -euo pipefail

docker exec -it pgdb bash -c "pg_prove -d testdb -U testuser /tests/*.sql"
