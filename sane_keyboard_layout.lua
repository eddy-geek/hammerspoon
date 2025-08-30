-- =============================================================================
-- remaps: ⌘+Tab → Ctrl+Tab and ⌘+⇧+Tab → Ctrl+⇧+Tab
-- and swap ⌘+←/→ (Command+Left/Right) with ⌥+←/→ (Option+Left/Right)
-- inspired by https://github.com/zhou13/hammerspoon-windows-mode/blob/master/init.lua

fileInfo()

local eventtap = hs.eventtap
local eventTypes = eventtap.event.types
local keycodes = hs.keycodes.map

-- Per-app: treat ⌘ as ⌃ in Terminal/iTerm for letters (so MOD1 works as Ctrl)
local TERMINAL_BUNDLES = {
  ["com.apple.Terminal"] = true,
  ["com.googlecode.iterm2"] = true,
  ["com.iterm2"] = true,
  ["com.mitchellh.ghostty"] = true,
}

-- In Terminal, keep native ⌘ behavior for these letters (lowercase)
-- User's keep list: F H J M O Q T V W
local TERMINAL_CMD_KEEP = { f = true, h = true, j = true, m = true, o = true, q = true, t = true, v = true, w = true }

-- A single remapping function to handle all our custom keyboard logic.
local function keyRemapper(event)
  local keyCode = event:getKeyCode()
  local flags = event:getFlags()

  -- This is a guard clause: if no modifiers are held, do nothing.
  -- This prevents the script from analyzing every single key press.
  if not flags.cmd and not flags.alt and not flags.ctrl and not flags.fn then
    return false
  end

  -- Terminal/iTerm: map Cmd+[a-z] to Ctrl+[a-z] (except keep list) so Cmd acts as Ctrl in Terminal.
  -- Preserve Shift/Alt; emit synthetic keystroke and temporarily disable hs.hotkey
  -- to prevent your Ctrl-based global focus bindings from firing.
  do
    local front = hs.application.frontmostApplication()
    local bid = front and front:bundleID() or nil
    if bid and TERMINAL_BUNDLES[bid] and flags.cmd and not flags.shift and not flags.alt then
      local ch = event:getCharacters(true) -- lowercase letter without modifiers
      if ch and ch:match("^[a-z]$") and not TERMINAL_CMD_KEEP[ch] then
        print ("Force Send ctrl + " .. ch .. " in Terminal")
        local mods = { "ctrl" }
        -- Consume original and send synthetic Ctrl+[letter]
        hs.hotkey.disableAll(mods, ch)
        hs.eventtap.keyStroke(mods, ch, 0)
        hs.timer.doAfter(0.02, function() hs.hotkey.enableAll(mods, ch) end)
        return true  -- Consume the event
      end
    end
  end

  -- remaps: ⌘Cmd+↹Tab → ^Ctrl+↹Tab and ⌘+⇧+↹ → ^+⇧+↹
  -- Only intercept if ^Command is held and ↹Tab is pressed
  if keyCode == keycodes["tab"] and flags.cmd then
    -- Remove Command, add Control
    flags.cmd = false
    flags.ctrl = true
    event:setFlags(flags)
    return false -- Let the modified event pass through
  end

  -- Swap ⌘+←/→ (Command+Left/Right) with ⌥+←/→ (Option+Left/Right)
  if keyCode == keycodes["left"] or keyCode == keycodes["right"] or keyCode == keycodes["delete"] then
    -- CASE 1: If Command is pressed (but not Option), swap it to Option.
    if flags.cmd and not flags.alt then
      flags.cmd = false
      flags.alt = true
      event:setFlags(flags)
      return false -- Let the newly modified event (Option+Arrow) pass through.
    -- CASE 2: If Option is pressed (but not Command), swap it to Command.
    elseif flags.alt and not flags.cmd then
      flags.alt = false
      flags.cmd = true
      event:setFlags(flags)
      return false -- Let the newly modified event (Command+Arrow) pass through.
    end
  end

  -- For any other key combination, do not interfere.
  return false
end

-- Create and start the global event watcher.
-- It's crucial this is not a 'local' variable to prevent crashes.
keyWatcher = eventtap.new({ eventTypes.keyDown }, keyRemapper)
keyWatcher:start()

-- debugging - sometimes the main keyWatcher breaks but this one still runs
-- hs.eventtap.new(
--     { hs.eventtap.event.types.flagsChanged },
--     function(event)
--         print("flagsChanged", hs.inspect(event:getFlags()))
--     end
-- ):start()

-- =============================================================================
-- Remap F5 to Command + R (page refresh) only if no modifiers are pressed
hs.hotkey.deleteAll({""}, "F5")
hs.hotkey.bind({}, "F5", keyInfo("Refresh page (⌘+R)"), function()
    hs.eventtap.keyStroke({"cmd"}, "R")
end)

-- =============================================================================
-- F10 / F11 / F12 : Mute/Unmute / Volume Down / Volume Up
-- hs.hotkey.bind({}, "F10", function()
--     local device = hs.audiodevice.defaultOutputDevice()
--     device:setMuted(not device:muted())
-- end)

-- BUG: F11 gives LuaSkin: hs.hotkey:enable() keycode: 103, mods: 0x0000, RegisterEventHotKey failed: -9878
hs.hotkey.deleteAll({""}, "F11")
hs.hotkey.bind({}, "F11", keyInfo("Volume Down (broken!)"), function()
    local device = hs.audiodevice.defaultOutputDevice()
    local current = device:volume()
    device:setVolume(math.max(0, current - 5))
end)
hs.hotkey.deleteAll({""}, "F12")
hs.hotkey.bind({}, "F12", keyInfo("Volume Up"), function()
    local device = hs.audiodevice.defaultOutputDevice()
    local current = device:volume()
    device:setVolume(math.min(100, current + 5))
end)
