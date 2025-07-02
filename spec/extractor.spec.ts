import test from 'node:test';
import assert from 'node:assert';
import {readFile} from 'node:fs/promises';
import {type Artwork, extractArtworksFromKnowledgePanel, extractArtworksFromSERPFile} from '../lib/extractor.ts';

const TEST_PAGES = [
  './files/van-gogh-paintings.html',
  './files/mc-escher-artwork.html',
  './files/hokusai-artwork.html',
]

/**
 * Placeholder used by google for images that are not loaded yet (because they
 * are in the truncated part of the knowledge panel). They shouldn't show up in
 * the extracted artworks because their alternative remote url should be
 * extracted instead.
 */
const PLACEHOLDER_BASE64_IMAGE = 'data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=='

/**
 * Validates that the given artwork object conforms to the expected structure.
 * @param artwork - The artwork object to validate.
 * @param artworkId - Identifier for the artwork, used in error messages.
 * @throws AssertionError Will throw an error if the artwork does not conform to the expected structure.
 */
function validateArtwork(artwork: unknown, artworkId: string): asserts artwork is Artwork {
  assert(typeof artwork === 'object' && artwork !== null, `Artwork #${artworkId} should be an object, got ${typeof artwork}`);

  assert('name' in artwork, `Artwork #${artworkId} should have a name`);
  assert(typeof artwork.name === 'string', `Artwork #${artworkId} name should be a string, got ${typeof artwork.name}`);
  assert(artwork.name.length > 0, `Artwork #${artworkId} name should not be empty`);

  if ('extensions' in artwork && artwork.extensions !== undefined) {
    assert(Array.isArray(artwork.extensions), `Artwork  #${artworkId} extensions should be an array`);
    if (artwork.extensions.length > 0) {
      artwork.extensions.forEach(extension => {
        assert(typeof extension === 'string', `Artwork  #${artworkId} each extension should be a string`);
        assert(extension.length > 0, `Artwork  #${artworkId} Extension should not be empty`);
      });
    }
  }

  assert('link' in artwork, `Artwork #${artworkId} Artwork should have a link`);
  assert(typeof artwork.link === 'string', `Artwork #${artworkId} Artwork link should be a string, got ${typeof artwork.link}`);
  assert(artwork.link.length > 0, `Artwork #${artworkId} link should not be empty`);
  assert.match(artwork.link, /^https:\/\/www\.google\.com\//, `Artwork #${artworkId} link should be an absolute Google URL`);

  assert('image' in artwork, `Artwork #${artworkId} should have an image`);
  assert(typeof artwork.image === 'string', `Artwork #${artworkId} image should be a string, got ${typeof artwork.image}`);
  assert(artwork.image.length > 0, `Artwork #${artworkId} image should not be empty`);

  assert.match(artwork.image, /^(data:image\/(png|jpeg|gif);base64,|https)/, `Artwork #${artworkId} image should be a base64 encoded image or a URL`);
  assert.notEqual(artwork.image, PLACEHOLDER_BASE64_IMAGE, `Artwork #${artworkId} image should not be the placeholder base64 image`);
}

test('extractArtworksFromSERPFile should extract artworks from van Gogh HTML file', async () => {

  for (const page of TEST_PAGES) {
    const artworks = await extractArtworksFromSERPFile(page);
    assert(Array.isArray(artworks), `Should return an array for ${page}`);
    assert(artworks.length > 0, `Should extract at least one artwork from ${page}`);

    artworks.forEach((artwork, index) => {
      validateArtwork(artwork, `${page} #${index + 1}`);
    });
  }
});

test('extractArtworksFromKnowledgePanel should extract artworks from HTML string', async () => {
  const page = TEST_PAGES[0]
  const html = await readFile(page, 'utf-8');
  const artworks = await extractArtworksFromKnowledgePanel(html);
  assert(Array.isArray(artworks), 'Should return an array');
  assert(artworks.length > 0, 'Should extract at least one artwork');

  artworks.forEach((artwork, index) => {
    validateArtwork(artwork, `${page} #${index + 1}`);
  });
});

test('extractArtworksFromKnowledgePanel should handle empty HTML', async () => {
  const artworks = await extractArtworksFromKnowledgePanel('<html><body></body></html>');

  assert(Array.isArray(artworks), 'Should return an array');
  assert.strictEqual(artworks.length, 0, 'Should return empty array for HTML without artwork containers');
});

test('extractArtworksFromSERPFile should reject for non-existent file', async () => {
  await assert.rejects(
    extractArtworksFromSERPFile('./non-existent-file.html'),
    'Should reject when file does not exist'
  );
});
