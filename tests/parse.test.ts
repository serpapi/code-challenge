import { expect, test } from 'vitest'
import * as fs from 'node:fs/promises'

import { parse } from '../src/parse'

async function readAndTest(name: string) {
  const [html, expectedJsonString] = await Promise.all([
    fs.readFile(new URL(`ref/${name}.html`, import.meta.url), {
      encoding: 'utf-8',
    }),
    fs.readFile(new URL(`ref/${name}.result.json`, import.meta.url), {
      encoding: 'utf-8',
    }),
  ])

  const result = parse(html)
  const expected = JSON.parse(expectedJsonString)
  expect(result).toBe(expected)
}

test('Van Gogh Paintings', async () => {
  await readAndTest('van-gogh-paintings')
})
