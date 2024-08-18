import test from 'ava'
import { extractCarouselData } from '../src/extractor.js'

test('extracts carousel data', t => {
  const html = `
    <g-scrolling-carousel>
      <div>
        <a title="Item 1">
          <div>Item 1</div>
        </a>
      </div>
      <div>
        <a title="Item 2">
          <div>Item 2</div>
        </a>
      </div>
    </g-scrolling-carousel>`

  const data = extractCarouselData(html)
  t.deepEqual(data, [
    {
      name: 'Item 1',
      link: null,
      image: null,
      extensions: undefined
    },
    {
      name: 'Item 2',
      link: null,
      image: null,
      extensions: undefined
    }
  ])
})

test('extracts carousel data with images and links', t => {
  const html = `
    <g-scrolling-carousel>
      <div>
        <a title="Item 1" href="/search?q=Item+1">
          <img src="data:image/png;base64,AAA">
        </a>
      </div>
      <div>
        <a title="Item 2" href="/search?q=Item+2">
          <img src="data:image/png;base64,BBB">
        </a>
      </div>
    </g-scrolling-carousel>`

  const data = extractCarouselData(html)
  t.deepEqual(data, [
    {
      name: 'Item 1',
      link: 'https://www.google.com/search?q=Item+1',
      image: 'data:image/png;base64,AAA',
      extensions: undefined
    },
    {
      name: 'Item 2',
      link: 'https://www.google.com/search?q=Item+2',
      image: 'data:image/png;base64,BBB',
      extensions: undefined
    }
  ])
})

test('extracts year from the title if available', t => {
  const html = `
    <g-scrolling-carousel>
      <div>
        <a title="Item 1 (2020)" href="/search?q=Item+1">
          <img src="data:image/png;base64,AAA">
        </a>
      </div>
      <div>
        <a title="Item 2 (2005-2009)" href="/search?q=Item+2">
          <img src="data:image/png;base64,BBB">
        </a>
      </div>
    </g-scrolling-carousel>`

  const data = extractCarouselData(html)
  t.deepEqual(data, [
    {
      name: 'Item 1',
      link: 'https://www.google.com/search?q=Item+1',
      image: 'data:image/png;base64,AAA',
      extensions: ['2020']
    },
    {
      name: 'Item 2',
      link: 'https://www.google.com/search?q=Item+2',
      image: 'data:image/png;base64,BBB',
      extensions: ['2005-2009']
    }
  ])
})

test('non-numerical ranges in the title are ignored', t => {
  const html = `
    <g-scrolling-carousel>
      <div>
        <a aria-label="Item 2" title="Item 2 (Signature Edition)" href="/search?q=Item+2">
          <img src="data:image/png;base64,BBB">
        </a>
      </div>
    </g-scrolling-carousel>`

  const data = extractCarouselData(html)
  t.deepEqual(data, [
    {
      name: 'Item 2',
      link: 'https://www.google.com/search?q=Item+2',
      image: 'data:image/png;base64,BBB',
      extensions: undefined
    }
  ])
})

test('prefers html ellip over title for extensions', t => {
  const html = `
    <g-scrolling-carousel>
      <div>
        <a title="Item 1 (2020)">
          <div class="ellip">2021</div>
        </a>
      </div>
      <div>
        <a title="Item 2 (2005-2009)">
          <div class="ellip">2001-2008</div>
        </a>
      </div>
    </g-scrolling-carousel>`

  const data = extractCarouselData(html)
  t.deepEqual(data, [
    {
      name: 'Item 1',
      link: null,
      image: null,
      extensions: ['2021']
    },
    {
      name: 'Item 2',
      link: null,
      image: null,
      extensions: ['2001-2008']
    }
  ])
})

test('prefers aria-label over title for name', t => {
  const html = `
    <g-scrolling-carousel>
      <div>
        <a aria-label="Item 11" title="Item 1">
          <div>Item 1</div>
        </a>
      </div>
      <div>
        <a aria-label="Item 22" title="Item 2">
          <div>Item 2</div>
        </a>
      </div>
    </g-scrolling-carousel>`

  const data = extractCarouselData(html)
  t.deepEqual(data, [
    {
      name: 'Item 11',
      link: null,
      image: null,
      extensions: undefined
    },
    {
      name: 'Item 22',
      link: null,
      image: null,
      extensions: undefined
    }
  ])
})

test('resolves dynamic image calls', t => {
  const html = `
    <g-scrolling-carousel>
      <div>
        <a title="Item 1" href="/search?q=Item+1">
          <img id="img1" src="data:image/png:base64,placeholder">
        </a>
      </div>
    </g-scrolling-carousel>
    <script>
      var a='data:image/png:base64,actual';var b=['img1'];_setImagesSrc(b, a);
    </script>`

  const data = extractCarouselData(html)
  t.deepEqual(data, [
    {
      name: 'Item 1',
      link: 'https://www.google.com/search?q=Item+1',
      image: 'data:image/png:base64,actual',
      extensions: undefined
    }
  ])
})
