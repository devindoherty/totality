from commands.command import Command
from evennia import CmdSet

class CmdEcho(Command):
    """
    A simple echo command for testing purposes.

    Usage:
        echo <something>

    """
    key = "echo"

    def func(self):
        self.caller.msg(f"Echo: {self.args.strip()}")


class CmdQuickFind(Command):
    """
    Find an item in your current location.

    Usage:
        quickfind <query>

    """
    key = "quickfind"

    def func(self):
        query = self.args.strip()
        result = self.caller.search(query)
        if not result:
            return
        self.caller.msg(f"Found match for {query}: {result}")

class CmdSetOOC(CmdSet):

    def at_cmdset_creation(self):
        self.add(CmdEcho)
        self.add(CmdQuickFind)