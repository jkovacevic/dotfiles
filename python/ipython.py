try:
	import pandas as pd
	pd.set_option('display.max_rows', 0)
	pd.set_option('display.max_columns', 0)
except:
	pass

def pip_install(package):
    import pip
    message = pip.main(["install", package])
    print(message)


def pip_uninstall(package):
    import pip
    message = pip.main(["uninstall", package])
    print(message)

c.InteractiveShell.color_info = True
c.InteractiveShell.colors = 'Linux'
c.TerminalInteractiveShell.highlighting_style = 'monokai'
c.TerminalInteractiveShell.highlight_matching_brackets = True