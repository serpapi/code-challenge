# Closing Thoughts
I'm approaching the 4 hour mark so I'm stopping here per the README.

Overall I thought it was a good exercise. I started off getting my "scratch environment" ready with various gems. I spent a good deal of time re-familiarizing myself with Mechanize and the vangogh html page structure. I found differences between what Mechanize output for the base64 image data and what showed in the browser. I suspect that there's some javascript that changes or expands it because when running the page with javascript disabled it was essentially blank.

I came across the Ferrum gem. First time using it but it seemed to have a simple enough API to get going. I spent a good chunk of time trying to play around with xpaths there. The API seems to be different than Mechanize/Nokogiri, so to make progress I loaded the page in Ferrum/Chrome and took the raw HTML and used Nokogiri to wrap it.

Got a simple test script working and ideally it should be a 100% match:
```
Results
44 matching:
Van Gogh self-portrait, The Yellow House, Starry Night Over the Rhône, Almond Blossoms, At Eternity's Gate, The Red Vineyard, The Night Café, Self-portrait without beard, Self-Portrait with Bandaged Ear, Peasant Woman Against a Background of Wheat, Field with plowing farmers, Wheat Field with Cypresses, Olive Trees, Bedroom in Arles, Portrait of Père Tanguy, Portrait of the Postman Joseph Roulin, The Church at Auvers, The garden of the Asylum, Le Moulin de Blute-Fin, Enclosed Field with Ploughman, Van Gogh's Chair, Autumn Landscape with Four Trees, Fishing Boats on the Beach at Saintes-Maries, Skull of a Skeleton with Burning Cigarette, Self-Portrait with Grey Felt Hat, White House at Night, Woman Sewing, Arles: View from the Wheat Fields, The siesta (after Millet), Sorrow, Sunset at Montmajour, Avenue of Poplars in Autumn, The Pink Peach Tree, Road with Cypress and Star, Bulb Fields, Gauguin's Chair, View of Arles, Flowering Orchards, Poppy Flowers, View of Arles with Irises in the Foreground, The Road Menders, La Mousmé, Avenue of Poplars at Sunset, Prisoners Exercising, Portrait of Adeline Ravoux
7 not matching:
The Starry Night, Irises, Sunflowers, Café Terrace at Night, The Potato Eaters, Cypresses, Wheatfield with Crows
```

but the diffs look to be related to encoding differences (?). The differences between those paintings are in the base64 image src, where in the expected results there's `x3d` and in the actual generated one it's a `=`.

I did not have enough time to test 2 new pages. I pulled a search result with a carousel for paintings of Caspar David Friedrich. He's one of my favorite painters. In running my code against this page, I found that it didn't work because I put expectations in my parser that did not hold for the new page. A quick win was to make the xpath more flexible (can be seen in git history).

Note: a lot of tradeoffs I made to be at that 4 hour time recommendation + not having experience with Ferrum or how Google employs anti-scraping techniques.

## Future work in order of priority
- Look into potential encoding differences mentioned above to be more "correctness"
- Add more test pages to improve my parser (allow for more flexibility and different data extraction "patterns")
- Performance/scalability: I have no idea how performant any of the libraries I've used are at scale. A big performance hit could be the Ferrum to Nokogiri just in terms of memory use since we're 2xing the data + we pay for Nokogiri overhead.
- Can have "cleaner code" but I don't have enough domain knowledge to come up with the right abstractions at this moment. This would definitely come later.