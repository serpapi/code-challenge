import { expect, test } from 'vitest'
import * as fs from 'node:fs/promises'

import { autoDetectAndParse } from '../src/parse'

async function readAndTest(name: string) {
  const [html, expectedJsonString] = await Promise.all([
    fs.readFile(new URL(`ref/${name}.html`, import.meta.url), {
      encoding: 'utf-8',
    }),
    fs.readFile(new URL(`ref/${name}.result.json`, import.meta.url), {
      encoding: 'utf-8',
    }),
  ])

  const result = autoDetectAndParse(html)
  const expected = JSON.parse(expectedJsonString)
  expect(result).toStrictEqual(expected)
}

test('Van Gogh Paintings', async () => {
  await readAndTest('van-gogh-paintings')
})

test('Leonardo da Vinci Paintings', async () => {
  await readAndTest('leonardo-da-vinci-paintings')
})

test('Michelangelo Artworks', async () => {
  await readAndTest('michelangelo-artworks')
})
