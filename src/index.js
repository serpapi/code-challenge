import { ArgumentParser } from 'argparse'
import { extractCarouselData } from './extractor.js'
import { lstatSync, readdirSync, readFileSync, writeFileSync } from 'fs'
import { join } from 'path'
import { fileURLToPath } from 'url'

function main () {
  const parser = new ArgumentParser()
  parser.add_argument('input', { help: 'Input file/directory path (if -d is set)' })
  parser.add_argument('-o', '--output', { help: 'Output file/directory path (if -d is set)' })
  parser.add_argument('-d', '--directory', { action: 'store_true', help: 'Process files from a directory' })
  parser.add_argument('--v1', { action: 'store_true', help: 'Extract V1 carousel data only' })

  const args = parser.parse_args()
  const options = { v1Only: args.v1 }

  if (args.directory) {
    for (const file of readdirSync(args.input)) {
      const path = join(args.input, file)
      if (path.endsWith('.html') && !path.startsWith('.') && lstatSync(path).isFile()) {
        const data = extractCarouselData(readFileSync(path, 'utf-8'), options)
        const output = join(args.output ?? args.input, file.replace(/\.html$/, '.json'))
        writeFileSync(output, JSON.stringify(data, null, 2))
      }
    }
  } else {
    if (!args.input.endsWith('.html')) {
      console.error('Input file must be an HTML file')
      process.exit(1)
    }

    const data = extractCarouselData(readFileSync(args.input, 'utf-8'), options)
    const output = args.output ?? args.input.replace(/\.html$/, '.json')
    writeFileSync(output, JSON.stringify(data, null, 2))
  }
}

if (fileURLToPath(import.meta.url) === process.argv[1]) {
  main()
}
