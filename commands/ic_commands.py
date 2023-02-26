from commands.command import Command
from evennia import CmdSet

class CmdHack(Command):
    pass

class CmdAttack(Command):
    pass

class CmdKill(Command):
    pass

class CmdHit(Command):
    """
    A simple attack with or without a weapon.

    Usage:
        hit <something>

    """
    key = "hit"

    def parse(self):
        self.args = self.args.strip()
        target, *weapon = self.args.split(" with ", 1)
        if not weapon:
            target, *weapon = target.split(" ", 1)
        self.target = target.strip()
        if weapon:
            self.weapon = weapon[0].strip()
        else:
            self.weapon = ""

    def func(self):

        # handle no args        
        if not self.args:
            self.caller.msg(f"Who do you want to hit?")
            return
        
        # get the target for the hit
        target = self.caller.search(self.target)
        if not target:
            return
        
        # get and handle the weapon
        weapon = None
        if self.weapon:
            weapon = self.caller.search(self.weapon)
        if weapon:
            weaponstr = f"{weapon.key}"
        else:
            weaponstr = "bare fists"

        # report the hit
        self.caller.msg(f"You hit {target.key} with {weaponstr}")
        target.msg(f"You get hit by {self.caller.key} with {weaponstr}")

class CmdSetIC(CmdSet):
    def at_cmdset_creation(self):
        self.add(CmdHit)