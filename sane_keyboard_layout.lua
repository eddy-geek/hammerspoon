-- =============================================================================
-- remaps: ⌘+Tab → Ctrl+Tab and ⌘+⇧+Tab → Ctrl+⇧+Tab
-- and swap ⌘+←/→ (Command+Left/Right) with ⌥+←/→ (Option+Left/Right)
-- inspired by https://github.com/zhou13/hammerspoon-windows-mode/blob/master/init.lua

local eventtap = hs.eventtap
local eventTypes = eventtap.event.types
local keycodes = hs.keycodes.map

-- A single remapping function to handle all our custom keyboard logic.
local function keyRemapper(event)
  local keyCode = event:getKeyCode()
  local flags = event:getFlags()

  -- This is a guard clause: if no modifiers are held, do nothing.
  -- This prevents the script from analyzing every single key press.
  -- if flags:isPure() then
  --   return false
  -- end

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


-- =============================================================================
-- Remap F5 to Command + R (page refresh) only if no modifiers are pressed
hs.hotkey.deleteAll({""}, "F5")
hs.hotkey.bind({}, "F5", function()
    hs.eventtap.keyStroke({"cmd"}, "R")
end)

-- =============================================================================
-- F10 / F11 / F12 : Mute/Unmute / Volume Down / Volume Up
-- hs.hotkey.bind({}, "F10", function()
--     local device = hs.audiodevice.defaultOutputDevice()
--     device:setMuted(not device:muted())
-- end)
hs.hotkey.deleteAll({""}, "F11")
hs.hotkey.bind({}, "F11", function()
    local device = hs.audiodevice.defaultOutputDevice()
    local current = device:volume()
    device:setVolume(math.max(0, current - 5))
end)
hs.hotkey.deleteAll({""}, "F12")
hs.hotkey.bind({}, "F12", function()
    local device = hs.audiodevice.defaultOutputDevice()
    local current = device:volume()
    device:setVolume(math.min(100, current + 5))
end)
