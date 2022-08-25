import { hexToAscii } from "../utils";

describe("hexToAscii", () => {
  it("should return the same string if there are no hex chars", () => {
    expect(hexToAscii("")).toStrictEqual("");
    expect(hexToAscii(" ")).toStrictEqual(" ");
    expect(hexToAscii("  asd def")).toStrictEqual("  asd def");
  });

  it("should parse hex to ascii chars", () => {
    expect(hexToAscii("\\x3c")).toStrictEqual("<");
    expect(hexToAscii("\\x3d")).toStrictEqual("=");
    expect(hexToAscii("asd \\x3d")).toStrictEqual("asd =");
    expect(hexToAscii("asd \\x3d def   ")).toStrictEqual("asd = def   ");
    expect(hexToAscii("asd \\x3d def   \\x3c")).toStrictEqual("asd = def   <");
  });
});
