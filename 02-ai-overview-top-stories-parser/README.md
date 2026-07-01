## Issues

### AI Overview paragraph is cut off in `ai_overview.text_blocks`

Current parsed snippet:

```text
The United States and Iran have reached an interim memorandum of understanding to end hostilities, though technical negotiations continue in Switzerland
```

The paragraph continues in the HTML and should include the full sentence that follows:

```text
While a roadmap for a final deal within 60 days has been established, disputes remain over nuclear inspections and control of the Strait of Hormuz.
```

### Top Stories carousel is missing from `ai_overview`

The current parsed result includes the AI Overview text content, but it does not include those news cards as `ai_overview.top_stories`.

## Setup

```bash
bundle install
bundle exec rspec
```

If gems are already installed globally:

```bash
rspec
```

## Manual parser execution

```bash
./bin/parse
```