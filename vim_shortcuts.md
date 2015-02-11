# Essential vim shortcuts

Where [N] is indicated, prefix the command with a number. `dd` will delete the current line; `5dd` will delete the current line and subsequent 4 lines (total of 5). The default for N is 1

## Navigation

A single line is from CR/LF to CR/LF and is referred to here as a hard line. When the hard line spans multiple on-screen lines, it is wrapped. The "wrapped line" is the line of text as displayed, and varies depending on window width.

|Key/combo         | Effect
|------------------|----------------------
Lt,Rt ; h,l | left or right [N] characters
Dn,Up ; j,k | down or up [N] hard lines
) ; ( | forward/backward one sentence
PgDn/PgUp ; Ctrl+D/U ; Shift+Dn/Up | Scroll a full page up or down
Shift+Lt/Rt ; w,b | back or forwards by [N] words
Home,End ; ^,$ | Start/end of hard line
g+Home,g+End ; g+^,g+$ | Start/end of wrapped line
v | start/stop selecting by character (navigation and yanking commands can be used)
V | start/stop selecting by line (nav and yank commands can be used)
Ctrl+V | start/stop selecting by rectangular block (nav and yank commands can be used)

### Marks

|Key/combo         | Effect
|------------------|----------------------
m\{a-z\} | set a mark
`\{a-Z\} | go to a mark
:marks | display current marks


## Editing

|Key/combo         | Effect
|------------------|----------------------
i ; a | Go to insert mode before/after character under the cursor
o ; O | Open a new line under/above the line under the cursor and go to insert mode
r \{char\} | replace the next [N] characters with \{char\}
u | undo [N] actions
Ctrl+R | redo [N] actions
gu ; gU | To lower/upper case
g? \{Lt/Rt/Home/End\} | (g with question mark) perform ROT-13 on ASCII alphas
\> ; \< | Indent/outdent by [N] tab stops
\>\> ; \<\< | Indent/outdent current line and next [N-1] lines by 1 tab stop
Ctrl+K \{di\} \{char\} | In insert mode - insert a digraph: ' + a = á

## Cut/copy/paste

* Note: the terminology for "copy" is "yank"
* Note: Any single delete command (including numeral as part of the command) is also effectively a cut - it is "yank and delete"


|Key/combo         | Effect
|------------------|----------------------
y \{Lt\} | yank the character under the cursor, and the next [N-1] characters
y \{Rt\} | yank the first [N] characters before the cursor
yy | yank the current line and the subsequent [N-1] lines
x ; Del | Delete the character under the cursor and [N-1] subsequent characters
X | Delete the character under the cursor, and [N-1] previous characters
dd | Delete the line under the cursor, and [N-1] lines below
D | Delete to the end of the line
J | join lines
" \{char\} | name a register (clipboard) with a singe character
:reg | print current registers

You can use `"\{char\}` to determine the register to use for the next operation. Note that after a single paste, you will return to the previous register in use, but that the last yank determines the "current working register". 

## Search/replace

|Key/combo         | Effect
|------------------|----------------------
* ; # | Search forward/backward for the word under the cursor
/ \{pattern\} ; ? \{pattern\} | search forward or backward for the pattern
:s/foo/bar/g | Find and replace all foo with bar in the current line
:s/foo/bar/gc | Find and replace all foo with bar in the current line, ask to confirm
:s/foo \zstoreplace\se bar/replaced/ | Find and replace "toreplace" with "replaced" without replacing the rest of the match
:%s/foo/bar/g | Find and replace all foo with bar in all lines

## Files

|Key/combo         | Effect
|------------------|----------------------
Ctr+G | Show current file name
:bn ; :bp | Previous/next file
(??)  | Go to file
:tabe \{filepath\} | open the file or buffer in a new tab
:tabn ; :tabp | go to previous/next tab
:edit \{filepath\} | Open new/existing buffer
:new \{filepath\} | New split screen with buffer
Ctrl+W c | Close window
Ctrl+Dn/Up | Go to the next/previous window

## Misc

|Key/combo         | Effect
|------------------|----------------------
:set paste | turn off autoindent for pasting from X clipboard
:set nopaste | cancel "paste" mode
ga ; g8 | display the ASCII or UTF-8 code in the status area
