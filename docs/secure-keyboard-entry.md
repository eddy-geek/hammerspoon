# Secure Keyboard Entry (SKE) on macOS

- Secure Keyboard Entry is a macOS protection that prevents other processes from observing keystrokes in the current app. When SKE is active for the frontmost app, global event taps that read keydown/keyup events are blocked to mitigate keylogging.
- __Impacts__: text expansion, typed triggers, keyloggers, `hs.eventtap`-based handlers.
- __Common enablers__: Terminal, iTerm2, 1Password, secure fields.
- __Fix__: Toggle off in the owning app or close it; lock/unlock if stuck.
## How it works
- __Scope__: Applies to the app that enabled it (frontmost target). It doesn’t mute the whole system, only input observation for that app.
- __Mechanism__: Blocks API paths like CGEvent taps used by Accessibility to read raw keystrokes.
- __Who enables it__: Some apps toggle SKE while you’re focused on them or on sensitive fields.

## Who enables SKE commonly
- __Terminal.app__: “Terminal > Secure Keyboard Entry” menu item.
- __iTerm2__: “iTerm2 > Secure Keyboard Entry”.
- __Password managers__: e.g., 1Password enables SKE while unlocked or in password fields.
- __System password fields__: Some Apple dialogs/fields may engage secure input automatically.

## What breaks when SKE is active
Apps/features that rely on reading raw keystrokes via event taps (Accessibility) won’t see keys in the secured app:
- __Text expansion/typed string triggers__: TextExpander, Keyboard Maestro typed string triggers, Alfred snippets, Hammerspoon text-expansion via `hs.eventtap`.
- __Keyloggers / clipboard managers__ that capture typed text.
- __Hammerspoon specifics in this repo__:
  - `hs.eventtap`-based listeners won’t receive key events in the secured app.
  - `hs.hotkey`-based global hotkeys usually still work (they don’t rely on raw event taps in the same way).
  - Window management, mouse, and non-keyboard features are unaffected.

Typically not affected:
- __Karabiner-Elements__ (operates at a different input layer; generally continues to work).
- __Normal app shortcuts__ within the secured app.
- __Clipboard history__ not based on keylogging.

## How to tell if SKE is on
- __Terminal/iTerm2 menu__: Check “Secure Keyboard Entry” checkmark.
- __Find owning PID__:
  ```bash
  ioreg -l -w 0 | grep -i SecureInput
  ```
  Look for `kCGSSessionSecureInputPID` = <pid>. That PID is the process currently holding secure input.

## How to turn it off
- __Toggle in the owning app’s menu__ (Terminal/iTerm2).
- __For password managers__: Lock the vault/close the app; it should release SKE.
- __If stuck__:
  - Quit the app with the PID from `kCGSSessionSecureInputPID`.
  - Switch focus away and back, or lock/unlock the screen.
  - As a last resort, reboot.

## Practical notes for an Hammerspoon setup
- If any of your modules use `hs.eventtap` for keystroke handling or text expansion, they won’t receive keys while you’re in a secured app like Terminal with SKE enabled.
- Hotkeys defined via `hs.hotkey` should continue to work globally.
- If something “randomly” stops reacting to keys only in Terminal/iTerm2 or while 1Password is open, suspect SKE first.˝