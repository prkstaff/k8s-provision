import unittest
from app import app
import json
import copy
import datetime

class TestCrud(unittest.TestCase):
    def setUp(self):
        self.client = app.test_client()

    def check_app_json_and_status_code(self, response, expected_code):
        self.assertEqual('application/json', response.headers['Content-Type'])
        self.assertEqual(response.status_code, expected_code)

    def test_get_users_order_by_followers(self):
        response = self.client.get("/user?order=followers")
        self.check_app_json_and_status_code(response, 200)
        data = response.data.decode()
        self.assertEqual(len(data[0]["followers"], 4))

    def test_get_total_posts_by_given_hour(self):
        response = self.client.get("/post?from=time&to=time")
        data = response.data.decode()
        provisioned_data = 10
        self.assertEqual(len(data), provisioned_data)

    def test_get_total_post_post_by_language(self):
        response = self.client.get("/post?lang=pt-br")
        data = response.data.decode()
        total_br_posts = 10
        self.assertEqual(len(data), total_br_posts)

    def tearDown(self):
        pass
