-- =============================================================================
-- App-Specific Window Cycler
-- =============================================================================

--[[
-- This function cycles through an application's windows.
-- It now includes a 'forceLaunch' boolean option.
--
-- Parameters:
--   appName (string): The exact name of the application to target.
--   forceLaunch (boolean): If true, the function will launch the application
--                          if it's not running or has no standard windows open.
--                          If false, it will show an alert and do nothing.
--]]
local function cycleAppWindows(appName, forceLaunch)
  local app = hs.application.get(appName)

  -- 1. Handle the case where the application is not running at all.
  if not app then
    if forceLaunch then
      -- If forceLaunch is true, launch the app and then exit the function.
      hs.application.launchOrFocus(appName)
    else
      -- Otherwise, just show an alert.
      hs.alert.show("'" .. appName .. "' is not running.")
    end
    return -- Exit the function
  end

  -- At this point, we know the app is running. Let's get its windows.
  local allAppWindows = app:allWindows()
  
  -- Filter out windows that aren't standard (e.g., tool palettes, inspectors)
  -- and windows that are currently minimized.
  local appWindows = hs.fnutils.filter(allAppWindows, function(w)
    return w:isStandard() and not w:isMinimized()
  end)

  -- 2. Handle the case where the app is running but has no usable windows.
  if #appWindows == 0 then
    if forceLaunch then
      hs.application.launchOrFocus(appName)
      -- The app is running but has no windows (or all are minimized).
      -- Activating it brings it to the front. Many apps will create a
      -- new window if they don't have one when activated.
      -- app:activate() 
    else
      hs.alert.show("'" .. appName .. "' has no standard windows.")
    end
    return -- Exit the function
  end

  -- At this point, we know the app is running and has at least one standard window.
  local frontmostApp = hs.application.frontmostApplication()

  -- If the app is not in front, or if it only has one window, just activate the app.
  -- This brings the entire application forward.
  if frontmostApp:name() ~= appName or #appWindows == 1 then
    app:activate()
    -- Focusing the single window is good practice to ensure it's raised above other windows.
    if #appWindows == 1 then
        appWindows[1]:focus()
    end
  else
    -- The app is already in front and has multiple windows, so we cycle.
    local focusedWindow = app:focusedWindow()
    if not focusedWindow then -- A fallback in case no window has focus for some reason.
        appWindows[1]:focus()
        return
    end

    -- Find the currently focused window's position in our list of standard windows.
    local currentIndex = hs.fnutils.indexOf(appWindows, focusedWindow)
    
    -- If the focused window isn't in our list (e.g., it's a palette we filtered out),
    -- then we'll just focus the first standard window from our list as a default.
    if not currentIndex then
        appWindows[1]:focus()
        return
    end

    -- Calculate the next window's index, wrapping around to the beginning if necessary.
    local nextIndex = (currentIndex % #appWindows) + 1
    
    -- Focus the next window in the cycle.
    appWindows[nextIndex]:focus()
  end
end


-- =============================================================================
-- Define Your Hotkeys
-- =============================================================================
-- By passing 'true' as the second argument to cycleAppWindows, all of these
-- hotkeys will now launch the application if it's not already running.

-- System
hs.hotkey.deleteAll({"ctrl"}, "e")
hs.hotkey.bind({"ctrl"}, "e", function() cycleAppWindows("Finder", true) end)
hs.hotkey.deleteAll({"ctrl"}, "z")
hs.hotkey.bind({"ctrl"}, "z", function() cycleAppWindows("Terminal", true) end)
hs.hotkey.deleteAll({"ctrl"}, "s")
hs.hotkey.bind({"ctrl"}, "s", function() cycleAppWindows("System Settings", true) end)

-- Browsers
hs.hotkey.deleteAll({"ctrl"}, "f")
hs.hotkey.bind({"ctrl"}, "f", function() cycleAppWindows("Firefox", true) end)
hs.hotkey.deleteAll({"ctrl"}, "g")
hs.hotkey.bind({"ctrl"}, "g", function() cycleAppWindows("Google Chrome", true) end)
hs.hotkey.deleteAll({"ctrl"}, "h")
hs.hotkey.bind({"ctrl"}, "h", function() cycleAppWindows("Safari", true) end)

-- Editors (Text, Code, Notes)
hs.hotkey.deleteAll({"ctrl"}, "a")
hs.hotkey.bind({"ctrl"}, "a", function() cycleAppWindows("Anytype", true) end)
-- hs.hotkey.deleteAll({"ctrl"}, "n")
-- hs.hotkey.bind({"ctrl"}, "n", function() cycleAppWindows("MacVim", true) end)
hs.hotkey.deleteAll({"ctrl"}, "n")  -- Notepad
hs.hotkey.bind({"ctrl"}, "n", function() cycleAppWindows("Lapce", true) end)
hs.hotkey.deleteAll({"ctrl"}, "v")
hs.hotkey.bind({"ctrl"}, "v", function() cycleAppWindows("Visual Studio Code", true) end)
hs.hotkey.deleteAll({"ctrl"}, "x")
hs.hotkey.bind({"ctrl"}, "x", function() cycleAppWindows("Windsurf", true) end)

-- Microsoft
hs.hotkey.deleteAll({"ctrl"}, "t")
hs.hotkey.bind({"ctrl"}, "t", function() cycleAppWindows("Microsoft Teams", true) end)
hs.hotkey.deleteAll({"ctrl"}, "w")
hs.hotkey.bind({"ctrl"}, "w", function() cycleAppWindows("Microsoft Word", true) end)
hs.hotkey.deleteAll({"ctrl"}, "p")
hs.hotkey.bind({"ctrl"}, "p", function() cycleAppWindows("Microsoft Powerpoint", true) end)

hs.hotkey.deleteAll({"ctrl"}, "q")
hs.hotkey.bind({"ctrl"}, "q", function() cycleAppWindows("Microsoft 365 Copilot", true) end)

-- Other
hs.hotkey.deleteAll({"ctrl"}, "i")
hs.hotkey.bind({"ctrl"}, "i", function() cycleAppWindows("PaintZ", true) end)


hs.hotkey.deleteAll({"ctrl"}, "c")
hs.hotkey.bind({"ctrl"}, "c", function()
  cycleAppWindows("Microsoft Outlook", true);
  hs.eventtap.keyStroke({"cmd"}, '2')   -- focus calendar
 end)

hs.hotkey.deleteAll({"ctrl"}, "m")
hs.hotkey.bind({"ctrl"}, "m", function()
  cycleAppWindows("Microsoft Outlook", true);
  hs.eventtap.keyStroke({"cmd"}, '1')   -- focus mail
 end)

