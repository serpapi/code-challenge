import test from 'ava'
import { extractCarouselData } from '../src/extractor.js'

test('extracts carousel data', t => {
  const html = `
    <g-scrolling-carousel>
      <div data-index="0">
        <div></div>
        <div>Item 1</div>
      </div>
      <div data-index="1">
        <div></div>
        <div>Item 2</div>
      </div>
    </g-scrolling-carousel>`

  const data = extractCarouselData(html)
  t.deepEqual(data, [
    { name: 'Item 1', link: null, image: null, extensions: undefined },
    { name: 'Item 2', link: null, image: null, extensions: undefined }
  ])
})

test('extracts carousel data with images', t => {
  const html = `
    <g-scrolling-carousel>
      <div data-index="0">
        <img id="dimg_1" src="data:image/png;base64,AAA">
        <div>Item 1</div>
      </div>
      <div data-index="1">
        <img id="dimg_2" src="data:image/png;base64,BBB">
        <div>Item 2</div>
      </div>
    </g-scrolling-carousel>`

  const data = extractCarouselData(html)
  t.deepEqual(data, [
    {
      name: 'Item 1',
      link: null,
      image: 'data:image/png;base64,AAA',
      extensions: undefined
    },
    {
      name: 'Item 2',
      link: null,
      image: 'data:image/png;base64,BBB',
      extensions: undefined
    }
  ])
})

test('extracts carousel data with images and links', t => {
  const html = `
    <g-scrolling-carousel>
      <div data-index="0">
        <img id="dimg_1" src="data:image/png;base64,placeholder1">
        <div>Item 1</div>
      </div>
      <div data-index="1">
        <img id="dimg_2" src="data:image/png;base64,placeholder2">
        <div>Item 2</div>
      </div>
    </g-scrolling-carousel>
    <script>
      var a='data:image/png;base64,actual1';var b=['dimg_1'];_setImagesSrc(b, a);
      var c='data:image/png;base64,actual2';var d=['dimg_2'];_setImagesSrc(d, c);
    </script>`

  const data = extractCarouselData(html)
  t.deepEqual(data, [
    {
      name: 'Item 1',
      link: null,
      image: 'data:image/png;base64,actual1',
      extensions: undefined
    },
    {
      name: 'Item 2',
      link: null,
      image: 'data:image/png;base64,actual2',
      extensions: undefined
    }
  ])
})

test('uses titles from hover cards if available', t => {
  const html = `
    <g-scrolling-carousel>
      <div data-index="0">
        <div id="hovercard_1"></div>
        <div>Item 1</div>
      </div>
      <div data-index="1">
        <div id="hovercard_2"></div>
        <div>Item 2</div>
      </div>
    </g-scrolling-carousel>
    <script>
      window.jsl.dh('hovercard_1', '<a data-original-name="Hover 1" href="/link1"></a>');
      window.jsl.dh('hovercard_2', '<a data-original-name="Hover 2" href="/link2"></a>');
    </script>`

  const data = extractCarouselData(html)
  t.deepEqual(data, [
    {
      name: 'Hover 1',
      link: 'https://www.google.com/link1',
      image: null,
      extensions: undefined
    },
    {
      name: 'Hover 2',
      link: 'https://www.google.com/link2',
      image: null,
      extensions: undefined
    }
  ])
})

test('uses extensions from hover cards if available', t => {
  const html = `
    <g-scrolling-carousel>
      <div data-index="0">
        <div id="hovercard_1"></div>
        <div>Item 1</div>
      </div>
      <div data-index="1">
        <div id="hovercard_2"></div>
        <div>Item 2</div>
      </div>
    </g-scrolling-carousel>
    <script>
      window.jsl.dh('hovercard_1', '<a data-original-name="Hover 1" href="/link1"></a>
        <div class="ellip"><div>2021</div><div>&middot;</div><div>Amazon Prime</div></div>');
      window.jsl.dh('hovercard_2', '<a data-original-name="Hover 2" href="/link2"></a>
        <div class="ellip"><div>2022</div><div>&middot;</div><div>Netflix</div></div>');
    </script>`

  const data = extractCarouselData(html)
  t.deepEqual(data, [
    {
      name: 'Hover 1',
      link: 'https://www.google.com/link1',
      image: null,
      extensions: ['2021', 'Amazon Prime']
    },
    {
      name: 'Hover 2',
      link: 'https://www.google.com/link2',
      image: null,
      extensions: ['2022', 'Netflix']
    }
  ])
})
