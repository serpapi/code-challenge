---
description: Check CI status
skill: NONE
---

# /ci

Check GitHub Actions CI status. Polls until complete.

Pipeline: rubocop → bundler-audit → rspec.

## Instructions

### 1. Run the status script

```bash
cd ~/projects/serp-van-gogh/serpapi-code-challenge
bin/claudes/ci-status
```

### 2. Evaluate output

**STATUS: no_runs** — No CI runs found. Ask: "Want to push, or check all recent runs?"

**STATUS: success** — All jobs passed.

**STATUS: failure** — Failed logs are in the output. Investigate and suggest a fix.

**STATUS: timeout** — CI still running after 15 minutes. Offer to check again.
