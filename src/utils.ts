export const hexToAscii = (str: string): string => {
  const tokens = str.split("\\x");
  if (tokens.length < 2) {
    return str;
  }
  return [
    tokens[0],
    ...tokens
      .slice(1)
      .map(
        (h) => String.fromCharCode(parseInt(h.slice(0, 2), 16)) + h.slice(2)
      ),
  ].join("");
};
