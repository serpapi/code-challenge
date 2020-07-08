import unittest
import os
import json

from image_extractor import extract_images

class ImageExtractorTestCase(unittest.TestCase):

    def setUp(self):
        current_dir = os.path.dirname(__file__)
        self.data_dir = os.path.join(current_dir, 'data')

    def test_sample(self):
        html_filename = os.path.join(self.data_dir, 'van-gogh-paintings.html')
        with open(html_filename, 'r') as f:
            html = f.read()
        result = extract_images(html)
        expected_array_filename = os.path.join(self.data_dir, 'expected-array.json')
        with open(expected_array_filename, 'r') as f:
            expected_array = json.loads(f.read())
        self.assertEqual(result, expected_array)

