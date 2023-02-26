"""
Characters

Characters are (by default) Objects setup to be puppeted by Accounts.
They are what you "see" in game. The Character class in this module
is setup to be the "default" character type created by the default
creation commands.

"""
from evennia.objects.objects import DefaultCharacter
import random


from .objects import ObjectParent


class Character(ObjectParent, DefaultCharacter):
    """
    The Character defaults to reimplementing some of base Object's hook methods with the
    following functionality:

    at_basetype_setup - always assigns the DefaultCmdSet to this object type
                    (important!)sets locks so character cannot be picked up
                    and its commands only be called by itself, not anyone else.
                    (to change things, use at_object_creation() instead).
    at_post_move(source_location) - Launches the "look" command after every move.
    at_post_unpuppet(account) -  when Account disconnects from the Character, we
                    store the current location in the pre_logout_location Attribute and
                    move it to a None-location so the "unpuppeted" character
                    object does not need to stay on grid. Echoes "Account has disconnected"
                    to the room.
    at_pre_puppet - Just before Account re-connects, retrieves the character's
                    pre_logout_location Attribute and move it back on the grid.
    at_post_puppet - Echoes "AccountName has entered the game" to the room.

    """

    def at_pre_move(self, destination, **kwargs):
        """
        Called by self.move_to when trying to move somewhere. 
        If this returns false the move is immediately cancelled.
        """
        if self.db.is_sitting:
            self.msg("You need to stand first.")
            return False
        return True

    def at_object_creation(self):
        # Aptitudes
        self.db.cognition = random.randint(5, 30)
        self.db.intuition = random.randint(5, 30)
        self.db.reflexes = random.randint(5, 30)
        self.db.savvy = random.randint(5, 30)
        self.db.somatics = random.randint(5, 30)
        self.db.willpower = random.randint(5, 30)

        # Stats
        self.db.initiative = (self.db.reflexes + self.db.intuition) // 5
        self.db.lucidity = self.db.willpower * 2
        self.db.insanity = self.db.lucidity * 2
        self.db.health = 100
        self.db.sanity = 100

        # Skills
        self.db.athletics = self.db.somatics
        self.db.deceive = self.db.savvy
        self.db.dodge = self.db.reflexes
        self.db.free_fall = self.db.reflexes
        self.db.guns = self.db.reflexes
        self.db.engineering = self.db.cognition
        self.db.infiltrate = self.db.reflexes
        self.db.infosec = self.db.cognition
        self.db.interface = self.db.cognition
        self.db.kinesics = self.db.savvy
        self.db.sciences = self.db.cognition
        self.db.arts = self.db.intuition
        self.db.medicine = self.db.cognition
        self.db.melee = self.db.somatics
        self.db.perception = self.db.intuition
        self.db.persuade = self.db.savvy
        self.db.pilot = self.db.reflexes
        self.db.program = self.db.cognition
        self.db.provoke = self.db.savvy
        self.db.psi = self.db.willpower
        self.db.psychosurgery = self.db.cognition
        self.db.research = self.db.intuition
        self.db.survival = self.db.intuition

        # Rep Scores
        self.db.circle_a_rep = random.randint(0, 50)
        self.db.c_rep = random.randint(0, 50)
        self.db.f_rep = random.randint(0, 50)
        self.db.g_rep = random.randint(0, 50)
        self.db.i_rep = random.randint(0, 50)
        self.db.r_rep = random.randint(0, 50)
        self.db.x_rep = random.randint(0, 50)

        # Conditions
        self.db.is_sitting = False

    def get_aptitudes(self):
        """
        Printout the main aptitudes of the player's ego.
        """
        print("Aptitudes")
        print("************")
        print(f"Cognition: {self.db.cognition}")
        print(f"Intuition: {self.db.intuition}") 
        print(f"Reflexes: {self.db.reflexes}")
        print(f"Savvy: {self.db.savvy}"), 
        print(f"Somatics: {self.db.somatics}")
        print(f"Willpower: {self.db.willpower}|/")

    def get_stats(self):
        """
        Prints out derived and morph influenced stats.
        """
        print("Stats")
        print("************")
        print(f"Health: {self.db.health}")
        print(f"Stress: {self.db.stress}")
        print(f"Initiative: {self.db.initiative}")
        print(f"Durability: {self.db.durability}") 
        print(f"Lucidity: {self.db.lucidity}")
        print(f"Insanity: {self.db.insanity}|/") 

    def get_skills(self):
        print("Skills")
        print("************")
        print(f"Athletics: {self.db.athletics}")
        print(f"Deceive: {self.db.deceive}")
        print(f"Fray: {self.db.fray}") 
        print(f"Free Fall: {self.db.free_fall}")
        print(f"Guns: {self.db.guns}")
        print(f"Engineering: {self.db.engineering}|/")

    def get_reps(self):
        """
        Prints out a PC's reputation scores
        """
        
        print("Reputation Scores")
        print("************")
        print(f"@-rep: {self.db.circle_a_rep}")
        print(f"c-rep: {self.db.c_rep}")
        print(f"f-rep: {self.db.f_rep}")
        print(f"g-rep: {self.db.g_rep}")
        print(f"i-rep: {self.db.i_rep}")
        print(f"r-rep: {self.db.r_rep}")
        print(f"x-rep: {self.db.x_rep}|/")

    def get_status(self):
        self.get_aptitudes()
        self.get_stats()
        self.get_skills()
        self.get_reps()
