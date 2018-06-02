# license.automation

Automated license scanning & dashboards for git repositories using

- [nexB/scancode-toolkit](https://github.com/nexB/scancode-toolkit) wrapped into a REST service.
- ...

## Usage

```console
curl -X POST http://localhost:5000 -H 'Content-Type: application/json' \
  -d '{ "source_url": "https://github.com/awesome-inc/FontAwesome.Sharp.git", "commit_id": "66a957aa9f993ff8779bc3cdbd3ff2fe9d40d81e" }'
```