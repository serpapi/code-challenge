const fs = require("fs");
const { getArtworks } = require("./artworks-parser");

const filePath = process.argv[2]; // Retrieve the file path from the command-line arguments

if (!filePath) {
  console.error(
    "Please provide the path to the HTML file as a command-line argument"
  );
  process.exit(1);
}

fs.readFile(filePath, "utf8", (err, htmlString) => {
  if (err) {
    console.error("Error reading HTML file:", err);
    return;
  }

  const artworks = getArtworks(htmlString);
  console.log(JSON.stringify({ artworks }, null, 2));
});
