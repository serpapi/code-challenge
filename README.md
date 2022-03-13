This is an implementation in Deno of the following challenge:
https://github.com/serpapi/code-challenge

# Install

You need Deno to run the code, you can install it from here:
https://deno.land/manual/getting_started/installation

# Run

Run `./extract-carousel.sh` and pass as first argument the path to a file
containing the HTML of a Google search result. The extracted data is returned in
the standard output. Note that the dependencies (e.g.
[jsdom](https://github.com/jsdom/jsdom)) are automatically downloaded by Deno
the first time you run the program.

# Implementation notes

The JavaScript code of the HTML page is not executed when extracting data. Thus,
only the placeholders are provided as thumbnails when available (i.e.
`data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==`).

# Example

Some sample HTML files are provided in the `/samples` folder. Running
`./extract-carousel.sh ./samples/van-gogh-paintings.html` returns, for example,
the JSON below in the standard output.

```json
[
  {
    "name": "Discourse on Method",
    "extensions": [
      "1637"
    ],
    "link": "https://www.google.com/search?sxsrf=APq-WBvjrICe1xYeCaShRsQcYNudWzQcMg:1647145208200&q=Discourse+on+Method&stick=H4sIAAAAAAAAAONgFuLQz9U3MEsuzlbiBLEMLQzM07SkspOt9JPy87P1E0tLMvKLrEDsYoX8vJzKR4wPGLkFXv64Jyx1jXHSmpPXGM8zcuFRL6TDxeaaV5JZUinEI8XFBbfOSISLVz9d39Awq6AwvszIJFlg8a9pjErVRhm7Lk07x5YkqCfIwOAmE-ogZST4JWij4frF7-y1hLjYPYt98pMTcwQ7Gvi2Nb1da68lzMURkliRn5efWynotFrTv-R1lb2SIufTSP4GE-U39oJf9v27__KKmYMEiwKDBoPhI0tWh_VTGA9oMRxgZGrat-IQGwcHowCDERMHgxWTBlMVEwcTzyJWYZfM4uT80qLiVKAnFHxTgZ5KmcDGCAA_NHBPMAEAAA&sa=X&ved=2ahUKEwiawpyInsL2AhVLyYUKHUZKAWIQ-BZ6BAgTEA4",
    "image": "data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
  },
  {
    "name": "Meditations on First Philosophy",
    "extensions": [
      "1641"
    ],
    "link": "https://www.google.com/search?sxsrf=APq-WBvjrICe1xYeCaShRsQcYNudWzQcMg:1647145208200&q=Meditations+on+First+Philosophy&stick=H4sIAAAAAAAAAONgFuLQz9U3MEsuzlbiBLEMK5PSi7SkspOt9JPy87P1E0tLMvKLrEDsYoX8vJzKR4wPGLkFXv64Jyx1jXHSmpPXGM8zcuFRL6TDxeaaV5JZUinEI8XFBbfOSISLVz9d39Awq6AwvszIJFlg8a9pjErVRhm7Lk07x5YkqCfIwOAmE-ogZST4JWij4frF7-y1hLjYPYt98pMTcwQ7Gvi2Nb1da68lzMURkliRn5efWynotFrTv-R1lb2SIufTSP4GE-U39oJf9v27__KKmYMEiwKDBoPhI0tWh_VTGA9oMRxgZGrat-IQGwcHowCDERMHgxWTBlMVEwcTzyJWed_UlMySxJLM_DyQNxTcMouKSxQCMjJz8ovzCzIqJ7AxAgDI6o3sPAEAAA&sa=X&ved=2ahUKEwiawpyInsL2AhVLyYUKHUZKAWIQ-BZ6BAgTEBE",
    "image": "data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
  },
  {
    "name": "Principles of Philosophy",
    "extensions": [
      "1644"
    ],
    "link": "https://www.google.com/search?sxsrf=APq-WBvjrICe1xYeCaShRsQcYNudWzQcMg:1647145208200&q=Principles+of+Philosophy&stick=H4sIAAAAAAAAAONgFuLQz9U3MEsuzlbiBLGSzSrzkrSkspOt9JPy87P1E0tLMvKLrEDsYoX8vJzKR4wPGLkFXv64Jyx1jXHSmpPXGM8zcuFRL6TDxeaaV5JZUinEI8XFBbfOSISLVz9d39Awq6AwvszIJFlg8a9pjErVRhm7Lk07x5YkqCfIwOAmE-ogZST4JWij4frF7-y1hLjYPYt98pMTcwQ7Gvi2Nb1da68lzMURkliRn5efWynotFrTv-R1lb2SIufTSP4GE-U39oJf9v27__KKmYMEiwKDBoPhI0tWh_VTGA9oMRxgZGrat-IQGwcHowCDERMHgxWTBlMVEwcTzyJWiYCizLzkzIKcVKAv0hQCMjJz8ovzCzIqJ7AxAgAl6hq5NQEAAA&sa=X&ved=2ahUKEwiawpyInsL2AhVLyYUKHUZKAWIQ-BZ6BAgTEBQ",
    "image": "data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
  },
  ...
]
```

# Debugging code in a browser

You can run an HTTP server in the root folder of the project and open
`/test/index.html` in a browser (e.g. http://localhost:8000/test/index.html) to
test or debug the code of the library (i.e. `/lib/g-scrolling-carousel.js`).
