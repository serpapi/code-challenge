import * as cheerio from 'cheerio'

import { CarrouselItems } from './types'

const imageExtractRegex = /'([^']+)';var ii=\['kximg/g

export function parse(html: string): CarrouselItems {
  const images = [...html.matchAll(imageExtractRegex)].map((m) =>
    m[1]
      // e.g. `\x3d` => `=`
      .replace(/\\x([0-9a-f]{2})/gi, (_, hexPair) =>
        String.fromCharCode(parseInt(hexPair, 16))
      )
  )

  const $ = cheerio.load(html)

  return $('a.klitem')
    .map((idx, el) => {
      const extensions = $(el)
        .find('.klmeta')
        .map((_, metaEl) => $(metaEl).prop('innerText'))
        .toArray()

      return {
        name: el.attribs['aria-label'],
        link: new URL(el.attribs['href'], 'https://www.google.com').toString(),
        image: images[idx] ?? null,
        ...(extensions.length > 0 ? { extensions } : {}),
      }
    })
    .toArray()
}
