from typeclasses.objects import Object

class Mob(Object):
    """
    This is a base class for all Mobs (NPCs).
    """

    def move_around(self):
        print(f"{self.key} is moving!")


class Dragon(Mob):
    """
    This is a dragon mob.
    """

    def move_around(self):
        super().move_around()
        print("The world trembles...")

    def firebreath(self):
        """
        Dragons can breathe fire!
        """

        print(f"{self.key} breathes fire!")

class Robot(Mob):
    """
    A robot type mob.
    """

    def beep(self):
        print(f"{self.key} beeps and boops.")

    def service_greeting(self):
        print(f'The {self.key} asks, "How may I be of service?"')


class Medbot(Robot):
    """
    Medical robots.
    """

    def injection(self):
        print(f"The medbot menaces you with a sharp needle!")