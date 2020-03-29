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
        data = json.loads(response.data.decode())
        self.assertEqual(len(data['users'][0]["followers"]), 4)

    def test_get_users_empty_response(self):
        # emoty response if receives different filter
        response = self.client.get("/user?unknow=followers")
        # 422 for Unprocessable Entity (unknow arg)
        self.check_app_json_and_status_code(response, 422)

    def test_get_total_posts_by_given_hour(self):
        #"E MMM d y hh:mm:ss "
        # from 01 jul 2016 20:00 to 21:00:00
        response = self.client.get("/post?from=1467414000&to=1467417600")
        data = json.loads(response.data.decode())
        expected_data = 1
        self.assertEqual(len(data['users']), expected_data)

    def test_get_posts_empty_response(self):
        # emoty response if receives different filter
        response = self.client.get("/post?unknow=filter")
        # 501 for not implemented
        self.check_app_json_and_status_code(response, 501)

        response2 = self.client.get("/post")
        # 422 for Unprocessable Entity (unknow arg)
        self.check_app_json_and_status_code(response2, 422)

    def test_get_total_post_by_language(self):
        response = self.client.get("/post?lang=pt-br")
        data = response.data.decode()
        total_br_posts = 10
        self.assertEqual(len(data), total_br_posts)

    def tearDown(self):
        pass
