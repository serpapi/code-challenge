## Python Virtualenv

#### Activate Python Virtualenv
`$ source env/bin/activate `

#### Install Packages
`$ pip install -r requirements.txt`

#### Deactive Virtualenv
`$ deactivate`


## Setup Webserver (since links need JS to run)
1) Create new terminal tab, activate Virtualenv
2) Change into HTML file directory: `$ cd ../files`
3) Start webserver: `$ python -m http.server`


## Running Code

#### Scrape HTML
`$ python run_scraper.py`

#### Run Tests
`$ python -m unittest test_google_carousel_scraper.py`