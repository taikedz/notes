Using GNU Screen
===

GNU Screen is a very useful tool in two respects:

1. If you are at a real TTY and you want the benefit of multiple screens, run GNU Screen and do splitting!
2. If you are logged in via SSH and want to run a process and want the session itself to continue even if the connection drops, screen preserves the session

Of course, there are more uses for it, but those two are already very good for system administration purposes!

## Starting screen

Start a new session by simply issuing the `screen` command

	screen

When in `screen`, press Ctrl+a to enter a mode where you can issue one command to it.

If you want to come out of `screen`, but leave the session running, press Ctrl+a then Ctrl+d.

To resume a session, use the command

	screen -dr

to re-attach to a detached `screen` session.

To see a list of screen sessions, run

	screen -list

This will retrun a list of sessions, along with PID, terminal, and host - for example

	8387.pts-0.home       (Detached)
	12843.pts-0.home      (Attached)

To re-attach to a specific screen, specify the PID, terminal, or host uniquely. FOr screen sessions running only locally, the PID is sufficient

	screen -rd 8387

will re-attach to the relevant session.

NOTE: Using `screen -rd` inside a screen session will attach the current screen into the other in nested fashion - which can be confusing! If you get yourself into this situation, using Ctrl-a, Ctrl-d will completely detach from screen out to the non-screen session... To return to the "outer" screen session, execute instead: `screen -d`. Remenants on the display will look like you are still in the inner-screen - but using the navigation features should should your history from the outer screen session.

Nesting screens is a bad idea generally...

## Splitting screens

Use Ctrl+a followed by `S` (upper case) to split the current screen horizontally

Use Ctrl+a followed by [tab] to give focus to the new screen instance

Use Ctrl+a then `c` (lower case) to create a new shell session in the new screen (if it was not already done)

Use Ctrl+a followed by `|` to split the screen veritcally (more recent version only?).

Kill a screen session with Ctrl+a followed by `X` - note this is upper case.

Using "x" (lower case) will cause the screen to be locked; on resume you will only have one active. You will need to re-split the screens, and load the sessions again using Ctrl+a followed by `"` to see the list of sessions. Selecting one will load that sesion in the currently focused screen.

## Scrolling 

Scroll up and down within a screen session - Ctrl+a followed by `[`

Now you can use

* up/down arrows to move around the display
* Ctrl+u and Ctrl+d to scroll up and down a half screen
* Ctrl+f and Ctrl+b to scroll forward and backwards (full screens)

Press [esc] to exit this mode.
