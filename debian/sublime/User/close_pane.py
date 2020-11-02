import sublime_plugin

class ClosePaneCommand(sublime_plugin.WindowCommand):
    def run(self):
        w = self.window
        if w.num_groups() != 1:
            w.focus_group(1)
            w.run_command('close')
            w.run_command('set_layout', {
                "cells": [[0, 0, 1, 1]], "cols": [0.0, 1.0], "rows": [0.0, 1.0]
            })