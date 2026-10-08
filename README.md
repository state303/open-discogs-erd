[//]: # ( {x-release-please-start-version} )
# Open Discogs Project ERD v2.0.0
[//]: # ( {x-release-please-end} )

Historical DBML and SQL schema diagrams for OpenDiscogs. The published diagram
is available at [dbdocs](https://dbdocs.io/state303/OpenDiscogs).

Current PostgreSQL migrations and generated Go and Java models live in
[open-discogs-model](https://github.com/dsub-io/open-discogs-model). Use those
migrations to initialize or upgrade a deployment. The SQL exports in this
repository are historical snapshots and may differ from the current model.

For new deployments, use [Go OpenDiscogs Batch](https://github.com/dsub-io/go-open-discogs-batch)
to import monthly dumps and [Go OpenDiscogs API](https://github.com/dsub-io/go-open-discogs-api)
to query the imported catalog.

## Files and publishing

- `database.dbml` defines this repository's diagram.
- `postgres.sql` and `mysql.sql` are historical SQL exports.
- `prepend.py` embeds this README and the changelog into the published DBML.

Changes to publication inputs on `main` publish the main diagram; changes on
`beta` publish the beta diagram. A release workflow completing does not trigger
a second publication. Manual publication must run on the matching branch.

See [CI and contributions](docs/ci.md) for PR verification.
