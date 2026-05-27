# Extract Van Gogh Paintings Code Challenge

Goal is to extract a list of Van Gogh paintings from the attached Google search results page.

![Van Gogh paintings](https://github.com/serpapi/code-challenge/blob/master/files/van-gogh-paintings.png?raw=true "Van Gogh paintings")

## Instructions

This is already fully supported on SerpApi. ([relevant test], [html file], [sample json], and [expected array].)
Try to come up with your own solution and your own test.
Extract the painting `name`, `extensions` array (date), and Google `link` in an array.

Fork this repository and make a PR when ready.

Programming language wise, Ruby (with RSpec tests) is strongly suggested but feel free to use whatever you feel like.

Parse directly the HTML result page ([html file]) in this repository. No extra HTTP requests should be needed for anything.

[relevant test]: https://github.com/serpapi/test-knowledge-graph-desktop/blob/master/spec/knowledge_graph_claude_monet_paintings_spec.rb
[sample json]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.json
[html file]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html
[expected array]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/expected-array.json

Add also to your array the painting thumbnails present in the result page file (not the ones where extra requests are needed). 

Test against 2 other similar result pages to make sure it works against different layouts. (Pages that contain the same kind of carrousel. Don't necessarily have to be paintings.)

The suggested time for this challenge is 4 hours. But, you can take your time and work more on it if you want.

## Solution (Python)

Two implementations are provided:
- `hardcoded_solution.py` — uses CSS class names to find carousel cards
- `generalized_solution.py` — uses `&stick=` in the href + leaf nodes

### Setup

```bash
# create virtual environment inside the repo
python3 -m venv venv

# activate it (do this once per terminal session)
source venv/bin/activate

# install dependencies
pip install -r requirements.txt
```

### Run a solution

```bash
python hardcoded_solution.py
python generalized_solution.py
```

### Run tests

```bash
# run all tests
pytest test_solutions.py -v

# run without activating venv
venv/bin/pytest test_solutions.py -v

# run a single specific test
pytest test_solutions.py::test_generalized_beatles -v
```
