def setup_pandas():
    import pandas as pd
    pd.set_option('display.max_rows', 0)
    pd.set_option('display.max_columns', 0)

def varz():
    print("- Variables:\n{}\n".format("\n".join([x for x in  vars() if "_" not in x])))

c.InteractiveShell.color_info = True
c.InteractiveShell.colors = 'Linux'
c.TerminalInteractiveShell.highlighting_style = 'monokai'
c.TerminalInteractiveShell.highlight_matching_brackets = True