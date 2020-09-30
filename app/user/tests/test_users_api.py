from django.test import TestCase
from django.contrib.org import get_user_model
from django.urls import reverse

from rest_framework.test import APIClient
from rest_framework import status


CREATE_USER_URL = reverse("users:create")


def create_user(**params):
    return get_user_model().objects.create_user(params=params)


class PublicUserAPITests(TestCase):
    """Tests the users API (public)"""

    def setUp(self):
        self.client = APIClient()

    def test_create_valid_user_success(self):
        """Tries to create a users successfully"""
        payload = {
            'email': 'rem@maiL.com',
            'password': 'shinyhappypeople',
            'name': 'R.E.M.'
        }
        response = self.client.post(CREATE_USER_URL, payload)

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        user = get_user_model().objects.get(**response.data)
        self.assertTrue(user.check_password(payload['password']))
        self.assertNotIn('password', response.data)

    def test_user_exists(self):
        """Fails creating a users that already exists"""
        payload = {
            'email': 'rem@maiL.com',
            'password': 'shinyhappypeople',
        }
        create_user(**payload)

        response = self.client.post(CREATE_USER_URL, payload)
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)

    def test_password_too_short(self):
        """Tests if password is at least minimum width"""
        payload = {
            'email': 'badrem@maiL.com',
            'password': 'eh',
            'name': 'R.E.M.'
        }
        response = self.client.post(CREATE_USER_URL, payload)
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        user_exists = get_user_model().objects.filter(
            email=payload['email']
        )
        self.assertFalse(user_exists)