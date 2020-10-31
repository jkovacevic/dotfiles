import atexit
import os
import subprocess

ip = get_ipython()
LIMIT = 5000 # limit the size of the history

def edit():
    """save the IPython history to a plaintext file"""
    histfile = os.path.join(ip.profile_dir.location, "/tmp/ipython-history.py")
    print("Saving plaintext history to %s" % histfile)
    lines = [f"{record[2]}\n" for record in ip.history_manager.get_range()]

    with open(histfile, 'w') as f:
        # limit to LIMIT entries
        f.writelines(lines[-LIMIT:])

    subprocess.Popen(['subl', histfile])

# do the save at exit
atexit.register(edit)