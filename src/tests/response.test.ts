import path from "path";
import fs from "fs";
import { extractAndSavePaintingsFromHTMLFile } from "../index";

const parentDirectory = path.join(__dirname, "..");
const folderNames = ["van-gogh", "leonardo-da-vinci", "michaelangelo"];
const htmlFileName = "paintings.html";
const expectedArrayFileName = "expected-array.json";

const getFilePath = (folderName: string, fileName: string): string =>
  path.resolve(parentDirectory, "files", folderName, fileName);

const getFileContents = (filePath: string): string =>
  fs.readFileSync(filePath, "utf8");

describe("File and Folder Tests", () => {
  const filesFolderPath = getFilePath("", ""); // Common parent directory

  test("Files folder exists", () => {
    expect(fs.existsSync(filesFolderPath)).toBe(true);
  });

  test.each(folderNames)("Folder %s exists", (folderName) => {
    const folderPath = getFilePath(folderName, "");
    expect(fs.existsSync(folderPath)).toBe(true);
  });

  test.each(folderNames)("Files exist in folder %s", (folderName) => {
    const htmlFilePath = getFilePath(folderName, htmlFileName);
    const expectedArrayFilePath = getFilePath(
      folderName,
      expectedArrayFileName
    );

    expect(fs.existsSync(htmlFilePath)).toBe(true);
    expect(fs.existsSync(expectedArrayFilePath)).toBe(true);
  });

  test.each(folderNames)(
    "Extracts paintings from HTML file in %s",
    (folderName) => {
      const htmlFilePath = getFilePath(folderName, htmlFileName);
      const expectedArrayFilePath = getFilePath(
        folderName,
        expectedArrayFileName
      );

      const expectedArray = getFileContents(expectedArrayFilePath);

      extractAndSavePaintingsFromHTMLFile(htmlFilePath);
      const response = getResultJSON();

      expect(response).toEqual(JSON.parse(expectedArray));
    }
  );
});

function getResultJSON() {
  return JSON.parse(getFileContents(path.join(parentDirectory, "result.json")));
}
