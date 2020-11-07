import sublime
import sublime_plugin


class ShowSidebarCommand(sublime_plugin.TextCommand):

    def run(self, edit):
        w = self.view.window()
        if not w.is_sidebar_visible():
            w.set_sidebar_visible(True)