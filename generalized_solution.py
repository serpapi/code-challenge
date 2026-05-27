# GENERALIZED SOLUTION
# instead of relying on css class
# we filter:
#   1. &stick= in the href  — present on knowledge graph carousel links
#   2. has an <img> child
#
# for name and year we find "leaf" nodes — tags with no child tags, only text
# so we never depend on class names for the text content either
#
# <a href="/search?...&stick=...">          <-- &stick=
#     <img id="..." data-src="..." src="..."/>   <-- has img
#     <div>                                      <-- not a leaf
#         <div>The Starry Night</div>            <-- name at leaf[0] 
#         <div>1889</div>                        <-- year at leaf[1]
#     </div>
# </a>

# IMAGE WITH SRC - EXAMPLES
# <div class="iELo6" jsdata="JI96Wc;unsupported;BCVKE8" style="width:153px;top:8px;left:8px">
#     <a href="/search?sca_esv=c2e426814f4d07e9&amp;gl=us&amp;hl=en&amp;q=The+Starry+Night&amp;stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxYtYBUIyUhWCSxKLiioV_DLTM0oAdKX0-E4AAAA&amp;sa=X&amp;ved=2ahUKEwjK-K-JwLWKAxXcQTABHePpOFoQtq8DegQIMxAD">
#     <img alt="The Starry Night" class="taFZJe" data-deferred="1" id="_L_FkZ4qlAtyDwbkP49Pj0QU_63" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="/>
#         <div class="KHK6lb">
#             <div class="pgNMRc">The Starry Night</div>
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

def get_artworks(file_path):
    with open(file_path) as f:
        soup = BeautifulSoup(f, "lxml")

    # build image map — same as hardcoded version
    image_map = {}
    for script in soup.find_all("script"):
        text = script.string or ""
        if "data:image" not in text or "var ii=" not in text:
            continue

        s_start = text.index("var s='") + len("var s='")
        s_end   = text.index("';", s_start)
        img_data = text[s_start:s_end]

        img_data = img_data.replace("\\x3d", "=")

        ii_start = text.index("var ii=['") + len("var ii=['")
        ii_end   = text.index("']", ii_start)
        img_id   = text[ii_start:ii_end]

        image_map[img_id] = img_data

    artworks = []

    for a in soup.find_all("a", href=True):
        card_href = a.get("href", "")

        # carousel links seem to have &stick= in the href
        if "&stick=" not in card_href:
            continue

        # must have an img inside
        card_img = a.find("img")
        if not card_img:
            continue

        # leaf nodes = tags inside <a> that have no child tags and have text these are the name and year divs
        leaves = []
        for tag in a.find_all():
            if tag.name == "img":
                continue
            if tag.find():
                continue
            if not tag.get_text(strip=True):
                continue
            leaves.append(tag)


        # need at least a name
        if not leaves:
            continue

        card_name  = leaves[0].get_text(strip=True)
        card_year  = leaves[1].get_text(strip=True) if len(leaves) > 1 else None

        card_google_link = "https://www.google.com" + card_href

        card_img_id       = card_img.get("id")
        card_img_data_src = card_img.get("data-src")

        final_card_img_src = card_img_data_src if card_img_data_src is not None else image_map.get(card_img_id)


        aw = {
            "name": card_name,
            "link": card_google_link,
        }
        if card_year:
            aw["extensions"] = [card_year]
        if final_card_img_src:
            aw["image"] = final_card_img_src

        artworks.append(aw)

    return {"artworks": artworks}


if __name__ == "__main__":
    import sys

    # accept a file path as argument, default to van gogh
    input_file = sys.argv[1] if len(sys.argv) > 1 else "files/van-gogh-paintings.html"

    # output file name: files/marvel.html -> files/marvel-output.json
    output_file = input_file.replace(".html", "-output.json")

    print(f"parsing {input_file}...")
    result = get_artworks(input_file)
    print(f"found {len(result['artworks'])} items")

    with open(output_file, "w") as f:
        json.dump(result, f, indent=2, ensure_ascii=False)
    print(f"saved to {output_file}")
