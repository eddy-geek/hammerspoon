# Hammerspoon Configuration

This repository contains a personal Hammerspoon configuration for macOS automation.

The main goals are:

1. Provide a keyboard & shortcut experience which is closer to Linux(/Windows) ones.
2. Provide dedicated quick app-switching functionality. I first started doing this on Windows with AutoHotkey, then on KDE Linux with KWin scripts.

Of all the tools available (see the keyboard flow [docs](docs/macos-keyboard-input-handling.md))
I am trying to stick
 to
 * hidutil (low-level key remapping, eg modifiers and F-keys)
 * custom keyboard layout (for accents, compose key)
 * Hammerspoon (for most shortcuts and automation)
 
 Notably I am skipping Karabiner as it is heavy and can have compatibility issues ([Karabiner-Elements#3708](https://github.com/pqrs-org/Karabiner-Elements/issues/3708)).

## Dependencies

To make the experience closer to Linux, I am remapping the keys in the main MacOS hardware keyboard (in *Settings > Keyboard > Keyboard Shortcuts > Modifier keys*) as follows:

```
Before:   🌐  ^  ⌥  ⌘   (Fn     Control Option  Command)
After :   ⌘  🌐  ^  ⌥   (Command   Fn   Control  Option)
```

![Macbook Keyboard Modifiers](docs/keyboard-modifiers-macbook.png)

On typical external Windows keyboards, it issimpler as only Command (Windows logo) and Control need to be swapped. When using Keychron keyboard which have a MacOS mode, I leave them in Windows mode.

```
Before:   ^   ⊞ = ⌘   ⌥    (Control ; Windows == Command ; Alt == Option)
After :   ⌘     ^     ⌥    (Command      Control  Option)
```

![External Keyboard Modifiers](docs/keyboard-modifiers-external.png)

(Note that this remapping has to be done for each external keyboard you connect, unless you use a separate tool like Karabiner-Elements)



## Hotkeys

The following table lists all the configured hotkeys and their actions.

| Hotkey             | Action                                                              |
| ------------------ | ------------------------------------------------------------------- |
| `Ctrl + R`         | Reload Hammerspoon configuration                                    |
| `F10`              | Toggle mute in Microsoft Teams (only during an active meeting)      |
| `F11`              | Volume Down                                                         |
| `F12`              | Volume Up                                                           |
| `F5`               | Refresh (sends `Cmd + R`)                                           |
| `Ctrl + E`         | Focus/Launch Finder                                                 |
| `Ctrl + Z`         | Focus/Launch Terminal                                               |
| `Ctrl + S`         | Focus/Launch System Settings                                        |
| `Ctrl + F`         | Focus/Launch Firefox                                                |
| `Ctrl + G`         | Focus/Launch Google Chrome                                          |
| `Ctrl + H`         | Focus/Launch Safari                                                 |
| `Ctrl + A`         | Focus/Launch Anytype                                                |
| `Ctrl + N`         | Focus/Launch Lapce                                                  |
| `Ctrl + V`         | Focus/Launch Visual Studio Code                                     |
| `Ctrl + X`         | Focus/Launch Windsurf                                               |
| `Ctrl + T`         | Focus/Launch Microsoft Teams                                        |
| `Ctrl + W`         | Focus/Launch Microsoft Word                                         |
| `Ctrl + P`         | Focus/Launch Microsoft Powerpoint                                   |
| `Ctrl + Q`         | Focus/Launch Microsoft 365 Copilot                                  |
| `Ctrl + I`         | Focus/Launch PaintZ                                                 |
| `Ctrl + C`         | Focus/Launch Microsoft Outlook and switch to Calendar view          |
| `Ctrl + M`         | Focus/Launch Microsoft Outlook and switch to Mail view              |

## Key Remappings

Swapping Command and Control is the easiest solutions since it covers the many app-specific hotkeys, but it is a bit too extreme, so some things need to be "swapped back" with those remappings:

This configuration also includes the following key remappings to provide a more consistent experience:

- `Cmd + Tab` is remapped to `Ctrl + Tab` for application switching together with `Cmd + Shift + Tab`.
- `Cmd + Left/Right Arrow` behavior is swapped with `Option + Left/Right Arrow` for text navigation.
- `Cmd + Delete` behavior is swapped with `Option + Delete`.

## Future Improvements

* Fix terminal as it is using Ctrl for special characters, conflicting with my app focus hotkeys.
* Use of spoons

