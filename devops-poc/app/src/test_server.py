#!/usr/bin/python

import unittest

from server import create_person

class Test(unittest.TestCase):    
    def test_create_person(self):
        person = create_person()
        assert "John Doe" == person["name"]
        assert "id" in person
        assert person["id"] is not None
