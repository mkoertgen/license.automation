@title[Introduction]

### Automated License Complicance Analysis

---

### Are we legal?

![How to keep track](https://memegen.link/noidea/how_to_keep_track../...of_all_my_dependencies~q.jpg?watermark=none)

---

### Are we legal?

![I need a tracker](http://m.memegen.com/hnrsmk.jpg)

---

### [The Cost of Open Source Licensing Compliance](http://www.industryweek.com/software-amp-systems/cost-open-source-licensing-compliance)

> Proper licensing and copyright compliance, implemented
> as part of the normal QA process, can yield savings of
> between and 40% and 65%, relative to the potential costs
> of non-compliance.

---

### Some Terminology

- [Software Asset Management (SAM)](https://www.gartner.com/reviews/market/software-asset-management-tools)
- [Software Composition Analysis (SCA)](https://resources.whitesourcesoftware.com/blog-whitesource/software-composition-security-analysis)

---

### Managing Open Source Licensing

- Do nothing |
- Developer training and project planning |
- Post-development license analysis and correction |
- Periodic assessment |
- Real-time preventive assistance at the developer workstation |

---

### Types of Software Components

- Source Code |
- Dependencies |
- Services, Docker images, ... |

---

### Deep Code Scanning

**Example:** Scan for license notice, similar code (active research)

```c++
This file is part of Foobar.

Foobar is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
...
```

---

### Some Code Scanners

- [nexB/scancode-toolkit](https://github.com/nexB/scancode-toolkit)
- [AboutCode.Org](https://www.aboutcode.org/)
- [Ninka](http://ninka.turingmachine.org/)

---

### Dependency Scanning

- [FOSSA](https://fossa.io/)
- [pivotal-legacy/LicenseFinder](https://github.com/pivotal-legacy/LicenseFinder)

---

## Demo

+++

### STEP 1. Deploy license scanner

Using git

```console
git clone https://github.com/mkoertgen/license.automation.git
cd license.automation
docker-compose up -d
```

@[1-2](Clone repository)
@[3](Startup containers)

+++

### STEP 2. Add webhook

**For Github**, goto _Settings -> Webhook -> Add webhook_

![Github Webhook](assets/image/github_webhook.jpg)

+++

### STEP 2. Add webhook

**For Gitlab**, goto _Settings -> Integration_

![Github Webhook](assets/image/github_webhook.jpg)

+++

### STEP 3. Visit license dashboard

Review licenses in [Kibana dashboard](http://localhost:5601)

![License Dashboard](assets/image/dashboard.jpg)

---

### Costs to Detect and Fix Licensing Policy Violations

- @color[red]($20,000 avg. cost) of licensing non-compliance discovered in the field. |
- @color[yellow]($1,500 avg. cost) of licensing non-compliance discovered during quality assurance. |
- @color[green]($40 avg. cost) to fix a policy violation discovered at the developer's workstation. |

---

### Observations from Analysis Scenarios

- The larger the project, the higher the probability of compliance violations. |
- Ignoring licensing compliance can be costly, and it is difficult to put an upper limit on the cost of shipping non-compliant software. |
- Corrective analysis, using automated tools at regular intervals and during QA reduces the overall cost significantly. |

---

### Questions?

<br>

@fa[twitter gp-contact](@mkoertg)

@fa[github gp-contact](mkoertgen)

@fa[medium gp-contact](@marcel.koertgen)
