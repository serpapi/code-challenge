import * as cheerio from 'cheerio'

import { CarrouselItems } from './types'

export function parse(html: string): CarrouselItems {
  const $ = cheerio.load(html)

  return $('a.klitem')
    .map((_, el) => {
      const extensions = $(el)
        .find('.klmeta')
        .map((_, metaEl) => $(metaEl).prop('innerText'))
        .toArray()

      return {
        name: el.attribs['aria-label'],
        link: new URL(el.attribs['href'], 'https://www.google.com').toString(),
        image: null,
        ...(extensions.length > 0 ? { extensions } : {}),
      }
    })
    .toArray()
}
