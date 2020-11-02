import sublime
import sublime_plugin


class HideSidebarCommand(sublime_plugin.TextCommand):

    def run(self, edit):
        w = self.view.window()
        if w.is_sidebar_visible():
            w.set_sidebar_visible(False)