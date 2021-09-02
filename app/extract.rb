require "json"
require "./app/google_carousel_extractor"

extractor = GoogleCarouselExtractor.new()
data = extractor.extract_from_url("https://www.google.com/search?sxsrf=AOaemvLdANEeep2wAh3E-nR4mzfR4djWWA:1630562941121&q=united+states+colleges+and+universities&stick=H4sIAAAAAAAAAONgFuLUz9U3sEw2LzdQQjC1lLKTrfRz8pMTSzLz8-AMq9K8zLLUouLMkszU4kWs6kBuSWqKQnFJYklqsUJyfk5OajqQkZiXooCsEgD9h7O0ZgAAAA&sa=X&sqi=2&ved=2ahUKEwjBmI6n0N_yAhW2rpUCHTWGBgYQzTooATAwegQIRBAC&biw=1920&bih=944")
puts JSON.pretty_generate(data)