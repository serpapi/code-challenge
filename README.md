# Extract Van Gogh Paintings Code Challenge

Goal is to extract a list of Van Gogh paintings from the attached Google search results page.

![Van Gogh paintings](https://github.com/serpapi/code-challenge/blob/master/files/van-gogh-paintings.png?raw=true "Van Gogh paintings")

## Instructions

This is already fully supported on SerpApi ([relevant test] and [sample json]).
Try to come up with your own solution and your own test.
Extract the painting `name`, date (`extensions` array), and Google `link` in an array.

Fork this repository and make a PR when ready. 
Do not use more than 4 hours of your time. 

Programming language wise, Ruby is suggested but feel free to use whatever you feel like.
Use directly the result page ([file attached]) in this repository.

[relevant test]: https://github.com/serpapi/test-knowledge-graph-desktop/blob/master/spec/knowledge_graph_claude_monet_paintings_spec.rb
[sample json]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.json
[file attached]: https://raw.githubusercontent.com/serpapi/code-challenge/master/files/van-gogh-paintings.html

## Expected Array

```json
[
  {
    "name": "The Starry Night",
    "date": [
      "1889"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw"
  },
  {
    "name": "Irises",
    "date": [
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
    "date": [
      "1889"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Van+Gogh+self-portrait&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1k_XNzQyTEk2z8nTUspOttIvyywuTcyJTywqQWJmFpdYlecXZRc_YozkFnj5456wVMCkNSevMXpxEaFJSIWLzTWvJLOkUkiKi0cKbrsGgxQXF5zHs4hVLCwxT8E9Pz1DoTg1J023IL-opCgxswQA-CHMG7IAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIOA"
  },
  {
    "name": "Café Terrace at Night",
    "date": [
      "1888"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Caf%C3%A9+Terrace+at+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMyg2NLbSUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhVzTkw7vFIhJLWoKDE5VSGxRMEvMz2jBACpuYkQsAAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIOw"
  },
  {
    "name": "The Potato Eaters",
    "date": [
      "1885"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=The+Potato+Eaters&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMTCxMKrWUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUMyUhVCMgvSSzJV3BNLEktKgYAoS92w6sAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIPg"
  },
  {
    "name": "Cypresses",
    "date": [
      "1889"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Cypresses+(Metropolitan+Museum+of+Art)&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1k_XNzQyqsiON0nTUspOttIvyywuTcyJTywqQWJmFpdYlecXZRc_YozkFnj5456wVMCkNSevMXpxEaFJSIWLzTWvJLOkUkiKi0cKbrsGgxQXF5zHs4hVzbmyoCi1uDi1WEHDN7WkKL8gPyezJDFPwbe0OLU0VyE_TcGxqEQTAGW4AMDCAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIQQ"
  },
  {
    "name": "Wheatfield with Crows",
    "date": [
      "1890"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Wheatfield+with+Crows&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMkw0KirWUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUNz0hNLEnLTM1JUSjPLMlQcC7KLy8GAABEZN2vAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIRA"
  },
  {
    "name": "The Yellow House",
    "date": [
      "1888"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=The+Yellow+House&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFSzAsNCrSUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhViEzNyckvV_DILy1OBQB6cr9GqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIRw"
  },
  {
    "name": "Starry Night Over the Rhône",
    "date": [
      "1888"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Starry+Night+Over+the+Rh%C3%B4ne&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLHMjE0tLbSUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYpUJLkksKqpU8MtMzyhR8C9LLVIoyUhVCMo4vCUvFQDcOEu1tgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYISg"
  },
  {
    "name": "Almond Blossoms",
    "date": [
      "1890"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Almond+Blossoms&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1k_XNzQyKM8uSa7SUspOttIvyywuTcyJTywqQWJmFpdYlecXZRc_YozkFnj5456wVMCkNSevMXpxEaFJSIWLzTWvJLOkUkiKi0cKbrsGgxQXF5zHs4iV3zEnNz8vRcEpJ7-4OD-3GADVlODTqwAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYITQ"
  },
  {
    "name": "At Eternity's Gate",
    "date": [
      "1890"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=At+Eternity's+Gate&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLHSTXLT8rSUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhVyLFFwLUktygMqVS9WcE8sSQUAV5EbKKwAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIUA"
  },
  {
    "name": "The Red Vineyard",
    "date": [
      "1888"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=The+Red+Vineyard&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLGMko3Ly7SUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCEpNUQjLzEutTCxKAQB21PAuqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIUw"
  },
  {
    "name": "The Night Café",
    "date": [
      "1888"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=The+Night+Caf%C3%A9&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLHSjcrzqrSUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYuUPyUhV8MtMzyhRcE5MO7wSAFvdlcSpAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIVg"
  },
  {
    "name": "Self-portrait without beard",
    "date": [
      "1889"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Self-portrait+without+beard&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1U_XNzRMKjfMMMkqK9RSyk620i_LLC5NzIlPLCpBYmYWl1iV5xdlFz9ijOQWePnjnrBUwKQ1J68xenERoUlIhYvNNa8ks6RSSIqLRwpuvwaDFBcXnMeziFU6ODUnTbcgv6ikKDGzRKE8syQjv7REISk1sSgFAFJ86rS5AAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIWQ"
  },
  {
    "name": "Self-Portrait with Bandaged Ear",
    "date": [
      "1889"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Self-Portrait+with+Bandaged+Ear&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArFMk0pSqiy1lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGKVD07NSdMNyC8qKUrMLFEozyzJUHBKzEtJTE9NUXBNLAIAZyU60LoAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIXA"
  },
  {
    "name": "Peasant Woman Against a Background of Wheat",
    "date": [
      "1890"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Peasant+Woman+Against+a+Background+of+Wheat&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLEszA3zjLSUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYtUOSE0sTswrUQjPz03MU3BMT8zMKy5RSFRwSkzOTi_KL81LUchPUwjPSE0sAQCYqFS_xQAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIXw"
  },
  {
    "name": "Field with plowing farmers",
    "link": "https://www.google.com/search?gl=us&hl=en&q=Field+with+plowing+farmers&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1U_XNzRMNsqNN4zPNtBSyk620i_LLC5NzIlPLCpBYmYWl1iV5xdlFz9ijOQWePnjnrBUwKQ1J68xenERoUlIhYvNNa8ks6RSSIqLRwpuvwaDFBcXnMeziFXKLTM1J0WhPLMkQ6EgJ788My9dIS2xKDe1qBgAUNR_8bgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIYg"
  },
  {
    "name": "Wheat Field with Cypresses",
    "date": [
      "1889"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Wheat+Field+with+Cypresses&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArFMSnJMTeK1lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGKVCs9ITSxRcMtMzUlRKM8syVBwriwoSi0uTi0GAI3LmqO1AAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIZQ"
  },
  {
    "name": "Olive Trees",
    "date": [
      "1889"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Olive+Trees+(Van+Gogh+series)&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArHSs1KSc0u0lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGKV9c_JLEtVCClKTS1W0AhLzFNwz0_PUChOLcpMLdYEALQL__24AAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIaA"
  },
  {
    "name": "Bedroom in Arles",
    "date": [
      "1888"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Bedroom+in+Arles&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArEsi02MCtO0lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGIVcEpNKcrPz1XIzFNwLMpJLQYAlW4c46sAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIaw"
  },
  {
    "name": "Portrait of Père Tanguy",
    "date": [
      "1887"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Portrait+of+P%C3%A8re+Tanguy&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArHSs1KyDMq0lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGKVCMgvKilKzCxRyE9TCDi8oihVISQxL720EgDV4AIFswAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIbg"
  },
  {
    "name": "Portrait of the Postman Joseph Roulin",
    "date": [
      "1888"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Portrait+of+the+Postman+Joseph+Roulin&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArHMjLOMCiy1lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGJVDcgvKilKzCxRyE9TKMlIVQjILy7JTcxT8MovTi3IUAjKL83JzAMAeUvTJcAAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIcQ"
  },
  {
    "name": "The Church at Auvers",
    "date": [
      "1890"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=The+Church+at+Auvers&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLHM0tIq8rSUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUJyUhVcM4oLUrOUEgsUXAsLUstKgYAUiv71K4AAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIdA"
  },
  {
    "name": "The garden of the Asylum",
    "date": [
      "1889"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=The+garden+of+the+Asylum&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1U_XNzRMKi_MLTdIMtdSyk620i_LLC5NzIlPLCpBYmYWl1iV5xdlFz9ijOQWePnjnrBUwKQ1J68xenERoUlIhYvNNa8ks6RSSIqLRwpuvwaDFBcXnMeziFUiJCNVIT2xKCU1TyE_TaEEyHMsrswpzQUAx6xvf7YAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIdw"
  },
  {
    "name": "Le Moulin de Blute-Fin",
    "date": [
      "1886"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Le+Moulin+de+Blute-Fin&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArEy0quMqyq1lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGIV80lV8M0vzcnMU0hJVXDKKS1J1XXLzAMA3k1m7rEAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIeg"
  },
  {
    "name": "Enclosed Field with Ploughman",
    "link": "https://www.google.com/search?gl=us&hl=en&q=Enclosed+Field+with+Ploughman&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1U_XNzRMzi5Ly6oyN9RSyk620i_LLC5NzIlPLCpBYmYWl1iV5xdlFz9ijOQWePnjnrBUwKQ1J68xenERoUlIhYvNNa8ks6RSSIqLRwpuvwaDFBcXnMeziFXWNS85J784NUXBLTM1J0WhPLMkQyEgJ780PSM3MQ8AYXdpr7sAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIfQ"
  },
  {
    "name": "Van Gogh's Chair",
    "link": "https://www.google.com/search?gl=us&hl=en&q=Van+Gogh's+Chair&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1k_XNzQyKiw2MY3XUspOttIvyywuTcyJTywqQWJmFpdYlecXZRc_YozkFnj5456wVMCkNSevMXpxEaFJSIWLzTWvJLOkUkiKi0cKbrsGgxQXF5zHs4hVICwxT8E9Pz1DvVjBOSMxswgAR_AXXqwAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIgAE"
  },
  {
    "name": "Autumn Landscape with Four Trees",
    "date": [
      "1885"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Autumn+Landscape+with+Four+Trees&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1U_XNzRMzi5JLzYsytZSyk620i_LLC5NzIlPLCpBYmYWl1iV5xdlFz9ijOQWePnjnrBUwKQ1J68xenERoUlIhYvNNa8ks6RSSIqLRwpuvwaDFBcXnMeziFXBsbSkNDdPwScxL6U4ObEgVaE8syRDwS2_tEghpCg1tRgAaB6sPb4AAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIgwE"
  },
  {
    "name": "Fishing Boats on the Beach at Saintes-Maries",
    "link": "https://www.google.com/search?gl=us&hl=en&q=Fishing+Boats+on+the+Beach+at+Saintes-Maries&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1k_XNzQyzEvPtbDQUspOttIvyywuTcyJTywqQWJmFpdYlecXZRc_YozkFnj5456wVMCkNSevMXpxEaFJSIWLzTWvJLOkUkiKi0cKbrsGgxQXF5zHs4hVxy2zOCMzL13BKT-xpFghP0-hJCNVwSk1MTlDIbFEITgxM68ktVjXN7EoM7UYALOPXxHIAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIhgE"
  },
  {
    "name": "Skull of a Skeleton with Burning Cigarette",
    "link": "https://www.google.com/search?gl=us&hl=en&q=Skull+of+a+Skeleton+with+Burning+Cigarette&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArGyjMzTcnO1lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGLVCs4uzclRyE9TSFQIzk7NSS3Jz1MozyzJUHAqLcrLzEtXcM5MTyxKLSlJBQCWDRItxQAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIiQE"
  },
  {
    "name": "Self-Portrait with Grey Felt Hat",
    "date": [
      "1887"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Self-Portrait+with+Grey+Felt+Hat&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArFMi3OK4w21lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGJVCE7NSdMNyC8qKUrMLFEozyzJUHAvSq1UcEvNKVHwSCwBAPX4-l27AAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIjAE"
  },
  {
    "name": "White House at Night",
    "date": [
      "1890"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=White+House+at+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArHMyk0MzLK0lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGIVCc_ILElV8MgvLU5VSCxR8MtMzygBADSN2EmvAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIjwE"
  },
  {
    "name": "Woman Sewing",
    "date": [
      "1885"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Woman+Sewing&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1U_XNzRMKi_MLS8yztZSyk620i_LLC5NzIlPLCpBYmYWl1iV5xdlFz9ijOQWePnjnrBUwKQ1J68xenERoUlIhYvNNa8ks6RSSIqLRwpuvwaDFBcXnMeziJUnPD83MU8hOLU8My8dALy4YoeqAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIkgE"
  },
  {
    "name": "Arles: View from the Wheat Fields",
    "date": [
      "1888"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Arles:+View+from+the+Wheat+Fields&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArFSUpJL0tO1lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGJVdCzKSS22UgjLTC1XSCvKz1UoyUhVCM9ITSxRcMtMzUkpBgApcnsvvAAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIlQE"
  },
  {
    "name": "The siesta (after Millet)",
    "link": "https://www.google.com/search?gl=us&hl=en&q=The+siesta+(after+Millet)&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi0U_XNzS0rDA3LKiq1FLKTrbSL8ssLk3MiU8sKkFiZhaXWJXnF2UXP2KM5BZ4-eOesFTApDUnrzF6cRGhSUiFi801rySzpFJIiotHCm69BoMUFxecx7OIVTIkI1WhODO1uCRRQSMxrSS1SME3MycntUQTAMJ_kSS2AAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYImAE"
  },
  {
    "name": "Sorrow",
    "date": [
      "1882"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Sorrow+(Van+Gogh)&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArFK4tNMUgq1lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGIVDM4vKsovV9AIS8xTcM9Pz9AEAIQvoy-sAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYImwE"
  },
  {
    "name": "Sunset at Montmajour",
    "date": [
      "1888"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Sunset+at+Montmajour&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArHKq0pM4nO1lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGIVCS7NK04tUUgsUfDNzyvJTczKLy0CADGrIhqvAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIngE"
  },
  {
    "name": "Avenue of Poplars in Autumn",
    "date": [
      "1884"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Avenue+of+Poplars+in+Autumn&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArHSS8oKciy1lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGKVdixLzStNVchPUwjIL8hJLCpWyMxTcCwtKc3NAwBpI31WtgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIoQE"
  },
  {
    "name": "The Pink Peach Tree",
    "date": [
      "1888"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=The+Pink+Peach+Tree&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArGSDdPLzdK0lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGIVDslIVQjIzMtWCEhNTM5QCClKTQUAVErhIq4AAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIpAE"
  },
  {
    "name": "Road with Cypress and Star",
    "date": [
      "1890"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Road+with+Cypress+and+Star&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArGyjMziK0q0lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGKVCspPTFEozyzJUHCuLChKLS5WSMxLUQguSSwCAJK6Tty1AAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIpwE"
  },
  {
    "name": "Bulb Fields",
    "date": [
      "1883"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Bulb+Fields&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArGScpNNzfO0lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGLldirNSVJwy0zNSSkGAPUySIemAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIqgE"
  },
  {
    "name": "Gauguin's Chair",
    "date": [
      "1888"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Gauguin's+Chair&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1k_XNzQyqDA3MzTXUspOttIvyywuTcyJTywqQWJmFpdYlecXZRc_YozkFnj5456wVMCkNSevMXpxEaFJSIWLzTWvJLOkUkiKi0cKbrsGgxQXF5zHs4iV3z2xNL00M0-9WME5IzGzCACyL3FRqwAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIrQE"
  },
  {
    "name": "View of Arles, Flowering Orchards",
    "date": [
      "1889"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=View+of+Arles,+Flowering+Orchards&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLHSU5KycrWUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYlUMy0wtV8hPU3Asykkt1lFwy8kvTy3KzEtX8C9KzkgsSikGAGz2iO27AAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIsAE"
  },
  {
    "name": "Poppy Flowers",
    "date": [
      "1887"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Poppy+Flowers&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArGSi5Kzy6u0lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGLlDcgvKKhUcMvJL08tKgYAbFdAT6gAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIswE"
  },
  {
    "name": "View of Arles with Irises in the Foreground",
    "date": [
      "1888"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=View+of+Arles+with+Irises+in+the+Foreground&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1k_XNzQyNM6LLy_UUspOttIvyywuTcyJTywqQWJmFpdYlecXZRc_YozkFnj5456wVMCkNSevMXpxEaFJSIWLzTWvJLOkUkiKi0cKbrsGgxQXF5zHs4hVOywztVwhP03BsSgntVihPLMkQ8GzKLMYyM7MUyjJSFVwyy9KTS_KL81LAQA7Oy6-xwAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYItgE"
  },
  {
    "name": "The Road Menders",
    "date": [
      "1889"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=The+Road+Menders&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArFMjKqyK4q1lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGIVCMlIVQjKT0xR8E3NS0ktKgYAJyVE0asAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIuQE"
  },
  {
    "name": "La Mousmé",
    "date": [
      "1888"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=La+Mousm%C3%A9&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArFMk6uMiuK1lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGLl8klU8M0vLc49vBIAbt_trKUAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIvAE"
  },
  {
    "name": "Avenue of Poplars at Sunset",
    "date": [
      "1884"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Avenue+of+Poplars+at+Sunset&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArHSS8pTqtK1lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGKVdixLzStNVchPUwjIL8hJLCpWSCxRCC7NK04tAQDmxWgztgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIvwE"
  },
  {
    "name": "Prisoners Exercising",
    "date": [
      "1890"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Prisoners+Exercising&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArGSyjLKDZO0lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGCO5BV7-uCcsFTBpzclrjF5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBefxLGIVCSjKLM7PSy0qVnCtSC1KzizOzEsHADgDirKvAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIwgE"
  },
  {
    "name": "Portrait of Adeline Ravoux",
    "date": [
      "1890"
    ],
    "link": "https://www.google.com/search?gl=us&hl=en&q=Portrait+of+Adeline+Ravoux&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1k_XNzQyyjYzTq7SUspOttIvyywuTcyJTywqQWJmFpdYlecXZRc_YozkFnj5456wVMCkNSevMXpxEaFJSIWLzTWvJLOkUkiKi0cKbrsGgxQXF5zHs4hVKiC_qKQoMbNEIT9NwTElNSczL1UhKLEsv7QCAOSAHzG2AAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIxQE"
  }
]
```

## Bonus Points

- Add to your array the painting thumbnails present in the result page file (not the ones where extra requests are needed)
- Test against another similar result page
