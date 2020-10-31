import sublime_plugin

class SplitPaneCommand(sublime_plugin.WindowCommand):
    def run(self):
        w = self.window
        if w.num_groups() == 1:
            w.run_command('set_layout', {
                "cols": [0.0, 0.5, 1.0], 
                "rows": [0.0, 1.0],
                'cells': [[0, 0, 1, 1], [1, 0, 2, 1]]
            })
            w.focus_group(0)
            w.run_command('clone_file')
            w.run_command('move_to_group', {'group': 1})
            w.focus_group(1)
        else:
            w.focus_group(1)
            w.run_command('close')
            w.run_command('set_layout', {
                'cols': [0.0, 1.0],
                'rows': [0.0, 1.0],
                'cells': [[0, 0, 1, 1]]
            })