#!/usr/bin/python3
import pyperclip
import re

patterns = [
    "(.*)?\\[.*\\].* >",
    "^In \\[.*\\]:"
]

def match_patterns(patterns, s):
    for p in patterns:
        m = re.search(p, s)
        if m:
            s = s[m.end():].strip()
            if re.search("\\[.*\\]$", s):   # Ends with git branch tag, e.g. [master]
                s = re.sub("\\[.*\\]$", "", s).strip()

            import subprocess
            subprocess.call(["xdotool", "key", "ctrl+u"])
            return s

    return s.strip()

try:
    clip_string = pyperclip.paste()
    clip_string = match_patterns(patterns, clip_string)
    pyperclip.copy(clip_string)
except Exception as e:
    with open("/tmp/tidy-clipboard.err.log", "w+") as f:
        print(e, file = f)
    f.close()


def test(patterns):
    samples = [
        ["[20:59:06] ArchLinux /tmp/folder >howdy partner", "howdy partner"],
        ["[20:59:06] /home/jk > whats popin babydoll", "whats popin babydoll"],
        ["[20:59:06] /home/jk >", ""],
        ["In [2]: dsadada", "dsadada"],
        ["In [2]:", ""],
        ["[20:59:06] /tmp/jk > hello broooo whatsupp           [master]", "hello broooo whatsupp"],
        ["(venv) [20:59:06] /tmp/jk > hello broooo whatsupp           [master]", "hello broooo whatsupp"],
        ["In [2]: pd.DataFrame(columns=['x', 'y', data=[[1, 2], [3, 4]])", "pd.DataFrame(columns=['x', 'y', data=[[1, 2], [3, 4]])"],
        ['In [50]: df = pd.read_csv("tmp/england-premier.csv", header=True)', 'df = pd.read_csv("tmp/england-premier.csv", header=True)'],
    ]

    for s in samples:
        assert match_patterns(patterns, s[0]) == s[1]
    print("Tests passed successfully")

# test(patterns)