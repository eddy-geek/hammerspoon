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

-- patch hs.hotkey for enableAll
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

-- Mouse drag move/resize
-- require("window_drag_resize")

local SkyRocket = hs.loadSpoon("SkyRocket")

sky = SkyRocket:new({
  opacity = 0.4, -- Opacity of resize canvas
--   grid=hs.grid.setGrid('5x4'),
  moveModifiers = {'ctrl'}, -- Which modifiers to hold to move a window?
  moveMouseButton = 'left', -- Which mouse button to hold to move a window?
  resizeModifiers = {'ctrl'}, -- Which modifiers to hold to resize a window?
  resizeMouseButton = 'right', -- Which mouse button to hold to resize a window?
  focusWindowOnClick = false, -- Should the current window be focused & brought to the front when you click on it?
  -- clo4 fork
  enableMove = true,

  -- FIXME the wyne fork interacts badly with my other key ? somehow after some time, ^C etc stops being intercepted, 
--   preview = true,
-- but I really need the 'choose correct corner to resize' thing
})

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

-- dead attempt at reusing the native mechanism
-- Ctrl_cmd_down = false
-- hs.eventtap.new({ hs.eventtap.event.types.leftMouseDown },
--     function(event)
--         -- if ctrl is down, hold cmd down too to trigger the built-in NSWindowShouldDragOnGesture
--         if not Ctrl_cmd_down and event:getFlags():contain({"ctrl"}) then
--             Ctrl_cmd_down = true
--             hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseUp, hs.mouse.absolutePosition()):post()
--             hs.eventtap.event.newKeyEvent(hs.keycodes.map.cmd, true):post()
--             hs.eventtap.event.newKeyEvent(hs.keycodes.map.ctrl, true):post()
--             hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown, hs.mouse.absolutePosition()):post()
--         end
--         return false
--     end
-- ):start()
-- hs.eventtap.new({ hs.eventtap.event.types.leftMouseUp },
--     function(event)
--         if Ctrl_cmd_down then
--             hs.eventtap.event.newKeyEvent(hs.keycodes.map.cmd, false):post()
--         Ctrl_cmd_down = false
--         end
--         return false
--     end
-- ):start()
