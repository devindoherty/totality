from typeclasses.objects import Object

class Sittable(Object):

    def do_sit(self, sitter):
        """
        Called when trying to sit on/in this object.
        
        Args:
            sitter (object): The one trying to sit.
        """

        adjective = self.db.adjective or "on"
        current = self.db.sitter
        if current:
            if current == sitter:
                sitter.msg(f"You are already sitting {adjective} {self.key}.")
            else:
                sitter.msg(f"You can't sit {adjective} {self.key} "
                f"- {current.key} is already sitting there!")
            return
        self.db.sitter = sitter
        sitter.db.is_sitting = True
        sitter.msg(f"You sit on {self.key}.")

    def do_stand(self, stander):
        """
        Called when trying to stand from this object.

        Args:
            stander(object): The one trying to stand.
        """

        current = self.db.sitter
        if not stander == current:
            stander.msg(f"You are not sitting {self.db.adjective} {self.key}.")
        else:
            self.db.sitter = None
            del stander.db.is_sitting
            stander.msg(f"You stand up from {self.key}")