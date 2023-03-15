# Usage

To use this run:

```
   bin/extract <path-to-file>

   # Or with jq

   bin/extract my_file.html | jq '.'
```

By default it uses chrome to render the HTML. You can specify the chrome bin path

```
   bin/extract --chrome-path <path> <path-to-file>
```

## Setup

To setup the code run

```
   bin/setup
```
