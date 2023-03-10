from evennia.utils import create
from evennia.utils.test_resources import BaseEvenniaTest

from ..import utils

class TestUtils(BaseEvenniaTest):
    def test_get_obj_stats(self):
        # Make a simple testing object
        obj = create.create_object(
            key="testobj",
            attributes=(
                ("desc", "A test object"),
            )
        )

        # Run it through the function
        result = utils.get_obj_stats(obj)

        # Check the result
        self.assertEqual(
            result,
"""
|ctestobj|n
Value: ~|y10|n coins[Not carried]

A test object

Slots: |w1|n, Used from: |wbackpack|n
Quality: |w3|n, Uses: |winfinite|n
Attacks using |wstrength|n against |warmor|n
Damage roll: |w1d6|n
""".strip()
        )