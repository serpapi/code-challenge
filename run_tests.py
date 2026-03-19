import subprocess

test_files = [
    "files/van-gogh-paintings.html",   # default case
    "test_files/example1.html",
    "test_files/example2.html",
]

for file in test_files:
    print(f"\nRunning scraper on: {file}")
    result = subprocess.run(
        ["python3", "artwork_scraper.py", file],
        capture_output=True,
        text=True,
    )
    print(result.stdout)