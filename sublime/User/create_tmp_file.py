import sublime
import sublime_plugin
sublime.log_commands(True)


class CreateTmpFileCommand(sublime_plugin.TextCommand):

    def create_tmp_file(self):
        import uuid
        tmp_file = "/tmp/" + str(uuid.uuid1())
        open(tmp_file, 'a').close()
        w = sublime.active_window()
        w.open_file(tmp_file)
        pass

    def run(self, edit):
        self.create_tmp_file()
