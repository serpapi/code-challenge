const { parseGScrollingCarousel } = require("../parse-carousel");
const fs = require("fs");

describe("parse G scrolling carousel", () => {
  test("it correctly parses a carousel consisting of xbox games", () => {
    const xboxGamesHtml = fs.readFileSync("files/xbox-games.html");
    const parsedXboxGamesCarousel = parseGScrollingCarousel(xboxGamesHtml);
    expect(parsedXboxGamesCarousel.length).toBe(17);

    const parsedGamesWithImages = parsedXboxGamesCarousel.filter(
      (game) => game.image
    );

    expect(parsedGamesWithImages.length).toBe(17);

    // verify all links look right and don't link to external sites
    // they accidentally linked to external sites once when I was parsing an additional carousel which was wrong
    const allLinksAreGoogle = parsedXboxGamesCarousel.every((game) =>
      game.link.startsWith("https://www.google.com/search")
    );

    expect(allLinksAreGoogle).toBe(true);

    // verify the first 5 games
    expect(parsedXboxGamesCarousel[0].name).toBe("Fallout 4");
    expect(parsedXboxGamesCarousel[0].extensions).toEqual(["2015"]);
    // to indicate actual image not placeholder
    expect(parsedXboxGamesCarousel[0].image.length).toBeGreaterThan(300);

    expect(parsedXboxGamesCarousel[1].name).toBe("Minecraft Dungeons");
    expect(parsedXboxGamesCarousel[1].extensions).toEqual(["2020"]);
    expect(parsedXboxGamesCarousel[1].image.length).toBeGreaterThan(300);

    expect(parsedXboxGamesCarousel[2].name).toBe("Plants vs. Zombies");
    expect(parsedXboxGamesCarousel[2].extensions).toEqual(["2009"]);
    expect(parsedXboxGamesCarousel[2].image.length).toBeGreaterThan(300);

    expect(parsedXboxGamesCarousel[3].name).toBe("theHunter: Call of the Wild");
    expect(parsedXboxGamesCarousel[3].extensions).toEqual(["2017"]);
    expect(parsedXboxGamesCarousel[3].image.length).toBeGreaterThan(300);

    expect(parsedXboxGamesCarousel[4].name).toBe("Farming Simulator 15");
    expect(parsedXboxGamesCarousel[4].extensions).toEqual(["2014"]);
    expect(parsedXboxGamesCarousel[4].image.length).toBeGreaterThan(300);
  });

  test("it correctly parses a carousel consisting of van gogh paintings", () => {
    const vanGoghHtml = fs.readFileSync("files/van-gogh-paintings.html");
    const parsedVanGoghCarousel = parseGScrollingCarousel(vanGoghHtml);
    expect(parsedVanGoghCarousel.length).toBe(51);

    const parsedPaintingsWithImages = parsedVanGoghCarousel.filter(
      (painting) => painting.image
    );

    // when you open the html, 12 are visible, but the last 4 seem to point to `https://encrypted-tbn0.gstatic`
    // and require an additional http call to fetch, which the challenge mentions that we shouldn't fetch, so they're left null
    expect(parsedPaintingsWithImages.length).toBe(8);

    // verify all links look right and don't link to external sites
    // they accidentally linked to external sites once when I was parsing an additional carousel which was wrong
    const allLinksAreGoogle = parsedVanGoghCarousel.every((game) =>
      game.link.startsWith("https://www.google.com/search")
    );

    expect(allLinksAreGoogle).toBe(true);

    // verify the first 5 paintings
    expect(parsedVanGoghCarousel[0].name).toBe("The Starry Night");
    expect(parsedVanGoghCarousel[0].extensions).toEqual(["1889"]);
    // to indicate actual image not placeholder
    expect(parsedVanGoghCarousel[0].image.length).toBeGreaterThan(300);

    expect(parsedVanGoghCarousel[1].name).toBe("Irises");
    expect(parsedVanGoghCarousel[1].extensions).toEqual(["1889"]);
    expect(parsedVanGoghCarousel[1].image.length).toBeGreaterThan(300);

    expect(parsedVanGoghCarousel[2].name).toBe("Sunflowers");
    // the field isn't present
    expect(parsedVanGoghCarousel[2].extensions).toEqual(undefined);
    expect(parsedVanGoghCarousel[2].image.length).toBeGreaterThan(300);

    expect(parsedVanGoghCarousel[3].name).toBe("Van Gogh self-portrait");
    expect(parsedVanGoghCarousel[3].extensions).toEqual(["1889"]);
    expect(parsedVanGoghCarousel[3].image.length).toBeGreaterThan(300);

    expect(parsedVanGoghCarousel[4].name).toBe("Café Terrace at Night");
    expect(parsedVanGoghCarousel[4].extensions).toEqual(["1888"]);
    expect(parsedVanGoghCarousel[4].image.length).toBeGreaterThan(300);
  });

  test("it correctly parses a carousel consisting of iOS games", () => {
    const vanGoghHtml = fs.readFileSync("files/ios-games.html");
    const parsediOSGamesCarousel = parseGScrollingCarousel(vanGoghHtml);

    const parsedGamesWithImages = parsediOSGamesCarousel.filter(
      (painting) => painting.image
    );

    // only the thirteen visible ones have images, as can be verified by opening the html file
    expect(parsedGamesWithImages.length).toBe(13);

    // verify all links look right and don't link to external sites
    // they accidentally linked to external sites once when I was parsing an additional carousel which was wrong
    const allLinksAreGoogle = parsediOSGamesCarousel.every((game) =>
      game.link.startsWith("https://www.google.com/search")
    );

    expect(allLinksAreGoogle).toBe(true);

    // verify the first 5 paintings
    expect(parsediOSGamesCarousel[0].name).toBe("Minecraft");
    expect(parsediOSGamesCarousel[0].extensions).toEqual(["2011"]);
    // to indicate actual image not placeholder
    expect(parsediOSGamesCarousel[0].image.length).toBeGreaterThan(300);

    expect(parsediOSGamesCarousel[1].name).toBe("Brawl Stars");
    expect(parsediOSGamesCarousel[1].extensions).toEqual(["2017"]);
    expect(parsediOSGamesCarousel[1].image.length).toBeGreaterThan(300);

    expect(parsediOSGamesCarousel[2].name).toBe("Fortnite");
    expect(parsediOSGamesCarousel[2].extensions).toEqual(["2017"]);
    expect(parsediOSGamesCarousel[2].image.length).toBeGreaterThan(300);

    expect(parsediOSGamesCarousel[3].name).toBe("Stumble Guys");
    expect(parsediOSGamesCarousel[3].extensions).toEqual(["2020"]);
    expect(parsediOSGamesCarousel[3].image.length).toBeGreaterThan(300);

    expect(parsediOSGamesCarousel[4].name).toBe("Garena Free Fire");
    expect(parsediOSGamesCarousel[4].extensions).toEqual(["2017"]);
    expect(parsediOSGamesCarousel[4].image.length).toBeGreaterThan(300);
  });
});
