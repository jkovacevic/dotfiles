try:
	import pandas as pd
	pd.set_option('display.max_rows', 0)
	pd.set_option('display.max_columns', 0)
except:
	pass

try:	
	import numpy as np
	np.core.arrayprint._line_width = 120
	np.set_printoptions(formatter={'float_kind': lambda x: "%.4if" % x})
except:
	pass

c.InteractiveShell.color_info = True
c.InteractiveShell.colors = 'Linux'
c.TerminalInteractiveShell.highlighting_style = 'monokai'
c.TerminalInteractiveShell.highlight_matching_brackets = True