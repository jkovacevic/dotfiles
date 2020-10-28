import sublime
import sublime_plugin


class ClearWhitespaceCommand(sublime_plugin.TextCommand):

    def clear_whitespace(self, text):
        import re
        lines = []
        for t in text.splitlines():
            t = re.sub(' +', ' ', t)
            t = t.strip()
            if t:
                lines.append(t)
        return "\n".join(lines)

    def run(self, edit):
        region = sublime.Region(0, self.view.size())
        text = self.view.substr(region)
        text = self.clear_whitespace(text)
        self.view.replace(edit, region, text)
