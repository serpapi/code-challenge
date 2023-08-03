import * as cheerio from 'cheerio'

import type { ResultItems } from './types'

const imageExtractRegex = /'([^']+)';var ii=\['([^']+)'/g
function unescapeStringLiteral(literal: string): string {
  // e.g. `\x3d` => `=`
  return literal.replace(/\\x([0-9a-f]{2})/gi, (_, hexPair) =>
    String.fromCharCode(parseInt(hexPair, 16))
  )
}

export function parse(
  html: string,
  itemSelector: string,
  nameSelector: string,
  extensionSelector: string,
  imageSelector: string
): ResultItems {
  const images: { [id: string]: string } = Object.fromEntries(
    [...html.matchAll(imageExtractRegex)].map((m) => [
      m[2],
      unescapeStringLiteral(m[1]),
    ])
  )

  const $ = cheerio.load(html)

  return $(itemSelector)
    .map((_, el) => {
      const $el = $(el)

      const name = $el.find(nameSelector).prop('textContent') ?? ''
      const link = new URL(
        $el.prop('href') ?? '',
        'https://www.google.com'
      ).toString()
      const extensions = $el
        .find(extensionSelector)
        .toArray()
        .map((metaEl) => $(metaEl).prop('innerText')?.trim() ?? '')
        .filter((text) => text != '')

      const imageId = $el.find(imageSelector).attr('id')

      return {
        name,
        link,
        image: (imageId ? images[imageId] : null) ?? null,
        ...(extensions.length > 0 ? { extensions } : {}),
      }
    })
    .toArray()
}

export const parseOriginalCarousel = (html: string) =>
  parse(html, 'a.klitem', 'div.kltat', '.klmeta', '.klic img')

export const parseCurrentArtworks = (html: string) =>
  parse(html, '.iELo6>a', '.KHK6lb>.pgNMRc', '.KHK6lb>.cxzHyb', 'img.taFZJe')

export const autoDetectAndParse = (html: string) =>
  html.includes('kp-wp-tab-cont-ArtistToArtworks')
    ? parseCurrentArtworks(html)
    : parseOriginalCarousel(html)
