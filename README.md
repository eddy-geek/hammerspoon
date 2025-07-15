# Hammerspoon Configuration

This repository contains a personal Hammerspoon configuration for macOS automation.

The main goals are:

1. Provide a keyboard & shortcut experience which is closer to Linux(/Windows) ones.
2. Provide dedicated quick app-switching functionality. I first started doing this on Windows with AutoHotkey, then on KDE Linux with KWin scripts.

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


## Annex - Complete macOS Keyboard Event Flow

*Warning: AI-generated*

Here's the updated and complete description of the keyboard event flow on macOS:

![macOS Keyboard Event Flow](docs/macos_keyboard_flow.svg)

**1. Hardware Key Press**
* The initial physical action when you press a key sends a signal to the computer.

**2. IOKit/HID (Hardware Interface Device) Layer**
* **Layer:** Lowest level of macOS input stack, residing in the kernel.
* **Function:** IOKit's HID subsystem communicates directly with hardware devices, receiving raw scan codes from the keyboard.
* **Hook Point (hidutil):** This is where hidutil operates - it's part of the IOHIDFamily driver and provides low-level key remapping functionality introduced in macOS 10.12 Sierra. It can remap keys at the hardware level before they enter the standard input processing pipeline.
* **Hook Point (Karabiner-Elements/Kanata):** The **Karabiner-DriverKit-VirtualHIDDevice** also operates at this level, acting as a virtual keyboard device that intercepts raw hardware events.

**3. HIToolbox/Text Input System**
* **Layer:** System-level text input processing.
* **Function:** This layer handles keyboard layout interpretation and dead key processing.
* **Hook Point (Custom Keyboard Layouts):** Custom keyboard layouts (.keylayout files) are processed here through the HIToolbox framework. They're installed in /Library/Keyboard Layouts/ and selected via System Preferences > Keyboard > Input Sources. These layouts determine how raw key codes are translated into characters based on the active keyboard layout and modifier states.

**4. Quartz (Core Graphics Event Services)**
* **Layer:** System-wide event services layer.
* **Function:** Translates processed input events into higher-level `CGEvent` objects (Core Graphics Events) that represent standardized keyboard events.
* **Hook Point (Karabiner-Elements/Kanata):** This is where **Core Graphics Event Taps** (`CGEventTap`) operate. Karabiner-Elements uses these to intercept, modify, and inject `CGEvent` objects. Kanata uses this same mechanism through the Karabiner driver.

**5. AppKit/Cocoa (Application Framework)**
* **Layer:** Application-level event handling.
* **Function:** Translates `CGEvent` objects into `NSEvent` objects for individual applications.
* **Hook Point (Application-level):** Applications can observe `NSEvent`s, but remapping at this level is application-specific.

**6. Application Processing & Character Input**
* **Function:** Applications process `NSEvent`s to produce final character output or trigger actions, with final consideration of input methods and text processing.**Key Differences Between Hook Points:**

1. **hidutil** - Works at the IOHIDFamily driver level, providing basic key-to-key remapping functionality introduced in macOS 10.12 Sierra. It's the most basic form of system-level remapping.

2. **Karabiner-DriverKit-VirtualHIDDevice** - Creates a virtual keyboard device that can intercept and process events before they reach the standard input pipeline. This is more sophisticated than hidutil and enables complex transformations.

3. **Custom Keyboard Layouts** - Installed as .keylayout files in /Library/Keyboard Layouts/ and selected via System Preferences. They operate at the HIToolbox layer to define how key combinations produce characters, handling things like dead keys and complex input methods.

4. **Karabiner-Elements (CGEventTap)** - Operates at the Quartz layer using Core Graphics Event Taps to intercept, modify, and inject `CGEvent` objects. This provides system-wide control over keyboard events with sophisticated rule-based transformations.

The diagram shows how these different tools and mechanisms operate at various layers of the input stack, with some working at the hardware interface level (hidutil, Karabiner driver) while others work at higher levels for character interpretation (custom layouts) or system-wide event processing (Karabiner-Elements).