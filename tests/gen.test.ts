import { expect, test } from 'vitest'
import * as fs from 'node:fs/promises'

import { autoDetectAndParse } from '../src/parse'

async function generateResult(caseName: string) {
  const inputHtml = await fs.readFile(
    new URL(`../tests/ref/${caseName}.html`, import.meta.url),
    { encoding: 'utf-8' }
  )

  const resultArray = autoDetectAndParse(inputHtml)

  await fs.writeFile(
    new URL(`../tests/ref/${caseName}.result.json`, import.meta.url),
    JSON.stringify(resultArray, null, 2),
    { encoding: 'utf-8' }
  )

  return true
}

test('Generate result for leonardo-da-vinci-paintings', async () => {
  expect(await generateResult('leonardo-da-vinci-paintings')).toBe(true)
})

test('Generate result for michelangelo-artworks', async () => {
  expect(await generateResult('michelangelo-artworks')).toBe(true)
})
