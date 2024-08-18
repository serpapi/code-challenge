import * as cheerio from 'cheerio'
import { getImageCalls, getHoverCardCalls } from './js_calls.js'

const baseURL = 'https://www.google.com'

/**
 * Extract carousel element info corresponding to queries involving politicians, such
 * as "us presidents" or "canadian prime ministers".
 *
 * @param {cheerio.Cheerio<Element>} $el
 * @param {Record<string, string>} dynamicImages
 * @returns {name: string, link: string | null, image: string | null, extensions?: string[]}
 */
function getElementDataV1 ($el, dynamicImages) {
  const title = $el.attr('title')
  let name = $el.attr('aria-label') ?? title

  const extensionMatch = title.match(/\(([\d-]+)\)$/)
  const extensionFromHTML = $el.find('div.ellip').text().trim()
  const extensions = extensionFromHTML.length > 0
    ? [extensionFromHTML]
    : (extensionMatch !== null ? [extensionMatch[1]] : undefined)

  if (extensions !== undefined) {
    name = name.replace(/\s*\(([\d-]+)\)$/, '')
  }

  const link = $el.attr('href')
  const img = $el.find('img')
  const imgId = img.attr('id')
  const imgSrc = dynamicImages[imgId] ?? img.attr('src') ?? null

  return {
    name,
    extensions,
    link: link !== undefined ? (baseURL + link) : null,
    image: imgSrc
  }
}

/**
 * Extract carousel element info corresponding to TV show/movie queries.
 *
 * @param {cheerio.Cheerio<Element>} $el
 * @param {Record<string, string>} dynamicImages
 * @param {Record<string, string>} hoverCards
 * @returns {name: string, link: string | null, image: string | null, extensions?: string[]}
 */
function getElementDataV2 ($el, dynamicImages, hoverCards) {
  // try to extract the name from the on-screen elements first
  const basicName = $el.find('div:nth-child(2)').text()

  const img = $el.find('img')
  const imgId = img.attr('id')
  const imgSrc = dynamicImages[imgId] ?? img.attr('src') ?? null

  const hoverId = $el.find('div[id]').attr('id')
  const $card = cheerio.load(hoverCards[hoverId] ?? '')

  // the hover card has more data, so use it if available
  const a = $card('a').first()
  const name = a.attr('data-original-name') ?? basicName ?? ''
  const link = a.attr('href') ?? null

  const extensions = $card('div.ellip')
    .first()
    .children()
    .map((_, el) => $card(el).text().replace(/\u00B7/g, '').trim())
    .filter((_, el) => el.length > 0)
    .get()

  return {
    name,
    link: link !== null ? (baseURL + link) : null,
    image: imgSrc,
    extensions: extensions.length > 0 ? extensions : undefined
  }
}

/**
 * Extract carousel element info corresponding to knowledge card image queries
 * that show a list of images, such as "rembrandt works" or "aquaman actors"
 * but NOT people queries like "cricket players" or "marvel characters".
 *
 * @param {cheerio.Cheerio<Element>} $el
 * @param {Record<string, string>} dynamicImages
 * @returns {name: string, link: string | null, image: string | null, extensions?: string[]}
 */
function getKCImageData ($el, dynamicImages) {
  const href = $el.attr('href')
  const img = $el.find('img')
  const imgId = img.attr('id')
  const imgSrc = dynamicImages[imgId] ?? img.attr('src') ?? null
  const imgAlt = img.attr('alt')

  const [name, extension] = $el.find('div:last-child').first().children()
    .map((_, el) => cheerio.load(el).text().trim())
    .get()

  return {
    name: name ?? imgAlt,
    link: href !== undefined ? (baseURL + href) : null,
    image: imgSrc,
    extensions: (extension !== undefined && extension.length > 0)
      ? [extension]
      : undefined
  }
}

/**
 * Extract carousel data from a scrolling carousel element.
 *
 * @param {cheerio.CheerioAPI} $
 * @param {cheerio.Cheerio<Element>} carousel
 * @param {{v1Only?: boolean}} options
 * @returns {Array<{name: string, link: string | null, image: string | null, extensions?: string[]}>}
 */
function extractGScrollingCarousel ($, carousel, options) {
  const dynamicImages = getImageCalls($)
  const carouselV1 = carousel.first().find('a[title]')
  if (carouselV1.length > 0) {
    return carouselV1
      .map((_, el) => getElementDataV1($(el), dynamicImages))
      .get()
  }

  if (!(options?.v1Only)) {
    const carouselV2 = carousel.first().find('div[data-index]')
    if (carouselV2.length > 0) {
      const hoverCards = getHoverCardCalls($)
      return carouselV2
        .map((_, el) => getElementDataV2($(el), dynamicImages, hoverCards))
        .get()
    }
  }

  return []
}

/**
 * Extract carousel-like data from a Knowledge graph element with images.
 *
 * @param {cheerio.CheerioAPI} $
 * @param {cheerio.Cheerio<Element>} kcElement
 * @returns {Array<{name: string, link: string | null, image: string | null, extensions?: string[]}>}
 */
function extractKCImageView ($, kcElement) {
  const dynamicImages = getImageCalls($)
  return kcElement.find('a')
    .map((_, el) => getKCImageData($(el), dynamicImages))
    .get()
}

/**
 * Extracts carousel data from a Google SERP.
 *
 * @param {string} html
 * @param {{v1Only?: boolean}} options
 * @returns {Array<{name: string, link: string | null, image: string | null, extensions?: string[]}>}
 */
export function extractCarouselData (html, options = {}) {
  const $ = cheerio.load(html)
  const carousel = $('g-scrolling-carousel')
  if (carousel.length > 0) {
    return extractGScrollingCarousel($, carousel, options)
  }

  if (!options.v1Only) {
    const kcElement = $('div[data-attrid^="kc:/"] > [jscontroller][class]')
    if (kcElement.length > 0) {
      return extractKCImageView($, kcElement)
    }
  }

  return []
}
