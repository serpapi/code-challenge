import test from 'ava'
import { extractCarouselData } from '../src/extractor.js'

test('extracts carousel data', t => {
  const html = `
    <div data-attrid="kc:/unit_test">
      <div jscontroller class>
        <a>
          <img alt="Item 1">
        </a>
      </div>
    </div>`

  const data = extractCarouselData(html)
  t.deepEqual(data, [
    {
      name: 'Item 1',
      link: null,
      image: null,
      extensions: undefined
    }
  ])
})

test('extracts carousel data with images and links', t => {
  const html = `
    <div data-attrid="kc:/unit_test">
      <div jscontroller class>
        <a href="/url?q=actor1">
          <img src="data:image/png;base64,AAA" alt="Actor 1">
        </a>
        <a href="/url?q=actor2">
          <img src="data:image/png;base64,BBB" alt="Actor 2">
        </a>
      </div>
    </div>`

  const data = extractCarouselData(html)
  t.deepEqual(data, [
    {
      name: 'Actor 1',
      link: 'https://www.google.com/url?q=actor1',
      image: 'data:image/png;base64,AAA',
      extensions: undefined
    },
    {
      name: 'Actor 2',
      link: 'https://www.google.com/url?q=actor2',
      image: 'data:image/png;base64,BBB',
      extensions: undefined
    }
  ])
})

test('prefers the use of html data over alt text', t => {
  const html = `
    <div data-attrid="kc:/unit_test">
      <div jscontroller class>
        <a href="/url?q=actor1">
          <img src="data:image/png;base64,AAA" alt="Actor 1">
          <div>
            <div>Actor 11</div>
          </div>
        </a>
      </div>
    </div>`

  const data = extractCarouselData(html)
  t.deepEqual(data, [
    {
      name: 'Actor 11',
      link: 'https://www.google.com/url?q=actor1',
      image: 'data:image/png;base64,AAA',
      extensions: undefined
    }
  ])
})

test('prefers html extensions over alt text', t => {
  const html = `
    <div data-attrid="kc:/unit_test">
      <div jscontroller class>
        <a href="/url?q=actor1">
          <img src="data:image/png;base64,AAA" alt="Actor 1">
          <div>
            <div>Actor 11</div>
            <div>Leo</div>
          </div>
        </a>
      </div>
    </div>`

  const data = extractCarouselData(html)
  t.deepEqual(data, [
    {
      name: 'Actor 11',
      link: 'https://www.google.com/url?q=actor1',
      image: 'data:image/png;base64,AAA',
      extensions: ['Leo']
    }
  ])
})

test('resolves dynamic images', t => {
  const html = `
    <div data-attrid="kc:/unit_test">
      <div jscontroller class>
        <a href="/url?q=actor1">
          <img id="img1" alt="Actor 1" src="data:image/png;base64,placeholder1">
        </a>
      </div>
    </div>
    <script>
      var a='data:image/png;base64,actual1';var b=['img1'];_setImagesSrc(b, a);
    </script>`

  const data = extractCarouselData(html)
  t.deepEqual(data, [
    {
      name: 'Actor 1',
      link: 'https://www.google.com/url?q=actor1',
      image: 'data:image/png;base64,actual1',
      extensions: undefined
    }
  ])
})
