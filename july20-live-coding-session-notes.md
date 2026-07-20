# july 20

(quick notes, as i need to sleep)
we expanded the parser to pull data from knowledge panel overviews (specifically, albums from the taylor swift page)

i began using cursor toward the end of the call - it tried giving me rails-specific code which is an example of why i am cautious about what it suggests! i also removed the guardrails from the agents file

after the call, i finished getting it working and added specs to compare against the serpapi playground results for albums.

rubocop is now unhappy because the class is too big. we had discussed a little bit about how the code should be split up in the future - this is why. 

i will not be refactoring it in this commit, but i would break up the following:
- go back to knowledge panel being its own class
- make new appbar class
- make new module/mixin for the two image scraper methods
- undecided on where determining the object key should go