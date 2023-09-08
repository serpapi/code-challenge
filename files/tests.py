import unittest
import os
import json
from parseFile import parseFile


class TestSum(unittest.TestCase):
    def test_parse_van_gogh_paintings(self):
        parseFile("files/van-gogh-paintings.html")

        # Check the file exists
        assert os.path.exists(
            "result-van-gogh-paintings-0.json"
        ), f"File '{'result-van-gogh-paintings-0.json'}' does not exist."

        file = open("result-van-gogh-paintings-0.json", "r")
        data = json.load(file)
        file.close()

        for item in data:
            # Check the keys that should always exists exist
            self.assertIn("name", item, "Missing 'name' in the JSON object.")
            self.assertIn("link", item, "Missing 'link' in the JSON object.")
            self.assertIn("image", item, "Missing 'image' in the JSON object.")

            # Check that if extension exists, then it is an array
            if "extensions" in item:
                self.assertTrue(
                    isinstance(item["extensions"], list),
                    f"'extensions' is not of type list.",
                )

            # Check that an image is either of type "none" or a string
            self.assertTrue(
                isinstance(item["image"], (str, type(None))),
                f"'image' is not of type str or None.",
            )

    def test_parse_tolkien(self):
        parseFile("files/j-rr-tolkien.html")

        # Check that all three files exist
        assert os.path.exists(
            "result-j-rr-tolkien-0.json"
        ), f"File '{'result-j-rr-tolkien-0.json'}' does not exist."

        assert os.path.exists(
            "result-j-rr-tolkien-1.json"
        ), f"File '{'result-j-rr-tolkien-1.json'}' does not exist."

        assert os.path.exists(
            "result-j-rr-tolkien-2.json"
        ), f"File '{'result-j-rr-tolkien-2.json'}' does not exist."

        file = open("result-j-rr-tolkien-0.json", "r")
        data = json.load(file)
        file.close()

        for item in data:
            # Check the keys that should always exists exist
            self.assertIn("name", item, "Missing 'name' in the JSON object.")
            self.assertIn("link", item, "Missing 'link' in the JSON object.")
            self.assertIn("image", item, "Missing 'image' in the JSON object.")

            # Check that if extension exists, then it is an array
            if "extensions" in item:
                self.assertTrue(
                    isinstance(item["extensions"], list),
                    f"'extensions' is not of type list.",
                )

            # Check that an image is either of type "none" or a string
            self.assertTrue(
                isinstance(item["image"], (str, type(None))),
                f"'image' is not of type str or None.",
            )

        file = open("result-j-rr-tolkien-1.json", "r")
        data = json.load(file)
        file.close()

        for item in data:
            # Check the keys that should always exists exist
            self.assertIn("name", item, "Missing 'name' in the JSON object.")
            self.assertIn("link", item, "Missing 'link' in the JSON object.")
            self.assertIn("image", item, "Missing 'image' in the JSON object.")

            # Check that if extension exists, then it is an array
            if "extensions" in item:
                self.assertTrue(
                    isinstance(item["extensions"], list),
                    f"'extensions' is not of type list.",
                )

            # Check that an image is either of type "none" or a string
            self.assertTrue(
                isinstance(item["image"], (str, type(None))),
                f"'image' is not of type str or None.",
            )

        file = open("result-j-rr-tolkien-2.json", "r")
        data = json.load(file)
        file.close()

        for item in data:
            # Check the keys that should always exists exist
            self.assertIn("name", item, "Missing 'name' in the JSON object.")
            self.assertIn("link", item, "Missing 'link' in the JSON object.")
            self.assertIn("image", item, "Missing 'image' in the JSON object.")

            # Check that if extension exists, then it is an array
            if "extensions" in item:
                self.assertTrue(
                    isinstance(item["extensions"], list),
                    f"'extensions' is not of type list.",
                )

            # Check that an image is either of type "none" or a string
            self.assertTrue(
                isinstance(item["image"], (str, type(None))),
                f"'image' is not of type str or None.",
            )

    def test_parse_charlie_day(self):
        parseFile("files/charlie-day.html")
        # Check the file exists
        assert os.path.exists(
            "result-charlie-day-0.json"
        ), f"File '{'result-charlie-day-0.json'}' does not exist."

        file = open("result-charlie-day-0.json", "r")
        data = json.load(file)
        file.close()

        for item in data:
            # Check the keys that should always exists exist
            self.assertIn("name", item, "Missing 'name' in the JSON object.")
            self.assertIn("link", item, "Missing 'link' in the JSON object.")
            self.assertIn("image", item, "Missing 'image' in the JSON object.")

            # Check that if extension exists, then it is an array
            if "extensions" in item:
                self.assertTrue(
                    isinstance(item["extensions"], list),
                    f"'extensions' is not of type list.",
                )

            # Check that an image is either of type "none" or a string
            self.assertTrue(
                isinstance(item["image"], (str, type(None))),
                f"'image' is not of type str or None.",
            )


if __name__ == "__main__":
    unittest.main()
