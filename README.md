[![GitPitch](https://gitpitch.com/assets/badge.svg)](https://gitpitch.com/mkoertgen/license.automation/master)

# license.automation

Automated license scanning for git repositories using

- [pivotal-legacy/LicenseFinder](https://github.com/pivotal-legacy/LicenseFinder) wrapped into REST and
- [ELK Stack](https://www.elastic.co/elk-stack) for dashboard visualization of the analyzed dependencies.

## Usage

Start using

```console
docker-compose up
```

Next, scan a project

```json
POST http://localhost:3000/api/scan
{
  "url": "https://github.com/awesome-inc/neo4j-decorator.git",
  "commit_id": "012abe3", // optional, default HEAD
  "format": "csv (default), json, html, markdown"
}
```

Or use a GitLab/GitHub webhook

```json
POST http://localhost:3000/api/github
{
  "after": "012abe3",
  "repository": {
    "clone_url": "https://github.com/awesome-inc/neo4j-decorator.git"
  }
}
```
