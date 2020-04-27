import sublime
import sublime_plugin
sublime.log_commands(True)


class MultiselectToLineCommand(sublime_plugin.TextCommand):

    def on_done(self, content):
        (row,col) = self.view.rowcol(self.view.sel()[0].begin())
        start_row = row
        target_row = int(content)
        print(start_row, target_row)

        region = sublime.Region(self.view.text_point(start_row, 0), self.view.text_point(target_row - 1, 0))        
        self.view.sel().clear()
        self.view.sel().add(self.view.line(region))

    def run(self, edit):
        sublime.active_window().show_input_panel("sel line:", "", self.on_done, None, None)
