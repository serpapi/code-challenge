import { unescapeString } from './escapes.js'

const setImagesCallsRegex = /var\s+(\w+)='(data:image\/[^']+)';\s*var\s+(\w+)=\[([^\]]+)\];\s*_setImagesSrc\(\3\s*,\s*\1\)/g
const hoverCardsRegex = /window\.jsl\.dh\('([^']+)'\s*,\s*'([^']+)'\)/g

/**
 * Get all images set via lazy-loaded calls to the _setImagesSrc function.
 *
 * @param {cheerio.CheerioAPI} $
 * @returns {Record<string, string>}
 */
export function getImageCalls ($) {
  const scriptTexts = $('script').map((_, el) => $(el).text()).get()
  const result = {}
  for (const text of scriptTexts) {
    for (const match of text.matchAll(setImagesCallsRegex)) {
      const image = unescapeString(match[2])
      for (const id of match[4].split(/\s*,\s*/)) {
        result[id.replace(/^'|'$/g, '')] = image
      }
    }
  }

  return result
}

/**
 * Get the data displayed when each carousel element is hovered over, used
 * for extracting additional information for TV show/movie queries set through JS.
 *
 * @param {cheerio.CheerioAPI} $
 * @param {Record<string, string>}
 */
export function getHoverCardCalls ($) {
  const scriptTexts = $('script').map((_, el) => $(el).text()).get()
  const result = {}
  for (const text of scriptTexts) {
    for (const match of text.matchAll(hoverCardsRegex)) {
      result[match[1]] = unescapeString(match[2])
    }
  }

  return result
}
