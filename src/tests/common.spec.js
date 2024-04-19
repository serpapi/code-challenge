import { app, server } from "../app";
import request from "supertest";
import { getHTML, createNodeList, parseNodeList } from "../script";

// Set-up server before tests begin.
let agent;
beforeAll(() => {
  agent = request.agent(app);
});

// Close servers after tests are done, else
// the console will stall.
afterAll(() => {
  server.close();
});

export const commonTest = (relativePath) => {
  describe("Server Functioning", () => {
    test("returns success", (done) => {
      agent
        .get(relativePath)
        .expect(200)
        .end(function (err, res) {
          if (err) return done(err);
          done();
        });
    });
  });

  describe("Parsing Process", () => {
    const url = `http://localhost:${server.address().port}${relativePath}`;
    let text;
    let nodeList;
    let artworks;

    describe("Parsing Page", () => {
      test("fetch webpage contents as string", async () => {
        text = await getHTML(url);
        expect(typeof text).toBe("string");
      });

      test("node list is not empty", () => {
        nodeList = createNodeList(text);
        expect(typeof nodeList).toBe("object");
        expect(nodeList.length).toBeGreaterThan(0);
      });

      test("node list is parsed into an array", () => {
        artworks = parseNodeList(nodeList);
        expect(Array.isArray(artworks)).toBe(true);
        expect(artworks.length).toEqual(nodeList.length);
      });
    });

    describe("Parsed Page", () => {
      test("artwork name is string", () => {
        expect(typeof artworks[0].name).toBe("string");
      });

      test("artwork extensions stored as array of strings", () => {
        expect(Array.isArray(artworks[0].extension)).toBe(true);
        expect(typeof artworks[0].extension[0]).toBe("string");
      });

      test("artwork links are valid URLs", (done) => {
        try {
          new URL(artworks[0].link);
          done();
        } catch (err) {
          done(err);
        }
      });

      test("artwork image sources are either strings or null", () => {
        expect(
          typeof artworks[0].image === "string" || artworks[0].image === null
        ).toBe(true);
      });
    });
  });
};

// Have to add this empty test or warning is shown about having an empty test file.
describe("Common Test", () => {
  test("should be used per implementation", () => {});
});
