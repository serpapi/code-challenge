import re
from bs4 import BeautifulSoup
import json
import codecs

file_path = r"../files/van-gogh-paintings.html"

#handle the unicode characters in base64
def unicode_handler(s):
    try:
        return codecs.decode(s, 'unicode_escape')
    #return original string if error
    except UnicodeDecodeError as e:
        print(f"unicode_handler error, falling back to original string...: {e}")
        return s

#handle images that don't have link
def img_handler(soup):
    #build a map from _setImagesSrc scripts
    img_map = {}
    #find all script elements in soup
    for script in soup.find_all("script"):
        text = script.string or ""
        #find by function
        if "_setImagesSrc" not in text:
            continue
        #extract ii array and s string
        ids = re.search(r"var\s+ii\s*=\s*\[(.*?)\]\s*;", text)
        src = re.search(r"var\s+s\s*=\s*'([^']+)'", text)
        
        if not ids or not src:
            continue
        try:
            #use unicode handler to extract base64
            base64 = unicode_handler(src.group(1))
            for img_id in re.findall(r"'([^']+)'", ids.group(1)):
                img_map[img_id] = base64
        except Exception as e:
            print(f"img_handler error: {e}")
            continue
    return img_map

#extract artwork based on a tag
def art_img_handler(tag, img_map):
    img = tag.find("img")
    #skip if no img tag
    if not img:
        return None
    #check for thumbnails first
    img_id = img.get("id")
    if img_id:
        try:
            return img_map.get(img_id)
        except Exception as e:
            print(f"art_img_handler error: {e}")
            pass
    return img.get("data-src")
    
#extract header
def heading_handler(soup):
    #find the first heading div
    heading = None
    found_artwork = False
    
    for el in soup.find_all(["div", "a"], recursive=True):
        try:
            if el.name == "div" and el.get("role") == "heading":
                if found_artwork:
                    break
                try:
                    heading = " ".join(el.stripped_strings)
                #handle elements without text
                except(StopIteration, AttributeError) as e:
                    print(f"heading_handler stripped_strings error: {e}")
                    continue
                continue

            if found_artwork:
                continue

            if el.name == "a" and is_artwork(el):
                found_artwork = True
        #skip problematic elements
        except Exception as e:
            print(f"heading_handler loop error: {e}")
            continue
    return heading

#check that the a tag belongs to an artwork
def is_artwork(tag):
    try:
        if tag.name != "a" or not tag.get("href"):
            return False
        #find containers in a tag
        container = tag.find("div")
        #if it isn't a div, skip
        if not container:
            return False
        divs = container.find_all("div", recursive=False)
        #if less than 2 divs, skip
        if len(divs) < 2:
            return False
        #must have img tag
        if not tag.find("img"):
            return False
        #passes all checks then true
        return True
    except Exception as e:
        print(f"is_artwork error: {e}")
        return False

#get the relevant art data
def art_datas(tag, img_map):
    try:
        #find divs
        container = tag.find("div")
        divs = container.find_all("div", recursive=False)
        
        #set to None if does not exist
        title = " ".join(divs[0].get_text().split()) or None
        date = divs[1].get_text(strip=True) or None
        link = tag["href"]
        
        img = tag.find("img")
        img_id = img.get("id")
        data_src = None
        
        #img_map for thumbnails first, fall back on data_src
        if img_id and img_id in img_map:
            data_src = img_map[img_id]
        
        #only use data-src if no thumbnail
        if not data_src:
            data_src = img.get("data-src")
                
        #must have title and some value for data_src
        if not title and not data_src:
            return None
        
        #build item
        item = {
            "name": title,
            "extensions": [date] if date else None,
            "link": f"https://www.google.com{link}" if link else None,
            "image": data_src    
        }
        #remove none values
        return {k: v for k, v in item.items() if v}
    except(KeyError, IndexError, AttributeError, TypeError) as e:
        print(f"art_datas error: {e}")
        return None


#process and parse
def page_parser(file_name):
    try:
        with open(file_name, "r", encoding="utf-8") as f:
            soup = BeautifulSoup(f, "html.parser")
    except FileNotFoundError as e:
        print(f"page_parser error: file cannot be found: {e}")
        return {}
    except (UnicodeDecodeError, OSError) as e:
        print(f"page_parser I/O error: {e}")
        return {}
    try:
        #image map
        img_map = img_handler(soup)
        #heading
        heading = heading_handler(soup)
        
        #check that heading exists, use page title if not
        if not heading:
            title_tag = soup.find("title")
            heading = title_tag.get_text(strip=True) if title_tag else "results"
        
        #hold results
        results = []
        
        for a in soup.find_all("a", href=True):
            #skip if doesn't pass artwork validators
            if not is_artwork(a):
                continue
            #get item
            item = art_datas(a, img_map)
            if item:
                results.append(item)
        
        
        return {heading.lower(): results}
    except Exception as e:
        print(f"An error has occurred with page_parser: {e}")
        return {}
        

if __name__ == "__main__":
    results = page_parser(file_path)

    #format to json
    json_output = json.dumps(results, indent=4, ensure_ascii=False)
    
    #save to file
    with open("python_array.json", "w", encoding="utf-8") as f:
        f.write(json_output)