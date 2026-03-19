from bs4 import BeautifulSoup
import json

with open("files/van-gogh-paintings.html", "r", encoding="utf-8") as file:
    html = file.read()

soup = BeautifulSoup(html, "html.parser")

artworks = []

for item in soup.select("div.iELo6"):
    link_tag = item.select_one("a[href]")
    img_tag = item.select_one("img")
    title_tag = item.select_one("div.pgNMRc")
    year_tag = item.select_one("div.cxzHyb")

    href = link_tag.get("href") if link_tag else None
    if href and href.startswith("/"):
        href = "https://www.google.com" + href

    image_value = None
    if img_tag:
        image_value = (
            img_tag.get("data-src")
            or img_tag.get("srcset")
            or img_tag.get("src")
        )

    artwork = {
        "name": title_tag.get_text(strip=True) if title_tag else None,
        "extensions": [year_tag.get_text(strip=True)] if year_tag else [],
        "link": href,
        "image": image_value,
    }

    artworks.append(artwork)

output = {"artworks": artworks}

with open("my_output.json", "w", encoding="utf-8") as f:
    json.dump(output, f, indent=2, ensure_ascii=False)

print("Wrote my_output.json")