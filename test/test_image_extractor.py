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

    def test_van_gogh_sidebar_images(self):
        html_filename = os.path.join(self.data_dir, 'van-gogh-paintings.html')
        result = extract_images(html_filename)
        sidebar_images = result['sidebar_images']
        self.assertEqual(len(sidebar_images), 0)

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


    def test_salvador_dali_carousel(self):
        html_filename = os.path.join(self.data_dir, 'salvador-dali-paintings.html')
        result = extract_images(html_filename)
        carousel = result['carousel']
        self.assertEqual(len(carousel), 47)
        fst = carousel[0]
        self.assertEqual(fst['name'], 'The Persistence of Memory')
        self.assertEqual(fst['link'], 'https://www.google.com/search?client=ubuntu&hs=Pmc&q=The+Persistence+of+Memory&stick=H4sIAAAAAAAAAONgFuLQz9U3sIyvyFPiBLGMDNIsqrSUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YY7kFXv64JywVMmnNyWuMflxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF51kxaTDxLGKVDMlIVQhILSoGak_NS05VyE9T8E3NzS-qBACf5BF8twAAAA&npsic=0&sa=X&ved=2ahUKEwjGweTdysDqAhWqw8QBHfZkAVwQ-BYwJnoECBgQKQ')
        self.assertTrue('data:image/jpeg;base64' in fst['image'])

    def test_salvador_dali_top_stories(self):
        html_filename = os.path.join(self.data_dir, 'salvador-dali-paintings.html')
        result = extract_images(html_filename)
        top_stories = result['top_stories']
        self.assertEqual(len(top_stories), 0)

    def test_salvador_dali_search_suggestions(self):
        html_filename = os.path.join(self.data_dir, 'salvador-dali-paintings.html')
        result = extract_images(html_filename)
        search_suggestions = result['search_suggestions']
        self.assertEqual(len(search_suggestions), 5)
        fst = search_suggestions[0]
        self.assertEqual(fst['name'], 'Pablo Picasso')
        self.assertEqual(fst['link'], 'https://www.google.com/search?client=ubuntu&hs=Pmc&q=Pablo+Picasso&stick=H4sIAAAAAAAAAONgFuLQz9U3sIyvyFMCs8wM4s21-AJSi4rz84IzU1LLEyuLF7HyBiQm5eQrBGQmJxYX5wMARGT24DYAAAA&sa=X&ved=2ahUKEwjGweTdysDqAhWqw8QBHfZkAVwQxA0wJHoECAoQBQ')
        self.assertTrue('data:image/jpeg;base64' in fst['image'])

    def test_salvador_dali_sidebar_images(self):
        html_filename = os.path.join(self.data_dir, 'salvador-dali-paintings.html')
        result = extract_images(html_filename)
        sidebar_images = result['sidebar_images']
        self.assertEqual(len(sidebar_images), 7)
        fst = sidebar_images[0]
        self.assertEqual(fst['link'], 'http://www.wikiart.org/en/salvador-dali')
        self.assertEqual(fst['image'], 'data:image/jpeg;base64,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')





            

