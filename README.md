## Working of the project

To extract the data from the HTML pages, cheerio library is used. It
is a fast, flexible & lean implementation of core jQuery designed
specifically for the server. It is used to traverse the DOM and
extract the data from the HTML pages.

The project uses Jest for testing. Jest is a JavaScript testing and
has been used to test the functions of the project.

## Running the project

1. To run the project, clone the repository by running the following
   command in the terminal:

```bash
git clone https://github.com/sbansal1999/code-challenge
```

2. After cloning the repository, move to the `src` directory and
   install the dependencies by running the following command:

```bash
npm install
```

3. After installing the dependencies, run the following command to run
   the project:

```bash
npm start
```

4.  After running the above command, the data will be extracted from
    `files/van-gogh-paintings.html` and will be stored in the
    `src/result.json` file.

5.  To run the tests, run the following command:

```bash
npm test
```
