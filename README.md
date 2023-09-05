### Runnning

You can run the script directly with `ruby run`, which will write the output to `files/output.json`. Or, you can launch an interactive console with `bin/console` and call `Parser::Google::Carousel.call` from there.

### Tests

You can run the tests via `bundle exec rspec`.

### Development

I initially used `split()` to find the images inside the `<script>` tag, but running this over 1.000 iterations proved to be quite slow.
So instead I replaced it with a regex, which is much faster.

`scan()` directly finds all occurrences of the pattern in a string, while split creates an array of substrings and each iterates over them.

I've also replaced `Hash#[]` with `Hash#merge!` to avoid creating a new hash on each iteration.

These are some benchmarks I ran:

```ruby
Benchmark.bm do |x|
  x.report(:split) do
    doc.xpath("//script[contains(., '_setImagesSrc')]").text.split('(function ()').each_with_object({}) do |node, images|
      next unless node.include?('data:image/jpeg')
  
      id = node.match(/var ii = \['(.*)'\]/)&.captures&.first
      image_base64 = node.match(/s = '(.*)'; var ii/)&.captures&.first&.gsub(/\\x3d/, '=')

      images[id] = image_base64
    end
  end
  
  x.report(:scan) do
    scripts = doc.xpath("//script[contains(., '_setImagesSrc')]").text
    scripts.scan(/var ii = \['(.*?)'\].*?s = '(.*?)'; var ii/).each_with_object({}) do |(id, image_base64), images|
      next unless image_base64.include?('data:image/jpeg')

      image_base64.gsub!(/\\x3d/, '=')
      images.merge!(id => image_base64)
    end
  end
end
```
Running this 1.000 times, gives a very noticeable difference:
```bash
       user       system     total       real

split  0.001236   0.000111   0.001347 (  0.001348)
scan   0.000646   0.000026   0.000672 (  0.000673)
```
