import {extractArtworksFromSERPFile} from "../lib/extractor.ts";

async function main() {
  const serpPath = process.argv[2];
  if (!serpPath) {
    console.error('Please provide the path to the Google search results page HTML file.');
    console.error('\tUsage: npm run extract <path_to_serp_file>');
    console.error('\tExample: npm run extract ./files/van-gogh-paintings.html');
    process.exit(1);
  }

  try {
    const artworks = await extractArtworksFromSERPFile(serpPath);
    console.log(JSON.stringify({artworks}, null, 2));
  } catch (error) {
    console.error('Error extracting artworks:', error);
    process.exit(1);
  }
}

if (import.meta.url === `file://${process.argv[1]}`) {
  await main();
}

