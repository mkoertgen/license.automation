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

### Options for Managing Open Source Licensing

- Do nothing |
- ![](https://i.imgflip.com/fhore.jpg)

---

### Options for Managing Open Source Licensing

- Do nothing
- Developer training and project planning |
- Post-development license analysis and correction |
- Periodic assessment |
- Real-time preventive assistance at the developer workstation |

Note:

- Do nothing: popular until recently, this option ignores the compliance issue because it carries the lowest up-front cost, but imposes the highest business risks and largest corrective costs as a product moves closer to launch.

- Developer training and project planning: many companies consider proper training and project planning sufficient in most cases, but it also carries increasing risk because of broadening software license diversity and the cost of developer training. Compliance depends solely on developers and there is consequently no reliable assurance of legal compliance before going to market.

- Post-development license analysis and correction: action taken late in the development cycle can take the form of external or internal audits, and impacts the final stages of testing and quality process. This option does not impact the development workflow and can be automated with software tools designed for this purpose. However, if license violations are discovered, this will prolong the project lifecycle and increase development cost.

- Periodic assessment: licensing analysis during development allows for corrections along the way if license violations are detected. This type of analysis can be automated and tends to be less expensive than post-development assessment since changes and re-tests are always easier to undertake earlier rather than later in the cycle.

- Real-time preventive assistance at the developer workstation: the most pro-active way of ensuring license compliance detects violations immediately and automatically at the developer workstation in real-time. The development process is not disturbed, and the cost of corrections is minimized, as any necessary corrections are done immediately without calling on external resources or requiring re-testing. The process can be automated using unobtrusive software tools that do not require developers to be trained in legal compliance. Managing licenses in real-time is generally the most cost efficient and lowest risk option.

---

### Types of Software Components

- Source Code |
- Dependencies |
- Services, Docker images, ...

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

### Questions?
