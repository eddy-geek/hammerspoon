# Terminal Keyboard Shortcuts mapping

Many of the `Control` key shortcuts are not actually processed by the macOS Terminal application itself, but are passed to the underlying shell, which by default is **Zsh**. These keybindings are part of Zsh's Z Line Editor (zle), which uses Emacs-style shortcuts by default.

Here is the completed table, with Zsh-specific commands noted.

As I want have reserved Ctrl to change focus to various application windows, I am rempping some Ctrl-keys back to Command.

### **macOS Terminal & Zsh Keyboard Shortcuts**

| Key | Control (⌃) | Command (⌘) | Keep Command ? |
| --- | --- | --- | --- |
| **A** | Move cursor to the beginning of the line. `(zsh)` | Select All. | -
| **B** | Move the cursor back one character. `(zsh)` | - | -
| **C** | Send an interrupt signal (SIGINT) to the foreground process, usually terminating it. `(zsh)` | Copy the selected text. | Yes
| **D** | Delete the character under the cursor. If the line is empty, it can log you out (sends EOF). `(zsh)` | Split the window into two panes. | -
| **E** | Move the cursor to the end of the line. `(zsh)` | Find using the selected text. | -
| **F** | Move the cursor forward one character. `(zsh)` | Find text in the current terminal. | Yes
| **G** | Find the next occurrence of the search term. | Find the next occurrence of the search term. | -
| **H** | Delete the character to the left of the cursor (like the Delete key). `(zsh)` |  Hide `(MacOS)` | Yes
| **I** | - | Show the Inspector window with information about the terminal state. | -
| **J** | - | Jump to the selected text in the terminal. | Yes
| **K** | Kill (cut) the text from the cursor to the end of the line. `(zsh)` | Clear the scrollback buffer, effectively clearing the visible terminal screen. | -
| **L** | Clear the screen, similar to the `clear` command. `(zsh)` | - | -
| **M** | - | Minimize `(MacOS)` | Yes
| **N** | Go to the next command in your history (same as the Down Arrow). `(zsh)` | Open a new terminal window with the default profile. | -
| **P** | Go to the previous command in your history (same as the Up Arrow). `(zsh)` | Print the contents of the terminal. | -
| **R** | Reverse-search command history for a specific command. `(zsh)` | - | -
| **S** | - | Save the contents of the terminal to a file. | -
| **T** | Transpose (swap) the two characters immediately before the cursor. `(zsh)` | Open a new tab with the default profile. | Yes
| **U** | Kill (cut) the text from the cursor to the beginning of the line. `(zsh)` | - | -
| **V** | - | Paste text at the cursor's position. | -
| **W** | Kill (cut) the word to the left of the cursor. `(zsh)` | Close the current tab. | Yes (remapped in zsh to Ctrl+Z)
| **Y** | Yank (paste) the text that was last killed (cut). `(zsh)` | - | -
| **Z** | Suspend the foreground process, moving it to the background. `(zsh)` | - | -
| **+** | - | Increase the font size. | Yes
| **-** | - | Decrease the font size. | Yes
| **0** | - | Reset the font size to the actual size. | Yes
| **1...9** | - | Select a specific tab by its number. | Yes
| **[** or **Left Arrow** | - | Switch to the previous tab. | Yes
| **]** or **Right Arrow** | - | Switch to the next tab. | Yes


The list of letters to keep on Cmd is [CFHJMTW].
All symbols remain on Cmd.