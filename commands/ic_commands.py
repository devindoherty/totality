from commands.command import Command
from evennia import CmdSet
from evennia import InterruptCommand

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
        hit <something> with <weapon>

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

class CmdSit(Command):
    """
    Sit down.

    Usage:
        sit <sittable object>
    """
    key = "sit"

    def parse(self):
        self.args = self.args.strip()
        if not self.args:
            self.caller.msg("Sit on what?")
            raise InterruptCommand

    def func(self):
        # self.search handles all error messages etc.
        sittable = self.caller.search(self.args)
        if not sittable:
            return
        try:
            sittable.do_sit(self.caller)
        except AttributeError:
            self.caller.msg("You can't sit on that.")

class CmdStand(Command):
    """
    Stand up.

    Usage:
        stand
    """
    key = "stand"

    def parse(self):
        pass

    def func(self):
        caller = self.caller
        sittable = caller.db.is_sitting
        if not sittable:
            caller.msg("You are not sitting.")
        else:
            sittable.do_stand(caller)

class CmdTacnet(Command):
    """
    A command to access a Tactical Network overview and commands.

    Usage:
        tacnet
    """
    key = "tacnet"

    def parse(self):
        self.args = self.args.strip()

    def func(self):
        self.caller.msg("[TACNET] Status: Online | Threat Assessment: Low")

class CmdHud(Command):
    """
    Show a basic heads up display in augmented reality.

    Usage:
        HUD <params>
    """
    key = "hud"

    def parse(self):
        self.args = self.args.strip()
    
    def func(self):
        pc = self.caller
        self.caller.msg(f"[HUD] Health: {pc.db.health} | Lucidity: {pc.db.stress} | Messages: 3 Unread | Muse: Researching Exhuman [HUD] Activity on Io")


class CmdMap(Command):
    """
    Displays an AR or VR image of your surroundings.
    """
    key = "map"

    def parse(self):
        self.args = self.args.strip()

    def func(self):
        self.caller.msg(f"[MAP] Current Location: {self.caller.location}")

class CmdFork(Command):
    """
    Split an ego into two discreet entities, still under your control.
    
    Usage:
        fork <target> with <ego bridge or similar device>
    
    Usage (to display all current forks of yourself):
        forks
    
    Creating more than one alpha fork or more than two beta forks at a time 
    will trigger a sanity test.
    """
    key = "fork"

    def parse(self):
        self.args = self.args.strip()
        target, *ego_bridge = self.args.split(" with ", 1)
        if not ego_bridge:
            self.caller.msg(f"You need an ego bridge.")
        self.target = target.strip()
        if ego_bridge:
            self.ego_bridge = ego_bridge[0].strip()
        else:
            raise InterruptCommand

    def func(self):

        # handle no args        
        if not self.args:
            self.caller.msg(f"Who are you trying to fork?")
            return
        
        target = self.caller.search(self.target)
        if not target:
            return
        

        ego_bridge = None
        if self.ego_bridge:
            ego_bridge = self.caller.search(self.ego_bridge)
        if ego_bridge:
            ego_bridge_str = f"{ego_bridge.key}"


        # report the hit
        self.caller.msg(f"You fork {target.key} with {ego_bridge_str}.")
        target.msg(f"Your ego is forked by {self.caller.key} with {ego_bridge_str}!")

class CmdSetIC(CmdSet):
    def at_cmdset_creation(self):
        self.add(CmdFork)
        self.add(CmdHit)
        self.add(CmdHud)
        self.add(CmdMap)
        self.add(CmdSit)
        self.add(CmdStand)
        self.add(CmdTacnet)