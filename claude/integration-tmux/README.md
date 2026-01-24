# How Tmux Tab Colors Work with Claude

This setup makes your tmux tabs change color based on what Claude is doing. You can glance at your tabs and instantly know if Claude needs attention.

## The Colors

- **Red** - Claude is thinking
- **Yellow** - Claude is waiting for you to type something
- **Cyan** - Claude finished, but you haven't looked yet
- **Green** - Claude is done and you've seen it

## Step by Step

### Step 1: Claude does something

You ask Claude a question. Claude starts thinking. At this moment, Claude runs a hook that calls `status.sh computing`.

### Step 2: The script talks to tmux

The `status.sh` script receives "computing" and tells tmux: "Hey, set a variable called `@claude_status` to `computing` on this window."

### Step 3: Tmux changes the tab color

The `integration-tmux/tmux.conf` file defines how tabs look using `window-status-format` (for inactive tabs) and `window-status-current-format` (for the active tab). Inside these formats, there's a nested if-else chain that checks the value of `@claude_status` and picks the right color. Tmux sees "computing" and makes the tab red.

### Step 4: Claude finishes thinking

Claude is done. It runs `status.sh complete`. The script checks: are you looking at this tab right now?

- If yes: status becomes "idle" (green tab)
- If no: status becomes "unread" (cyan tab)

### Step 5: You come back

You switch to the cyan tab. A tmux hook notices this and changes "unread" to "idle". The tab turns green.

### Step 6: Claude asks you something

Claude needs input. It runs `status.sh prompt`. The tab turns yellow.

## One More Thing

If you restart tmux, all the status variables disappear. The `tmux-init.sh` script fixes this. It runs when tmux starts, finds any windows that have Claude running, and sets them back to green.

That's it. Simple colors that tell you what's happening without looking.
