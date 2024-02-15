# Code Challenge Submission for Nathan Bornstein

The main technologies I'm using for this challenge are JavaScript, Puppeteer (a headless browser) and Jest-Puppeteer
for the testing suite. I apologize for not using Ruby/Rails, but I've started to dive into its syntax and become
more familiar with it. Its class syntax looks pretty similar to JavaScript's class syntax, so hopefully it shouldn't
take too much time to become familiar with it.

I've left detailed comments in the code, so hopefully every action is explained well. Please let me know if 
any further clarification is needed! The necessary `.json` files are included in this repo as well.

To use this repo, first run:
- `npm i` to install all dependencies
- `npm start` to execute `index.js` in the `src` directory
- To test, run the command `npm test`

I was having some issues with Jest and had to finagle the timeout on it to be longer than its default setting. It was giving 
an `EventEmitter` warning of a possible memory leak. The tests still pass, but I wasn't able to figure out what was going 
on with that within the alotted 4 hour timeframe.

Thank you for the opportunity! This was a fun little challenge 🙂
