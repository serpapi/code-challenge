/**
 * Unescape escape sequences of a potentially quoted Javascript string
 *
 * @param {string} string
 */
export function unescapeString (string) {
  return string.replace(/\\(u[\dA-Fa-f]{4}|x[\dA-Fa-f]{2}|[^ux])/g, (_, match) => {
    switch (match[0]) {
      case 'u':
        return String.fromCharCode(parseInt(match.slice(1), 16))
      case 'x':
        return String.fromCharCode(parseInt(match.slice(1), 16))
      case 'n':
        return '\n'
      case 'r':
        return '\r'
      case 't':
        return '\t'
      case 'b':
        return '\b'
      case 'f':
        return '\f'
      case '\\':
        return '\\'
      default:
        return match
    }
  })
}
