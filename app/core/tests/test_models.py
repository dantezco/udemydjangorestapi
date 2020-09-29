from django.test import TestCase
from django.contrib.auth import get_user_model


class ModelTests(TestCase):

    def test_create_user_with_email_successful(self):
        """Tests creating a new user with email successfully"""
        email = "dummy@email.com"
        password = "iamdummy"
        user = get_user_model().objects.create_user(
            email=email,
            password=password
        )

        self.assertEqual(user.email, email)
        self.assertTrue(user.check_password(password))

    def test_new_user_email_normalized(self):
        """Tests creating a new user, the email is normalized"""
        email = "verydummy@EMAIL.COM"
        password = "iamdummy"
        user = get_user_model().objects.create_user(
            email=email,
            password=password
        )

        self.assertEqual(user.email, email.lower())
        self.assertTrue(user.check_password(password))

    def test_new_user_email_invalid(self):
        """Tests if creating a user with no email raises error"""
        with self.assertRaises(ValueError):
            get_user_model().objects.create_user(None, 'pass123')

    def test_create_new_superuser(self):
        """Tests creating a new superuser"""
        email = "verydummy@EMAIL.COM"
        password = "iamdummy"
        user = get_user_model().objects.create_superuser(
            email=email,
            password=password
        )

        self.assertTrue(user.is_superuser)
        self.assertTrue(user.is_staff)
