#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	CREATE DATABASE weteling_dev;
  CREATE DATABASE weteling_test;
EOSQL
	
pg_restore -d weteling_dev --disable-triggers --no-acl --no-owner --username=postgres /docker-entrypoint-initdb.d/live.pgdump