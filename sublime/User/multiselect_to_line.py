import os
import sublime
import sublime_plugin
sublime.log_commands(True)


class MultiselectToLineCommand(sublime_plugin.TextCommand):

    def run(self, edit):
        (row,col) = self.view.rowcol(self.view.sel()[0].begin())
        os.environ['_MULTISELECT_TO_LINE'] = str(row)

class MultiselectToLineAfterCommand(sublime_plugin.TextCommand):

    def run(self, edit):
        (row,col) = self.view.rowcol(self.view.sel()[0].end())
        start_row = row
        target_row = int(os.environ['_MULTISELECT_TO_LINE'])
        print(start_row, target_row)

        region = sublime.Region(self.view.text_point(start_row, 0), self.view.text_point(target_row - 1, 0))        
        self.view.sel().clear()
        self.view.sel().add(self.view.line(region))