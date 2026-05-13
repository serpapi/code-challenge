import json
import glob
import base64
import re


#pattern for .json
directory = "../solutions"
pattern = "*.json"

#validate that base64 images are valid (no padding)
def base64_validator(value):
    #must be a string
    if not isinstance(value, str):
        return False, "not a string"
    m = re.match(r"^data:image/[a-z]+;base64,", value)
    if not m:
        return None, "Not base64, skipped..."
    
    b64 = value[m.end():]
    try:
        decoded = base64.b64decode(b64, validate=True)
        return True, f"Valid base64"
    except Exception as e:
        return False, f"Invalid base64: {e}"

#validate urls
def url_validator(link):
    #must be a string
    if not isinstance(link, str):
        return False, "Not a string..."
    #must start with http or https
    if not link.startswith(("http://", "https://")):
        return False, "Invalid url, does not start with http/https..."
    
    try:
        #needs . in valid domains
        dom = link.split("://")[1].split("/")[0]
    except IndexError as e:
        return False, f"Malformed URL... {e}"
    if "." not in dom:
        return False, "Invalid domain..."
    return True, "Valid URL"

def validator():
    #loop through all .json files
    paths = sorted(glob.glob(f"{directory}/{pattern}"))
    if not paths:
        print(f"No files matching '{directory}/{pattern} found...")
        return
    for path in paths:
        #print current .json being tested
        print(f"{'='*60}")
        print(f"Testing: {path}")
        print(f"{'='*60}")

        try:
            #load
            with open(path, "r", encoding="utf-8") as f:

                    data = json.load(f)
        except FileNotFoundError as e:
            print(f"   FAIL: File not found! {e}")
            continue
        
        except json.JSONDecodeError as e:
            print(f"  FAIL: Invalid JSON! {e}")
            continue
        except (PermissionError, OSError) as e:
            print(f"  FAIL: {e}")
            continue
        
        errors = []

        #must have a top-level dict with one key
        if not isinstance(data, dict) or len(data) != 1:
            errors.append("Expected a dict with one top-level key")
        else:
            #grab the single key
            key = next(iter(data))
            items = data[key]
            
            #must be a non-empty list
            if not isinstance(items, list):
                errors.append(f"'{key}' is not a list")
            elif len(items) == 0:
                errors.append(f"'{key}' is empty")
            else:
                #validate fields and types - required fields for values that are never null 
                checks = [
                    ("name", str, True),
                    ("link", str, True),
                    ("image", str, True),
                    ("extensions", list, False)
                ]
                for i, item in enumerate(items):
                    for field, ex_type, required in checks:
                        value = item.get(field)
                        if value is None:
                            #if required, append errors
                            if required:
                                errors.append(f"Item {i}  missing '{field}'")
                        #print values if type does not match
                        elif not isinstance(value, ex_type):
                            errors.append(f"Item {i} '{field}' is {type(value).__name__}, expected {ex_type.__name__}")
                        elif ex_type == str and not value:
                            errors.append(f"Item {i} '{field}' is empty string")
                        elif ex_type == list and len(value) == 0:
                            if required:
                                errors.append(f"Item {i} '{field}' is empty list")
                        #validate base64
                        if field == "image" and value:
                            valid, msg = base64_validator(value)
                            if valid is False:
                                errors.append(f"Item {i} '{field}' {msg}")
                        #validate url
                        if field == "link" and value:
                            valid, msg = url_validator(value)
                            if not valid:
                                errors.append(f"Item {i} '{field}' {msg}")
                        
                        

        if errors:
            for e in errors:
                print(f"  FAIL: {e}")
        else:
            counts = {}
            for field in ["name", "link", "image", "extensions"]:
                present = sum(1 for item in items if field in item and item[field])
                counts[field] = present
            #count items if passed
            total = len(items)
            print(f"  PASS ({total} items under '{key}')")
            print(f"    TOTALS:\n\tTotal names: {counts['name']}\n\tTotal extensions: {counts['extensions']}\n\tTotal links: {counts['link']}\n\tTotal images: {counts['image']}")
        print()

if __name__ == "__main__":
    validator()