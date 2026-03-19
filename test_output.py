import json
import difflib

with open("my_output.json", "r", encoding="utf-8") as f:
    my_data = json.load(f)

with open("files/expected-array.json", "r", encoding="utf-8") as f:
    expected_data = json.load(f)

# Pretty-print both so line numbers are stable and readable
my_lines = json.dumps(my_data, indent=2, ensure_ascii=False).splitlines()
expected_lines = json.dumps(expected_data, indent=2, ensure_ascii=False).splitlines()

matcher = difflib.SequenceMatcher(None, expected_lines, my_lines)

missing_sections = []
unnecessary_additions = []

for tag, i1, i2, j1, j2 in matcher.get_opcodes():
    if tag == "delete":
        missing_sections.append((i1 + 1, i2, expected_lines[i1:i2]))
    elif tag == "insert":
        unnecessary_additions.append((j1 + 1, j2, my_lines[j1:j2]))
    elif tag == "replace":
        missing_sections.append((i1 + 1, i2, expected_lines[i1:i2]))
        unnecessary_additions.append((j1 + 1, j2, my_lines[j1:j2]))

with open("comparison.txt", "w", encoding="utf-8") as f:
    f.write("COMPARISON REPORT\n")
    f.write("=" * 60 + "\n\n")

    f.write("MISSING SECTIONS\n")
    f.write("-" * 60 + "\n")
    if missing_sections:
        for start, end, lines in missing_sections:
            f.write(f"Expected file lines {start}-{end} are missing:\n")
            for line_num, line in enumerate(lines, start=start):
                f.write(f"{line_num}: {line}\n")
            f.write("\n")
    else:
        f.write("None\n\n")

    f.write("UNNECESSARY ADDITIONS\n")
    f.write("-" * 60 + "\n")
    if unnecessary_additions:
        for start, end, lines in unnecessary_additions:
            f.write(f"My output has extra lines {start}-{end}:\n")
            for line_num, line in enumerate(lines, start=start):
                f.write(f"{line_num}: {line}\n")
            f.write("\n")
    else:
        f.write("None\n\n")

print("Comparison written to comparison.txt")