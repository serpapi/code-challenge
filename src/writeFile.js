import { writeFile } from "fs";
import { getHTML, createNodeList, parseNodeList } from "./script";

// Writes the artwork list to a file.
async function writeToFile() {
  const url = `http://localhost:${process.env.PORT}/van-gogh-paintings.html`;
  const text = await getHTML(url);
  const nodeList = createNodeList(text);
  const artwork = parseNodeList(nodeList);
  writeFile("./src/array.json", JSON.stringify(artwork), (err) => {
    if (err) throw err;
  });
}

writeToFile();
