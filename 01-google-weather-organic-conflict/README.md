## Issues

### Weather answer box is incorrectly returned in `organic_results`

For `q=weather austin`, the Weather answer box heading is returned as an organic result:

```json
{
  "position": 1,
  "title": "Weather Result",
  "link": "#"
}
```

This result should not be present in `organic_results`.

### `People also ask` is incorrectly returned in `organic_results`

For `q=weather austin`, the `People also ask` section is returned as an organic result.

This section should not be present in `organic_results`.

### `Twitter Results` is incorrectly returned in `organic_results`

For `q=weather austin`, the `Twitter Results` section is returned as an organic result.

This section should not be present in `organic_results`.

### `Top stories` is incorrectly returned in `organic_results`

For `q=weather austin`, the `Top stories` section is returned as an organic result.

This section should not be present in `organic_results`.

### `organic_results.position` is not sequential after filtering invalid results

For `q=weather austin`, invalid non-organic sections are counted when assigning `organic_results.position`.

The first valid organic results currently have positions like:

```json
[1, 3, 4]
```

They should be sequential after excluding invalid sections:

```json
[1, 2, 3]
```

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
