from bs4 import Tag


def bs4_get_img_src(img: Tag) -> str:
    if "data-src" in img.attrs:
        return img.attrs["data-src"]
    elif "data-key" in img.attrs and img.attrs.get("data-deferred") == "1":
        return img.attrs["data-key"]
    elif img.attrs.get("src"):
        return img.attrs["src"]
