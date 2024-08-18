import test from 'ava'
import { unescapeString } from '../src/escapes.js'

test('handles unicode escape sequences', t => {
  t.is(unescapeString('\\u0041n apple costs \\u20B95 each'), 'An apple costs ₹5 each')
})

test('handles hex escape sequences', t => {
  t.is(unescapeString('\\x41n apple costs \\x240.1 each'), 'An apple costs $0.1 each')
})

test('handles all other escape sequences', t => {
  // eslint-disable-next-line no-useless-escape
  t.is(unescapeString('a\\nb\\rc\\td\\be\\ff\\\\g'), 'a\nb\rc\td\be\ff\\g')
})

test('does not handle invalid escape sequences', t => {
  t.is(unescapeString('\\u0'), '\\u0')
  t.is(unescapeString('\\x0'), '\\x0')
  t.is(unescapeString('\\z'), 'z')
})
