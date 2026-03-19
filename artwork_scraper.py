from bs4 import BeautifulSoup
import json
import os
import re
import sys

#uses two modes
#first is if the layout matches exactly to the provided paintings html 
#next is a fall back for pages with similar layout but not exactly 
#in the second case, it will find the likely carousel section and proceed from there
input_file = (
    sys.argv[1]
    if len(sys.argv) > 1
    else "files/van-gogh-paintings.html"
)

with open(input_file, "r", encoding="utf-8") as file:
    html = file.read()

soup = BeautifulSoup(html, "html.parser")


def first_match(parent, selectors):
    for selector in selectors:
        tag = parent.select_one(selector)
        if tag:
            return tag
    return None


def normalize_link(href):
    if href and href.startswith("/"):
        return "https://www.google.com" + href
    return href


def normalize_image(img_tag):
    if not img_tag:
        return None

    src = (
        img_tag.get("data-src")
        or img_tag.get("srcset")
        or img_tag.get("src")
        or ""
    )

    if src.startswith("data:image/gif"):
        return None
    if src.startswith("https://") or src.startswith("data:image/jpeg"):
        return src
    return None


def extract_year(item): #find the year
    year_tag = first_match(item, ["div.cxzHyb"])
    if year_tag:
        year_text = year_tag.get_text(strip=True)
        if year_text:
            return year_text

    text = " ".join(item.stripped_strings)
    match = re.search(r"\b(1[5-9]\d{2}|20\d{2})\b", text) #finds any 4 digit year in the card
    return match.group(1) if match else None


def extract_title(item): #find the title
    title_tag = first_match(item, ["div.pgNMRc"])
    if title_tag:
        title_text = title_tag.get_text(strip=True)
        if title_text:
            return title_text

    #fallback, pick the first short, meaningful text in the card
    for text in item.stripped_strings:
        text = text.strip()
        if not text:
            continue
        if text == "Show more":
            continue
        if re.fullmatch(r"(1[5-9]\d{2}|20\d{2})", text):
            continue
        if len(text) > 80:
            continue
        return text

    return None


def find_carousel_section(soup): #this searches for a carousel section based on heading_names
    heading_names = {
        "artworks", "paintings", "plays", "works",
        "movies", "books", "novels", "albums", "songs"
    }

    for tag in soup.find_all(["h1", "h2", "h3", "div", "span"]):
        text = tag.get_text(" ", strip=True).lower()
        if text in heading_names:
            #try headings parent first, then next siblings
            containers = []

            if tag.parent:
                containers.append(tag.parent)

            sibling = tag.find_next_sibling()
            while sibling and len(containers) < 5:
                containers.append(sibling)
                sibling = sibling.find_next_sibling()

            for container in containers:
                if container.find("a", href=True) and container.find("img"):
                    return container

    return None


def find_item_cards(soup):
    # original selector as used for paintings
    items = soup.select("div.iELo6")
    if items:
        return items

    # fallback to restrict to he most likely carousel section based on heading names, then will find small cards inside
    section = find_carousel_section(soup)
    if not section:
        return []

    cards = []
    seen = set()

    # find images within it
    for link in section.find_all("a", href=True):
        if not link.find("img"):
            continue

        # card like container
        card = link
        while card.parent and card.parent != section: #walk upward to find a likely card container
            parent = card.parent

            #stop if too much text, reached section or other unrelated content
            text_count = len(list(parent.stripped_strings))
            if text_count > 12:
                break

            if parent.name == "div":
                card = parent

            card = parent

        # keep only small containers with useful text
        text_values = list(card.stripped_strings)
        if not text_values:
            continue
        if len(text_values) > 12: #removes noisy unnecessary sections
            continue

        key = normalize_link(link.get("href"))
        if key in seen:
            continue
        seen.add(key)
        cards.append(card)

    return cards


artworks = []

for item in find_item_cards(soup):
    link_tag = item.find("a", href=True)
    img_tag = item.find("img")

    href = normalize_link(link_tag.get("href") if link_tag else None)
    image_value = normalize_image(img_tag)
    title = extract_title(item)
    year = extract_year(item)

    if not title:
        continue

    artwork = {
        "name": title,
        "extensions": [year] if year else None,
        "link": href,
        "image": image_value,
    }

    artworks.append(artwork)

output = {"artworks": artworks}

base_name = os.path.basename(input_file).replace(".html", "")
output_file = f"{base_name}_output.json"

with open(output_file, "w", encoding="utf-8") as f:
    json.dump(output, f, indent=2, ensure_ascii=False)

print(f"Wrote {output_file}")
print(f"Extracted {len(artworks)} items")