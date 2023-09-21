// require libraries
const cheerio = require("cheerio");
const fs = require("fs");

const extract = () => {
  // Parse directly the HTML result page ([html file]) in this repository

  const data = "van-gogh-paintings.html";
  const html = fs.readFileSync(data, "UTF-8");
  const $ = cheerio.load(html);

  //   Extract the painting `name`, `extensions` array (date), and Google `link` in an array.
  //   Add also to your array the painting thumbnails present in the result page file (not the ones where extra requests are needed).

  artworks = [];

  $(".klitem", html).each(function () {
    const name = $(this).attr("aria-label");
    const extensions = $(this).find(".ellip.klmeta").text()
      ? [$(this).find(".ellip.klmeta").text()]
      : undefined;
    const link = "https://www.google.com" + $(this).attr("href");
    const image =
      $(this).find(".klzc").find("img").attr("data-key") || undefined;

    artworks.push({
      name,
      extensions,
      link,
      image,
    });
  });

  // check array in console
  console.log(artworks);

  // write array to JSON
  fs.writeFile(
    "artworks.json",
    JSON.stringify(artworks, null, 2),
    "utf8",
    function (err) {
      if (err) {
        return console.log(err);
      }
      console.log("artworks written to JSON");
    }
  );
};

extract();
