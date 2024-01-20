from bs4 import BeautifulSoup

path = 'files/van-gogh-paintings.html'
with open(path,'r',encoding='utf-8') as file: 
    html = file.read()

soup = BeautifulSoup(html,'html.parser')

# referencing https://beautiful-soup-4.readthedocs.io/en/latest/#searching-the-tree
# found klitem 
carousel = soup.find_all('a',class_='klitem')

print(carousel)