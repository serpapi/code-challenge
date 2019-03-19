# Extract Van Gogh Paintings Code Challenge

Goal is to extract a list of Van Gogh paintings from the attached Google search results page.

![Van Gogh paintings](https://github.com/serpapi/code-challenge/blob/master/files/van-gogh-paintings.png?raw=true "Van Gogh paintings")

## Instructions

This is already fully supported on SerpApi ([relevant test]).
Try to come up with your own solution and your own test.
Extract the painting name, date, and Google link in an array.

Fork this repository and make a PR when ready. 
Do not use more than 4 hours of your time. 

Programming language wise, Ruby is suggested but feel free to use whatever you feel.
Use the Google result page [file attached].

[relevant test]: https://github.com/serpapi/test-knowledge-graph-desktop/blob/master/spec/knowledge_graph_claude_monet_paintings_spec.rb
[file attached]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html

## Expected Results

```json
[
  {
    "name": "The Starry Night",
    "extensions": [
    "1889"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw"
  },
  {
    "name": "Irises",
    "extensions": [
    "1889"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Irises+(painting)&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLGMzUvMi7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhX0LMosTi1W0ChIzASqz0vXBADZ_49eqwAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIMg"
  },
  {
    "name": "Sunflowers",
    "link": "https://www.google.com/search?gl=us&hl=en&q=vase+with+12+sunflowers&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArFMUszTjcu1lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGIVL0ssTlUozyzJUDA0UiguzUvLyS9PLSoGAIoORr-yAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYINQ"
  },
  {
    "name": "Van Gogh self-portrait",
    "extensions": [
    "1889"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Van+Gogh+self-portrait&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1k_XNzQyTEk2z8nTUspOttIvyywuTcyJTywqQWJmFpdYlecXZRc_YozkFnj5456wVMCkNSevMXpxEaFJSIWLzTWvJLOkUkiKi0cKbrsGgxQXF5zHs4hVLCwxT8E9Pz1DoTg1J023IL-opCgxswQA-CHMG7IAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIOA"
  },
 (...)
]
```

## Bonus Points

- Add to your array the painting thumbnails present in the result page file (not the ones where extra requests are needed)
- Test against another similar result page
