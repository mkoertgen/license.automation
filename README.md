# license.automation

Automated license scanning & dashboards for git repositories using already available
license detection tools wrapped into a REST service.

**Tools:**

- [pivotal-legacy/LicenseFinder](https://github.com/pivotal-legacy/LicenseFinder)
- ...

## Usage

Post directly to the license finder component:

```json
POST http://localhost:5000
{
  "source_url": "https://github.com/awesome-inc/neo4j-decorator.git",
  "commit_id": "012abe3", // optional, default HEAD
  "format": "csv (default), json, html, markdown"
}
```

Or use a GitLab/GitHub webhook:

```json
POST http://localhost:3000/hooks/github
{
  "after": "012abe3",
  "repository": {
    "clone_url": "https://github.com/awesome-inc/neo4j-decorator.git"
  }
}
```
