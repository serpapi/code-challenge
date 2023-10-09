const fs = require("fs");
const { getArtworks } = require("./artworks-parser");

describe("getArtworks", () => {
  let htmlString;
  let artworks;

  describe("with valid artworks page", () => {
    beforeAll(() => {
      htmlString = fs.readFileSync("./files/van-gogh-paintings.html", "utf-8");
      artworks = getArtworks(htmlString);
    });

    it("should match with the expected json", () => {
      const expectedStr = fs.readFileSync(
        "./files/expected-array.json",
        "utf-8"
      );
      const expectedData = JSON.parse(expectedStr);
      expect(expectedData).toEqual({ artworks });
    });

    it("should extract correct number of artworks", () => {
      expect(artworks.length).toBe(51);
    });

    it("should extract correct title for each artwork", () => {
      const expectedValues = [
        { name: "The Starry Night", index: 0 },
        { name: "Van Gogh self-portrait", index: 3 },
      ];
      expectedValues.forEach(({ name, index }) => {
        expect(artworks[index].name).toBe(name);
      });
    });

    it("should extract correct URL for each artwork", () => {
      const expectedValues = [
        {
          index: 0,
          link: "https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw",
        },
        {
          index: 3,
          link: "https://www.google.com/search?gl=us&hl=en&q=Van+Gogh+self-portrait&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1k_XNzQyTEk2z8nTUspOttIvyywuTcyJTywqQWJmFpdYlecXZRc_YozkFnj5456wVMCkNSevMXpxEaFJSIWLzTWvJLOkUkiKi0cKbrsGgxQXF5zHs4hVLCwxT8E9Pz1DoTg1J023IL-opCgxswQA-CHMG7IAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIOA",
        },
      ];
      expectedValues.forEach(({ link, index }) => {
        expect(artworks[index].link).toBe(link);
      });
    });

    it("should extract correct image for each artwork", () => {
      const expectedValues = [
        {
          index: 4,
          image:
            "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRA",
        },
        {
          index: 8,
          image: null,
        },
      ];
      expectedValues.forEach(({ image, index }) => {
        if (image === null) {
          expect(artworks[index].image).toBeNull();
        } else {
          expect(artworks[index].image.indexOf(image)).toBe(0);
        }
      });
    });

    it("should extract correct extensions for artwork with extensions", () => {
      const expectedValues = [
        {
          index: 1,
          extensions: ["1889"],
        },
        {
          index: 8,
          extensions: ["1888"],
        },
        {
          index: 35,
          extensions: undefined,
        },
      ];
      expectedValues.forEach(({ extensions, index }) => {
        if (extensions === undefined) {
          expect(artworks[index].extensions).toBeUndefined();
        } else {
          expect(artworks[index].extensions).toStrictEqual(extensions);
        }
      });
    });
  });

  describe("with invalid artworks page", () => {
    it("should return no artworks", () => {
      const artworks = getArtworks("invalid html data");
      expect(artworks).toEqual([]);
    });
  });
});
