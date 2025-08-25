-- Ctrl-...
require("focus_or_launch")

-- use F10 key (Mute icon) to Mute/Unmute Teams globally
require("mute_teams")

-- Cmd-Tab -> Ctrl-Tab, volume: F11, F12
require("sane_keyboard_layout")


-- reload your Hammerspoon config for easy testing
hs.hotkey.deleteAll({"ctrl"}, "r")
hs.hotkey.bind({"ctrl"}, "r", function()
    hs.reload()
    hs.alert.show("Hammerspoon config reloaded!")
end)

-- Global bindings
hs.loadSpoon("HotKeySheet")
spoon.HotKeySheet:bindHotkeys({
    toggle = { { "ctrl"}, "/" }
  })
-- Current app bindings
hs.loadSpoon("KSheet")
spoon.KSheet:bindHotkeys({
    toggle = { { "ctrl", "shift" }, "/" }
  })

-- Show a confirmation that the config has been loaded
hs.alert.show("Hammerspoon config reloaded")

-- https://eastmanreference.com/complete-list-of-applescript-key-codes

-- function mapCmdTab(event)
--     local flags = event:getFlags()
--     local chars = event:getCharacters()
--     if chars == "\t" and flags:containExactly{'cmd'} then
--         hs.eventtap.event.newKeyEvent({"cmd"}, 59, false):post()
--         hs.eventtap.event.newKeyEvent({}, 48, true):post()
--         hs.eventtap.event.newKeyEvent({"ctrl"}, 59, true):post()
--         hs.eventtap.event.newKeyEvent({}, 48, true):post()
--         hs.eventtap.event.newKeyEvent({}, 48, false):post()
--         hs.eventtap.event.newKeyEvent({"ctrl"}, 59, false):post()

--         return true
-- end
-- tapCmdTab = hs.eventtap.new({hs.eventtap.event.types.keyDown}, mapCmdTab)
-- tapCmdTab:start()

-- print(hs.keycodes.map['delete']) -- 51
-- print(hs.keycodes.map['forwarddelete']) -- 117