import express from "express";

// Set up Express server.
const app = express();
const PORT = process.env.PORT;

// Allow Express to serve static files.
app.use(express.static("files"));

// Show which port the server is listening on.
const server = app.listen(PORT, () =>
  console.log(
    `Server started, listening on http://localhost:${server.address().port}`
  )
);

export { app, server };
