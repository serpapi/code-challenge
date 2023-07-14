import { JSDOM } from 'jsdom'
import * as fs from 'fs'

export function getArtworks() {
  const file = fs.readFileSync('./files/van-gogh-paintings.html', 'utf-8')
  const { document } = new JSDOM(file, { runScripts: 'dangerously' }).window

  // Page layouts keep changing with updates, so these selectors need to be updated accordingly.
  const CAROUSEL_ANCHORS = 'g-scrolling-carousel a'
  const ANCHOR_IMAGES = 'img'
  const ANCHOR_YEARS = ".klmeta"

  const anchors = document.querySelectorAll<HTMLAnchorElement>(CAROUSEL_ANCHORS)

  const artworks = Array.from(anchors).map(anchor => {
    const ext = anchor.querySelector(ANCHOR_YEARS)?.textContent
    const img = document.querySelector<HTMLImageElement>(ANCHOR_IMAGES)
    const href = anchor.href
    return {
      name: anchor.getAttribute("aria-label"),
      image: img ? img.src : undefined,
      link: href.startsWith("/search") ? 'https://www.google.com' + href : href,
      extensions: ext ? [ext] : undefined
    }
  })

  // remove null values
  artworks.forEach((artwork: any) => {
    Object.keys(artwork).forEach(key => {
      if (!artwork[key]) {
        delete artwork[key]
      }
    })
  })

  return artworks
}

const artworks = getArtworks()
const text = JSON.stringify(artworks, null, 2)
fs.writeFileSync("./files/output-array.json", text)

process.exit(0)