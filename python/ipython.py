try:
	import pandas as pd
	pd.set_option('display.max_rows', 0)
	pd.set_option('display.max_columns', 0)
except:
	pass

try:	
	import numpy as np
	np.core.arrayprint._line_width = 120
	np.set_printoptions(formatter={'float_kind': lambda x: "%.2f" % x})
except:
	pass

c.TerminalInteractiveShell.highlighting_style = 'monokai'
c.TerminalInteractiveShell.highlight_matching_brackets = False