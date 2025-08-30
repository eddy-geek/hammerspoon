-- ---------------------
-- --    PREAMBLE     --
-- ---------------------

require("Helpers.Base")
-- require("Functions.ConfigConsole")
-- require("Helpers.ErrorCatcher")
-- hs.notify.show("Hammerspoon", "Starting Hammerspoon: ", hs.screen.mainScreen():name())
-- require("Helpers.Util")
-- -- enable local patches
-- hs.window.filter = require("Helpers.Extensions.window_filter")
-- hs.alert = require("Helpers.Extensions.alert")
hs.hotkey = require("Helpers.Extensions.hotkey")

-- -- Note: You may setup this hyper Key with Karabiner ELements
-- hyper = { "shift", "ctrl", "alt", "cmd" }

-- require('Functions.Reload')
-- require("Functions.ConfigConsole")
-- require('Functions.StartDebug')

-- require("Helpers.Extensions.String")
-- require("Helpers.Extensions.Table")
-- require("Helpers.Extensions.WindowFilterEvents")
-- require("Helpers.Extensions.WindowAxHotfix")

-- require("Helpers.Debug")
-- require("Helpers.DebugFunction")

-- -- require("Helpers.Enum")
-- -- require("Helpers.RetryWhile")
-- -- require("Helpers.RetryWhileOnComplete")

-- require("Helpers.HotkeySilence")
-- require("Helpers.SendKeysOnlyInApp")
-- require("Helpers.HotkeyBindModal")
-- require("Helpers.HotkeyBindSafe")

-- helper = {
--     table = require('Helpers.Table'),
--     window = require('Helpers.Window'),
-- }

-- require('Functions.ReloadWatcher')

-- ---------------------
-- --    MUESCHUA     --
-- ---------------------
-- -- require('Functions.ChromeNewWindow')  -- buggy in Lapce, infinite loop
-- require('Functions.CheatSheet')         -- h+x, h+a
-- -- require('Functions.ContextMenu')        -- h+s, shift+F10, broken on multi-display
-- require('Functions.FuzzyWindowSearch')  -- h+e
-- require('Functions.AudioSwitcher')      -- h-7
-- require('Functions.Caffeine')           -- h-c
-- require('Functions.MemoryAppBar') -- show current used memory

---------------------
--    MY STUFF     --
---------------------

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