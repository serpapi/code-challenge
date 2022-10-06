from bs4 import BeautifulSoup
from urllib.parse import urljoin
from selenium import webdriver
import json
import sys

def main():
    num_args=len(sys.argv)
    if num_args != 3:
        return 
    SERVER_NAME, INPUT_FILE=sys.argv[1:]
    OUTPUT_FILE="actual_array.json"
    output_json(OUTPUT_FILE, SERVER_NAME, INPUT_FILE)

def output_json(output_file, server_name, input_file):
    with open(output_file, "w") as f:
        result=generate_json(server_name,input_file)
        f.write(result)
 
def generate_json(server_name,input_file):
    browser = webdriver.Chrome()
    browser.get(urljoin("file://",input_file))
    soup = BeautifulSoup(browser.page_source, "html.parser")

    carousel_anchor_tags=soup.find_all('g-scrolling-carousel')[0].find_all('a')
    output_list=[]
    for a in carousel_anchor_tags:
        obj={}
        name,extensions=extract_text(a)
        link=extract_link(a,server_name)
        img=extract_img(a.img)
        obj['name']=name
        if extensions:
            obj['extensions']=extensions
        obj['link']=link
        obj['image']=img
        output_list.append(obj)
    heading=extract_heading(soup)
    output={heading:output_list}
    return json.dumps(output,ensure_ascii=False)

def extract_heading(soup):
    heading=""
    num_found_str=0
    extabar=soup.find("div", {"id": "extabar"})
    for span in extabar.find_all('span'):
        if not span.find_all('span') and not popup(span):
            inner_text=span.getText()
            if inner_text and is_alphan_numeric(inner_text):
                num_found_str+=1
            if num_found_str==2:
                heading=inner_text
                break
    return heading.lower()

def is_alphan_numeric(text):
    return "".join(text.split()).isalnum()

def popup(tag):
    found=False
    for parent in tag.parents:
        if parent.name=="g-popup":
            found=True
            break
    return found


def extract_text(a):
    text=["",[]]
    divs=a.find_all('div')
    i=0
    for div in divs:
        if not div.find_all('div'): #last parent
            inner_text=div.getText()
            if div.getText():
                if i==0:
                    text[i]=inner_text
                    i+=1
                else:
                    text[i].append(inner_text)
    return text

def extract_link(a,server_name):
    return urljoin(server_name,a.get('href'))

def extract_img(img_tag):
    src=None
    if img_tag.has_attr('src'):
        src=img_tag['src']
    return src

if __name__=='__main__':
    main()