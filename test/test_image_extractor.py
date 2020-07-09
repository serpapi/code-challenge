import unittest
import os
import json

from image_extractor import extract_images

class ImageExtractorTestCase(unittest.TestCase):

    def setUp(self):
        current_dir = os.path.dirname(__file__)
        self.data_dir = os.path.join(current_dir, 'data')

    def test_van_gogh_carousel(self):
        html_filename = os.path.join(self.data_dir, 'van-gogh-paintings.html')
        result = extract_images(html_filename)
        carousel = result['carousel']
        self.assertEqual(len(carousel), 51)
        self.assertEqual(carousel[0]['name'], 'The Starry Night')
        self.assertEqual(carousel[0]['link'], 'https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw')
        self.assertTrue('data:image/jpeg;base64' in carousel[0]['image'])
        self.assertEqual(carousel[0]['extensions'], ['1889'])

    def test_van_gogh_top_stories(self):
        html_filename = os.path.join(self.data_dir, 'van-gogh-paintings.html')
        result = extract_images(html_filename)
        top_stories = result['top_stories']
        self.assertEqual(len(top_stories), 3)
        fst = top_stories[0]
        self.assertEqual(fst['name'], 'Van Gogh paintings coming to Columbia')
        self.assertEqual(fst['link'], 'https://www.thestate.com/entertainment/article228030039.html')
        self.assertTrue('data:image/jpeg;base64' in fst['image'])

    def test_van_gogh_search_suggestions(self):
        html_filename = os.path.join(self.data_dir, 'van-gogh-paintings.html')
        result = extract_images(html_filename)
        search_suggestions = result['search_suggestions']
        self.assertEqual(len(search_suggestions), 5)
        fst = search_suggestions[0]
        self.assertEqual(fst['name'], 'Pablo Picasso')
        self.assertEqual(fst['link'], 'https://www.google.com/search?gl=us&hl=en&q=Pablo+Picasso&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVICs8wM4s21-AJSi4rz84IzU1LLEyuLF7HyBiQm5eQrBGQmJxYX5wMA50bZwzYAAAA&sa=X&ved=2ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQxA0wLnoECA8QUA')
        self.assertTrue('data:image/jpeg;base64' in fst['image'])

    def test_pablo_picasso_carousel(self):
        html_filename = os.path.join(self.data_dir, 'pablo-picasso-paintings.html')
        result = extract_images(html_filename)
        carousel = result['carousel']
        self.assertEqual(len(carousel), 50)
        fst = carousel[0]
        self.assertEqual(fst['name'], 'Guernica')
        self.assertEqual(fst['link'], 'https://www.google.com/search?q=Guernica&stick=H4sIAAAAAAAAAONgFuLQz9U3MDOIN1fiBLFMjAxzTLWUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YY7kFXv64JywVMmnNyWuMflxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF51kxaTDxLGLlcC9NLcrLTE4EAE2x8mSmAAAA&npsic=0&sa=X&ved=2ahUKEwj87Mm0hMDqAhXCiIsKHYU-D68Q-BYwKHoECBoQKQ')
        self.assertTrue('data:image/jpeg;base64' in fst['image'])

    def test_pablo_picasso_top_stories(self):
        html_filename = os.path.join(self.data_dir, 'pablo-picasso-paintings.html')
        result = extract_images(html_filename)
        top_stories = result['top_stories']
        self.assertEqual(len(top_stories), 0)

    def test_pablo_picasso_search_suggestions(self):
        html_filename = os.path.join(self.data_dir, 'pablo-picasso-paintings.html')
        result = extract_images(html_filename)
        search_suggestions = result['search_suggestions']
        self.assertEqual(len(search_suggestions), 5)
        fst = search_suggestions[0]
        self.assertEqual(fst['name'], 'Vincent van Gogh')
        self.assertEqual(fst['link'], 'https://www.google.com/search?q=Vincent+van+Gogh&stick=H4sIAAAAAAAAAONgFuLQz9U3MDOIN1cCs8zjc420-AJSi4rz84IzU1LLEyuLF7EKhGXmJafmlSiUJeYpuOenZwAA_zKHHjkAAAA&sa=X&ved=2ahUKEwj87Mm0hMDqAhXCiIsKHYU-D68QxA0wJnoECAgQBQ')
        self.assertTrue('data:image/jpeg;base64' in fst['image'])





            

