import test from 'ava'
import * as cheerio from 'cheerio'
import { getImageCalls, getHoverCardCalls } from '../src/js_calls.js'

test('get dynamic image calls', t => {
  const $ = cheerio.load(`
    <html>
      <head>
        <script>
          var a='data:image/png:base64,AAA';
          var b=['foo'];
          _setImagesSrc(b, a);
          var c='data:image/jpeg:base64,BBB';
          var d=['bar'];
          _setImagesSrc(d, c);
        </script>
      </head>
    </html>`)

  t.deepEqual(getImageCalls($), {
    foo: 'data:image/png:base64,AAA',
    bar: 'data:image/jpeg:base64,BBB'
  })
})

test('handle escape sequences in dynamic image calls', t => {
  const $ = cheerio.load(`
    <html>
      <head>
        <script>
          var a='data:image/png:base64,AAA\x3d\x3d';
          var b=['foo'];
          _setImagesSrc(b, a);
        </script>
      </head>
    </html>`)

  t.deepEqual(getImageCalls($), {
    foo: 'data:image/png:base64,AAA=='
  })
})

test('collects from multiple script tags in dynamic image calls', t => {
  const $ = cheerio.load(`
    <html>
      <head>
        <script>
          var a='data:image/png:base64,AAA';
          var b=['foo'];
          _setImagesSrc(b, a);
        </script>
      </head>
      <body>
        <script>
          var c='data:image/jpeg:base64,BBB';
          var d=['bar'];
          _setImagesSrc(d, c);
          var e='data:image/png:base64,CCC';
          var f=['baz'];
          _setImagesSrc(f, e);
        </script>
      </body>
    </html>`)

  t.deepEqual(getImageCalls($), {
    foo: 'data:image/png:base64,AAA',
    bar: 'data:image/jpeg:base64,BBB',
    baz: 'data:image/png:base64,CCC'
  })
})

test('ignores non-script tags in dynamic image calls', t => {
  const $ = cheerio.load(`
    <html>
      <head>
        <script>
          var a='data:image/png:base64,AAA';
          var b=['foo'];
          _setImagesSrc(b, a);
        </script>
        <style>
          var c='data:image/jpeg:base64,BBB';
          var d=['bar'];
          _setImagesSrc(d, c);
        </style>
      </head>
    </html>`)

  t.deepEqual(getImageCalls($), {
    foo: 'data:image/png:base64,AAA'
  })
})

test('handles multiple image ids in dynamic image calls', t => {
  const $ = cheerio.load(`
    <html>
      <head>
        <script>
          var a='data:image/png:base64,AAA';
          var b=['foo', 'bar'];
          _setImagesSrc(b, a);
        </script>
      </head>
    </html>`)

  t.deepEqual(getImageCalls($), {
    foo: 'data:image/png:base64,AAA',
    bar: 'data:image/png:base64,AAA'
  })
})

test('get hover card calls', t => {
  const $ = cheerio.load(`
    <html>
      <head>
        <script>
          window.jsl.dh('foo', 'bar');
          window.jsl.dh('baz', 'qux');
        </script>
      </head>
    </html>`)

  t.deepEqual(getHoverCardCalls($), {
    foo: 'bar',
    baz: 'qux'
  })
})

test('handle escape sequences in hover card calls', t => {
  const $ = cheerio.load(`
    <html>
      <head>
        <script>
          window.jsl.dh('foo', 'bar\\x3d');
        </script>
      </head>
    </html>`)

  t.deepEqual(getHoverCardCalls($), {
    foo: 'bar='
  })
})

test('collects from multiple script tags for hover cards', t => {
  const $ = cheerio.load(`
    <html>
      <head>
        <script>
          window.jsl.dh('foo', 'bar');
        </script>
      </head>
      <body>
        <script>
          window.jsl.dh('baz', 'qux');
          window.jsl.dh('quux', 'corge');
        </script>
      </body>
    </html>`)

  t.deepEqual(getHoverCardCalls($), {
    foo: 'bar',
    baz: 'qux',
    quux: 'corge'
  })
})

test('ignores non-script tags for hover cards', t => {
  const $ = cheerio.load(`
    <html>
      <head>
        <script>
          window.jsl.dh('foo', 'bar');
        </script>
        <style>
          window.jsl.dh('baz', 'qux');
        </style>
      </head>
      <body>
        <p>
          window.jsl.dh('quux', 'corge');
        </p>
      </body>
    </html>`)

  t.deepEqual(getHoverCardCalls($), {
    foo: 'bar'
  })
})
