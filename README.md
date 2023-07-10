# Step by Step Instructions to run the Challenge Solution and Test Script
## Note that this Technical Challenge was completed using Python and Pytest.

Depending on how the user intends to run the solution. Firstly clone the Repo as the case may be and on successful cloning of the Repo,
into users' local environment, run the `pip install -r requirements.txt` to install all the dependencies to enable a smooth running of the scripts.

To get started, it is important that the user should have Python already Installed alongside the installation requirements file as instructed above.
Activate a virtual environment by running `source serp\bin\activate` while assuming the user is using a MacOS or Linux.
Ideally, the virtual environment should be activated automatically but when it doesn't use the command issued above.

To run the solution use the command `python3 main.py <html_file_path>`. The `html_file_path` is the HTML file to be scrapped.
For example `python3 main.py woman_art.html` and should display the necessary data as expected.

To run the unit test on the script `main.py`, all the user needs to do is to run the `pytest` command from the terminal,
and that should give a 100% pass rate based on the tested output.

---

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
