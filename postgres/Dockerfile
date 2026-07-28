# Plain Postgres 17, ready for bootcamp SQL practice.
# Bumped from 16 -> 17 to match the remote course database's server version
# (17.9), so pg_dump/pg_restore run from this container work without a
# version-mismatch error.
# Kept as its own Dockerfile (instead of using the official image directly
# in docker-compose.yml) so you can bake in extras later if needed
# (extensions, locale tweaks, preloaded seed data, etc.).
FROM postgres:17

# Example of what you could add later:
# COPY init-scripts/ /docker-entrypoint-initdb.d/
# RUN apt-get update && apt-get install -y postgresql-16-postgis-3
