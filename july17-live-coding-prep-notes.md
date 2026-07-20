# july 17/18

examining the popes example, we find that the list is inside .appbar, and each list item has role=tab
during our call on friday, i determined that the image js remains the same - base64 jpeg, var ii/s

to make the parser more generalized, first thing to do is modify the code to allow non-kp results through
- copy to new module with more accurate name
- new top-level var: nodes
- rename @kp_key to @node_key, but continue only checking kp for now
- move the kp-specific code to a method call, returning nodes
- final return acts upon nodes instead

after making room for new code, there isn't much to change...
- pull the .appbar
- populate nodes with the .appbar tabs
- override key using the .appbar heading role
- proceed as normal

compare output against https://serpapi.com/playground?q=list+of+popes 

it *almost* gives us what we want, but not quite...
- playground image results are a serpapi-specific url. i think this is out of scope, so i will stick with the base64 images that i can find?
- names are missing! try node['title'] fallback
- this is almost what we want, but not quite. title concatenates name with other stuff
- try the aria-label?
- that worked! but i'm leaving the fallback in place

at this point, i will check that the old specs still work on the new module
- all specs work except for one, the one that says there is no KP
- remove this spec, because this is no longer a KP-specific parser
- add a new spec to make sure popes gives us the key we expect
- it does, but some of the names are wrong
- re-order the priority in the names method

but there is another problem - the serpapi playground results has images for all of the popes, not just the ones on the initial html
- i noticed that in the results json, 21 images are actually gstatic.com and not serpapi
- these gstatic urls can be extracted using the id, although they are buried in a big ugly blob of js
- it can be done somewhat similarly to encoded_images
- i leaned on cursor a bit for this one

finally, the serpapi links are slightly different from mine, but there are some common values (q and stick)
- adjust link specs to check common values