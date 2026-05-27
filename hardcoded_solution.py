# IMAGE WITH SRC

# <div class="iELo6" jsdata="JI96Wc;unsupported;BCVKE8" style="width:153px;top:8px;left:8px">
#     <a href="/search?sca_esv=c2e426814f4d07e9&amp;gl=us&amp;hl=en&amp;q=The+Starry+Night&amp;stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxYtYBUIyUhWCSxKLiioV_DLTM0oAdKX0-E4AAAA&amp;sa=X&amp;ved=2ahUKEwjK-K-JwLWKAxXcQTABHePpOFoQtq8DegQIMxAD">
#     <img alt="The Starry Night" class="taFZJe" data-deferred="1" id="_L_FkZ4qlAtyDwbkP49Pj0QU_63" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="/>
#         <div class="KHK6lb"><div class="pgNMRc">The Starry Night</div>
#             <div class="cxzHyb">1889</div>
#         </div>
#     </a>
# </div>

# IMAGE WITH DATA-SRC
# 
# <div class="iELo6" style="display:none;width:0px;top:0px;left:0px" jsdata="JI96Wc;unsupported;BCVKF4">
#   <a href="/search?sca_esv=c2e426814f4d07e9&amp;gl=us&amp;hl=en&amp;q=Self-Portrait+with+Bandaged+Ear&amp;stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArFMk0pSqiy1lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWLWOWDU3PSdAPyi0qKEjNLFMozSzIUnBLzUhLTU1MUXBOLAGGQvkZeAAAA&amp;sa=X&amp;ved=2ahUKEwjK-K-JwLWKAxXcQTABHePpOFoQtq8DegQIMxAT">
#       <img class="taFZJe" alt="Self-Portrait with Bandaged Ear" data-src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8juuefle5MyKZKBLRgPjsGSJon7vkt91SM7WTRuZOOyAyUI1v" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==">
#       <div class="KHK6lb">
#           <div class="pgNMRc">Self-Portrait with Bandaged Ear</div>
#           <div class="cxzHyb">1889</div>
#       </div>
#   </a>
# </div>


from bs4 import BeautifulSoup
import json

def get_artworks():
    with open('files/van-gogh-paintings.html') as f:
        soup = BeautifulSoup(f, "lxml")

    image_map = {}
    artworks = []

    for script in soup.find_all("script"):
        text = script.string or ""
        if "data:image" not in text or "var ii=" not in text:
            continue

        # extract image data between the quotes after "var s='"
        s_start = text.index("var s='") + len("var s='")
        s_end   = text.index("';", s_start)
        img_data = text[s_start:s_end]

        # fix: javascript escapes \x3d back to = (base64 padding character)
        img_data = img_data.replace("\\x3d", "=")

        # extract id between the quotes inside var ii=[' ... ']
        ii_start = text.index("var ii=['") + len("var ii=['")
        ii_end   = text.index("']", ii_start)
        img_id   = text[ii_start:ii_end]

        image_map[img_id] = img_data

    # the div of
    card_divs = soup.select(".iELo6")
    for card in card_divs:
        current_card = card

        image_name = current_card.select_one(".pgNMRc").text

        # fix: .cxzHyb is missing for some paintings (no year), check before calling .text
        year_el = current_card.select_one(".cxzHyb")
        image_year = year_el.text if year_el is not None else None
        card_extension = year_el.text if year_el is not None else None

        card_link = current_card.select_one("a")["href"]
        card_google_link = "https://www.google.com" + card_link

        card_img = current_card.select_one("img")
        card_img_id = card_img.get("id")
        card_img_data_src = card_img.get("data-src")
        card_img_src = card_img.get("src")

        # fix: use .get() instead of [] so missing ids don't KeyError
        final_card_img_src = card_img_data_src if card_img_data_src is not None else image_map.get(card_img_id)


        aw = {
            "name": image_name.strip(),
            "link": card_google_link.strip(),
        }
        # fix: also check for empty string — .cxzHyb exists but is empty for some paintings
        if card_extension:
            aw["extensions"] = [card_extension]
        # fix: only add image key when we actually have one
        if final_card_img_src is not None:
            aw["image"] = final_card_img_src.strip()

        artworks.append(aw)

    artworks_obj = {
        "artworks": artworks
    }

    return artworks_obj


if __name__ == "__main__":
    import sys

    # hardcoded solution only works on van gogh — it uses fixed css class names
    # but still accept a file argument to keep it consistent with generalized
    input_file  = sys.argv[1] if len(sys.argv) > 1 else 'files/van-gogh-paintings.html'
    output_file = input_file.replace('.html', '-output.json')

    print(f"parsing {input_file}...")
    artworks_obj = get_artworks()
    print(f"found {len(artworks_obj['artworks'])} items")

    with open(output_file, 'w') as f:
        json.dump(artworks_obj, f, indent=2, ensure_ascii=False)
    print(f"saved to {output_file}")




