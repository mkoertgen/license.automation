# license.automation

Automated license scanning & dashboards for git repositories using already available
license detection tools wrapped into a REST service.

**Tools:**

- [pivotal-legacy/LicenseFinder](https://github.com/pivotal-legacy/LicenseFinder)
- [nexB/scancode-toolkit](https://github.com/nexB/scancode-toolkit)
- ...

## Usage

```console
curl -X POST \
  http://localhost:5000 \
  -H 'Content-Type: application/json' \
  -d '{
  "source_url": "https://github.com/awesome-inc/neo4j-decorator.git",
  "commit_id": "012abe3"
}'
```

**Request format:**

```json
{
  "source_url": "https://github.com/awesome-inc/neo4j-decorator.git",
  "commit_id": "012abe3",
  "format": "csv (default), json, html, markdown",
  "install": "yarn (default), npm install, bundle install, nuget restore, ..."
}
```