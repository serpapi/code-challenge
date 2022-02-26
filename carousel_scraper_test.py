import json
import unittest
from carousel_scraper import scrape_google_carousel

def slurp_file(path):
    with open(path) as f:
        return f.read()
        
class Test(unittest.TestCase):
    def test_provided(self):
        """ test the provided Van Gogh carousel """

        # append {}s to expected JSON
        expected = json.loads("{" + slurp_file('files/expected-array.json') + "}")

        html = slurp_file("files/van-gogh-paintings.html")
        root_href = "https://www.google.com"
        actual = scrape_google_carousel(html, root_href)
        self.assertEqual(actual, expected)

    def test_simple(self):
        """ test a minimal version of the carousel format """
        # TODO move markup to fixtures directory
        html = """
        <!DOCTYPE html>
        <html lang="en">
        <body>
          <div class="EDblX">
            <div class="MiPcId">
              <a href="/test_url" role="button">
                <div>
                  <div>
                    <g-img>
                      <img class="rISBZc M4dUYb" src="DON'T SCRAPE THIS">
                    </g-img>
                  </div>
                </div>
                <div>
                  <div class="kltat">Foobar</div>
                  <div class="ellip klmeta">2022</div>
                </div>
              </a>
            </div>
          </div>
          <script>
          var s='data:image/jpeg;base64,foo';
          var s='data:image/jpeg;base64,bar';
          </script>
        </body>
        </html>
        """
        expected = {"artworks": [
            {
                "name": "Foobar",
                "extensions": ["2022"],
                "link": "https://www.google.com/test_url",
                "image": "data:image/jpeg;base64,foo",
            },
        ]}
        root_href = "https://www.google.com"
        actual = scrape_google_carousel(html, root_href)
        self.assertEqual(actual, expected)

    def test_two_elements(self):
        """ test a two-element version of the carousel format """
        html = """
        <!DOCTYPE html>
        <html lang="en">
        <body>
          <div class="EDblX">
            <div class="MiPcId">
              <a href="/MOCK_URL" role="button">
                <div>
                  <div>
                    <g-img>
                      <img class="rISBZc M4dUYb" src="DON'T SCRAPE THIS">
                    </g-img>
                  </div>
                </div>
                <div>
                  <div class="kltat">Fo<span>o</span>baz</div>
                  <div class="ellip klmeta">2021</div>
                </div>
              </a>
            </div>
            <div class="MiPcId">
              <a href="/MOCK_URL2" role="button">
                <div>
                  <div>
                    <g-img>
                      <img class="rISBZc M4dUYb" src="DON'T SCRAPE THIS">
                    </g-img>
                  </div>
                </div>
                <div>
                  <div class="kltat">Foobar</div>
                  <div class="ellip klmeta">2022</div>
                </div>
              </a>
            </div>
          </div>
          <script>
          var s='data:image/jpeg;base64,foo';
          var s='data:image/jpeg;base64,bar';
          </script>
        </body>
        </html>
        """
        expected = {"artworks": [
            {
                "name": "Foobaz",
                "extensions": ["2021"],
                "link": "https://www.google.com/MOCK_URL",
                "image": "data:image/jpeg;base64,foo",
            },
            {
                "name": "Foobar",
                "extensions": ["2022"],
                "link": "https://www.google.com/MOCK_URL2",
                "image": "data:image/jpeg;base64,bar",
            },
        ]}
        root_href = "https://www.google.com"
        actual = scrape_google_carousel(html, root_href)
        self.assertEqual(actual, expected)

if __name__ == "__main__":
    unittest.main(verbosity=2)

