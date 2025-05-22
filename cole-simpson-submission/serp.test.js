import parseHtml from "./serp";

describe("parseHtml Function Tests", () => {
    test("Should return JSON representation of artworks from carousel using link to raw HTML", async () => {
        const artworks = await parseHtml("https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html");
        const parsed = JSON.parse(artworks);
        expect(parsed).toBeDefined();
        expect(typeof parsed).toBe("object");
    });

    test("Should return JSON representation of movies from carousel using raw HTML file", async () => {
        const movies = await parseHtml("movies");
        const parsed = JSON.parse(movies);
        expect(parsed).toBeDefined();
        expect(typeof parsed).toBe("object");
    });

    test("Should return JSON representation of books from carousel using raw HTML file", async () => {
        const books = await parseHtml("books");
        const parsed = JSON.parse(books);
        expect(parsed).toBeDefined();
        expect(typeof parsed).toBe("object");
    });
});