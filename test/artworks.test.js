const { TextEncoder, TextDecoder } = require('util')
Object.assign(global, { TextDecoder, TextEncoder })
// process.exit
process.exit = jest.fn()

const { getArtworks } = require('../dist')
let artworks = getArtworks()

describe('Extract Van Gogh Paintings JSON', () => {
  test('artworks array is not null', () => {
    expect(artworks).not.toBeNull()
  })

  test('artworks array is instance of Array and not empty', () => {
    expect(artworks).toBeInstanceOf(Array)
    expect(artworks.length).toBeGreaterThan(0)
  })
})

// {
//   "name": "The Starry Night",
//   "image": "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png",
//   "link": "https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw",
//   "extensions": [
//     "1889"
//   ]
// }

describe('The Starry Night JSON', () => {
  const artwork = artworks[0]

  test('name', () => {
    expect(typeof artwork.name).toBe('string')
    expect(artwork.name).toBe('The Starry Night')
  })

  test('link', () => {
    expect(typeof artwork.link).toBe('string')
    expect(artwork.link).toBe(
      'https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw'
    )
  })

  test('image', () => {
    expect(typeof artwork.image).toBe('string')
    expect(artwork.image).toBe(
      'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png'
    )
  })

  test("extensions", () => {
    expect(artwork.extensions).toBeInstanceOf(Array);
    expect(typeof artwork.extensions[0]).toBe('string')
    expect(artwork.extensions[0]).toBe('1889')
  })
})
