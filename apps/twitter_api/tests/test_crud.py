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

    def test_get_companies_portfolio(self):
        response = self.client.get("/user")
        import pdb
        pdb.set_trace()

    def tearDown(self):
        pass
