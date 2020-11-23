import json

if __name__ == '__main__':
	expected = json.load(open("files/expected-array.json"))["artworks"]
	output = json.load(open("files/output.json"))["artworks"]

	for o in output:
		if o not in expected:
			print(o)