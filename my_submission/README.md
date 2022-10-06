# Carrousel Api Implementation

## Set up
1. Install dependencies
```
pip install -r requirements.txt
```

2. Install Chromedriver (https://chromedriver.chromium.org/downloads) and Chrome (https://www.google.com/chrome/), ensuring that both versions are compatible.

3. Add Chrome and Chromedriver to your PATH variable. (Usually, Chrome is already reachable via the PATH variable)
```
CHROME='path\to\chrome'
CHROME_DRIVER='path\to\chromedriver'
PATH="$CHROME:$CHROME_DRIVER:$PATH"
```

## Run implementation
```
python3 carrousel.py <SERVER_NAME> <PATH_TO_INPUT_FILE>
```

For example if you are searching through google and using the html file `/Users/username/van-gogh-paintings.html`, which is in current directory, then run 

```
python3 carrousel.py "www.google.com" "/Users/username/van-gogh-paintings.html"
```

## Test implementation
```
python3 test.py 
```



