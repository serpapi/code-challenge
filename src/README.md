## Implementation: Extract Van Gogh Paintings Code Challenge

This is my implementation of the requested code challenge. I used Node.js and JavaScript.

## Instructions

After downloading or cloning this repository, install the dependencies with `npm install`. The following are necessary for recreating the environment:

- `.env` file containing `PORT=YOUR_PORT_HERE` placed in the topmost folder. YOUR_PORT_HERE should be your preferred port for running the server.
- Node.js installed with version 20.6.0 or newer. This version is when they introduced reading native .env files instead of requiring external libraries like `dotenv`.

These command line scripts are available:

```sh
npm run test // Runs the test suites
npm run start // Starts the Node.js server
npm run write // Writes the Van Gogh Paintings into a JSON file in the src folder
```

## File Structure

These are new folders/files and a summary of what each one was intended for.

- `src/tests/`: Contains test suite files. `tests/common.spec.js` contains the tests that run for each webpage.
- `src/app.js`: Sets up the server for hosting static HTML files.
- `src/array.json`: Contains the JSON output after scraping the Van Gogh Paintings file.
- `src/script.js`: Exports the main functions for scraping the webpages.
- `src writeFile.js`: Imports the scraping functions to create the `array.json` file.

## Dependencies

I tried minimizing the number of external libraries used in my solution. Here's the ones used in my solution and what each one was used for:

- express: Creates a server for hosting the static webpages found in the `files` folder.
- jsdom: Creates a DOM-like object that can be manipulated in Node.js. Since Node.js is not a browser environment, it would be difficult to parse or interact with elements in the HTML otherwise.
- jest: Used for testing.
- nodemon: It's a "node monitor". Refreshes the Node.js server whenever file changes are detected. Helpful since I wouldn't need to keep restarting the server when I make changes.
- supertest: Used for testing, but specifically for testing that the server is receiving and sending requests correctly.

## Issues

- I could not get the image links to be exactly as expected. But, I have a probable reason for what my issue could be:

  - From what I can tell, the images have a placeholder src until the page's scripts are loaded. Then the placeholders are replaced with the actual image source URL. Since script-loading is an asynchronous operation, my webscraping functions always ran before the images would have the proper src URLs.
  - So, I'd have to find a way to load the scripts before calling my functions. Since Node.js can't run scripts embedded in the HTML, the workaround was configuring `jsdom`'s pseudo-DOM to run them.
  - The webscraping output I got after this was close but not identical to the expected array's image links.
  - However, "running scripts dangerously" in Node.js inherently leads to an uncaught error that's been acknowledged [here](https://github.com/jsdom/jsdom/issues/3053). It kept interfering with my testing suites.
  - In the end, I decided to avoid running the embedded scripts in the HTML. The image links in my `array.json` are the output from **not** runninng the embedded scripts.

- I looked up Claude Monet and Pablo Picasso's paintings on Google and saved their pages to the `files` folder. The tests for these pages did not work out, so they are commented out in their files. ☹
  - The carousels are built a little different compared the Vincent Van Gogh page, perhaps because the Van Gogh page is older. Since the elements are nested differently, the functions for manipulating the Van Gogh page's DOM wasn't working out for Monet and Picasso.
  - If I had more time and revisited this project, I would probably research different libraries that could work with parsing content that is visually similar but programatically different.
