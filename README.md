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

Next, see the analyzed packages in the [Kibana dashboard](http://localhost:5601).

![License Dashboard](assets/image/dashboard.jpg)

## Continuous License Analysis

To analyze depency licenses in an automated fashion, host/deploy the scanner and add the webhook to your projects.

You will need the scanner deployed somewhere where Github/Gitlab can post the _Push Event Payload_ to.

**For Github**, goto _Settings -> Webhook -> Add webhook_ and enter the url to the scanner

![Github Webhook](assets/image/github_webhook.jpg)

**For Gitlab**, goto _Settings -> Integration_ and enter the url to the scanner

![Github Webhook](assets/image/github_webhook.jpg)
