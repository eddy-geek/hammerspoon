# Terminal Keyboard Shortcuts mapping

Many of the `Control` key shortcuts are not actually processed by the macOS Terminal application itself, but are passed to the underlying shell, which by default is **Zsh**. These keybindings are part of Zsh's Z Line Editor (zle), which uses Emacs-style shortcuts by default.

The `stty -a` and `bindkeys` commands are used to display the current settings and to change the keybindings.

I have reserved Ctrl to various global hotkeys like changing focus to various application windows, so in Terminal I am remapping some Ctrl-keys back to Command.

This remapping is done in the [sane_keyboard_layout.lua](../sane_keyboard_layout.lua) file. It only works when [SKE](./secure-keyboard-entry.md) is disabled.

### **macOS Terminal & Zsh Keyboard Shortcuts**

*(! There are some discrepancies between the AI slop below and the configuration above)*

| Key | Control (⌃) | Command (⌘) | Keep Cmd ? |
| --- | --- | --- | --- |
| **A** | Move cursor to the beginning of the line. `(zsh)` | Select All. | -
| **B** | Move the cursor back one character. `(zsh)` | - | -
| **C** | Send an interrupt signal (SIGINT) to the foreground process, usually terminating it. `(zsh)` | Copy the selected text. | Yes (remap with `stty intr ^X`)
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
| **O** | `discard` | Open file | Yes
| **P** | Go to the previous command in your history (same as the Up Arrow). `(zsh)` | Print the contents of the terminal. | -
| **Q** | `start` | Quit the terminal. `(MacOS)` | Yes
| **R** | `reprint` / Reverse-search command history for a specific command. `(zsh)` | -
| **S** | `stop` / Go back to the next most recent command | Save the contents of the terminal to a file. | -
| **T** | Transpose (swap) the two characters immediately before the cursor. `(zsh)` | Open a new tab with the default profile. | Yes
| **U** | Kill (cut) the text from the cursor to the beginning of the line. `(zsh)` | - | -
| **V** | - | Paste text at the cursor's position. | Yes
| **W** | Kill (cut) the word to the left of the cursor. `(zsh)` | Close the current tab. | Yes *(remapped in zsh to Ctrl+Z)*
| **Y** | Yank (paste) the text that was last killed (cut). `(zsh)` | - | -
| **Z** | Suspend the foreground process, moving it to the background. `(zsh)` | - | -
| **+** | - | Increase the font size. | Yes
| **-** | - | Decrease the font size. | Yes
| **0** | - | Reset the font size to the actual size. | Yes
| **1...9** | - | Select a specific tab by its number. | Yes
| **[** or **Left Arrow** | - | Switch to the previous tab. | Yes
| **]** or **Right Arrow** | - | Switch to the next tab. | Yes

The list of letters to keep on Cmd vs Swapping with Ctrl is 

```
?   : [                       X  ]
Cmd : [  C  F H J  M O Q  T VW   ]
Ctrl: [AB DE G I KL N P RS U   YZ]
```

All symbols remain on Cmd.


## Ghostty full final bindings table

(modifiers: 🌐  ^  ⌥  ⌘  ⇧)

| Key | Active binding | Inactive binding |
| --- | --- | --- |
| ⌘ A | `beginning-of-line` *(zle)* | Select All *(App)* |
| ⌘ B | `backward-char` *(zle)* | — |
| ⌘ C | Copy selection OR interrupt <br/> `keybind = performable:ctrl+c=copy_to_clipboard` | — |
| ⌘ D | `delete-char-or-list` *(zle)* | Split Right *(App)* |
| ⌘ E | `end-of-line` *(zle)* | — |
| ⌘ F | Find *(App)* | `forward-char` *(zle)* |
| ⌘ G | `send-break` *(zle)* | Find Next *(App)* |
| ⌘ H | Hide *(App)* | `backward-delete-char` *(zle)* |
| ⌘ I | `expand-or-complete` *(zle)* | Terminal Inspector *(App)* |
| ⌘ J | `accept-line` *(zle)* | Jump to Selection *(App)* |
| ⌘ K | `kill-line` *(zle)* | Clear Scrollback *(App)* |
| ⌘ L | `clear-screen` *(zle)* | — |
| ⌘ M | Minimize *(MacOS)* | `accept-line` *(zle)* |
| ⌘ N | `down-line-or-history` *(zle)* | New Window *(App)* |
| ⌘ O | Open… *(App)* | `accept-line-and-down-history` *(zle)* |
| ⌘ P | `up-line-or-history` *(zle)* | Print *(App)* |
| ⌘ Q | Quit *(App)* | push-line *(zle)* |
| ⌘ R | `history-incremental-search-backward` *(zle)* | — |
| ⌘ S | `history-incremental-search-forward` *(zle)* | Save *(App)* |
| ⌘ T | New Tab *(App)* | transpose-chars *(zle)* |
| ⌘ U | `kill-whole-line` *(zle)* | — |
| ⌘ V | Paste *(App)* | `quoted-insert` *(zle)* |
| ⌘ W | Close Tab *(App)* | `backward-kill-word` *(zle)* |
| ⌘ X | - | — |
| ⌘ Y | `yank` *(zle)* | — |
| ⌘ Z | `suspend` *(`stty susp`)* | — |

### App shortcuts

These are from Ghostty default shortcuts: `ghostty +list-keybinds --default`

| Key | binding |
| --- | --- |
| ⌘ + | Increase Font Size
| ⌘ - | Decrease Font Size
| ⌘ 0 | Reset Font Size
| ⌘ = | Increase Font Size
| ⌘ , | open_config
| ⌘ 1…9 | goto_tab:1…8, 9→last_tab
| ⌘ [ | goto_split:previous
| ⌘ ] | goto_split:next
| ⌘ ↑ | jump_to_prompt:-1
| ⌘ ↓ | jump_to_prompt:1
| ⌘ → | text: ^E (move to end of line)
| ⌘ ← | text: ^A (move to beginning of line)
| ⌘ Home | scroll_to_top
| ⌘ End | scroll_to_bottom
| ⌘ PageUp | scroll_page_up
| ⌘ PageDown | scroll_page_down
| ⌘ ⏎ | toggle_fullscreen
| ⌘ ⌫ | text: ^U (kill whole line)
| ⌘⌥⇧ J | write_screen_file:open
| ⌘⌥⇧ W | close_all_windows
| ⌘⌥ I | inspector:toggle
| ⌘⌥ W | close_tab
| ⌘⌥ ↑ | goto_split:up
| ⌘⌥ ↓ | goto_split:down
| ⌘⌥ → | goto_split:right
| ⌘⌥ ← | goto_split:left
| ⌘^ F | toggle_fullscreen
| ⌘^ = | equalize_splits
| ⌘^ ↑ | resize_split:up,10
| ⌘^ ↓ | resize_split:down,10
| ⌘^ → | resize_split:right,10
| ⌘^ ← | resize_split:left,10
| ⌘⇧ D | new_split:down
| ⌘⇧ J | write_screen_file:paste
| ⌘⇧ V | paste_from_selection
| ⌘⇧ W | close_window
| ⌘⇧ , | reload_config
| ⌘⇧ [ | previous_tab
| ⌘⇧ ] | next_tab
| ⌘⇧ ↑ | jump_to_prompt:-1
| ⌘⇧ ↓ | jump_to_prompt:1
| ⌘⇧ ⏎ | toggle_split_zoom
| ^ Tab | next_tab
| ^⇧ Tab | previous_tab
| ⇧ ↑/↓/→/← | adjust_selection:arrow
| ⇧ Home/End | adjust_selection:home/end
| ⇧ PageUp/PageDown | adjust_selection:page_up/page_down
| ⇧⌘ ← | Show Previous Tab
| ⇧⌘ → | Show Next Tab

Note: for letters, Control codes are case-insensitive, so Cmd→Ctrl remap is not active when shift/alt is held, `⇧⌘ <letter>` is not remapped.

### Escape / Meta prefix (^[])

`^[` is the literal ESC character. In zle, ESC acts as the Meta prefix for bindings like `M-b`, `M-f`, etc. With Ghostty set to “Option sends ESC”, pressing `⌥` before a key sends `^[` + `<key>`.

| Key | Active binding | Inactive binding |
| --- | --- | --- |
| Esc (^[) | Meta prefix for next key (e.g., `^[b` → `backward-word`) | Same |

### Option (Meta) bindings (zle)


our `bindkeys`:

| Key | Active binding | Inactive binding |
| --- | --- | --- |
| ⌥ B | backward-word *(zle M-b)* | — |
| ⌥ F | forward-word *(zle M-f)* | — |
| ⌥ D | kill-word *(zle M-d)* | — |
| ⌥ W | copy-region-as-kill *(zle M-w)* | — |
| ⌥ Y | yank-pop *(zle M-y)* | — |
| ⌥ T | transpose-words *(zle M-t)* | — |
| ⌥ U | up-case-word *(zle M-u)* | — |
| ⌥ L | down-case-word *(zle M-l)* | — |
| ⌥ C | capitalize-word *(zle M-c)* | — |
| ⌥ . | insert-last-word *(zle M-.)* | — |
| ⌥ G | get-line *(zle M-g)* | — |
| ⌥ Q | push-line *(zle M-q)* | — |
| ⌥ H | run-help *(zle M-h)* | — |
| ⌥ _ | insert-last-word *(zle M-_)* | — |
| ⌥ Backspace | backward-kill-word *(zle M-^?)* | — |

> Note: Option+Arrow behavior is terminal-config dependent. With “Option sends ESC”, many setups bind:
> - ⌥ ← → M-b (backward-word)
> - ⌥ → → M-f (forward-word)
> - ⌥ Backspace → M-^? (backward-kill-word)
> - ⌥ Delete → M-d (kill-word)

