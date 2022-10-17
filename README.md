This repository contains a script for extracting van gogh paintings from a search results html page.

The script is written in ruby to scrap data from google search result page carousel of cards. 

## Setup Instructions

### 1. Install ruby
```shell 
rvm install ruby-2.6.5
```

### 2. Install the gems
Move to project directory and execute
```shell
bundle install
```
## Execution Instructions
### 1. Change access permission of start.sh file to exectuable
```shell
chmod +x start.sh
```

### 2. Execute start script
```shell
./start html_file_path
```
* replace html_file_path with actual path 

### 3. You can view the output by navigating to the providied path.
You will see the path of output file on console output. 

## Testing
### Execute the following command to execute Unit Test Cases
```shell
  rspec spec
```

## Enjoy!