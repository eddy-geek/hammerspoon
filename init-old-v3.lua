-- =============================================================================
-- App-Specific Window Cycler
-- =============================================================================

-- Define a function to cycle through an application's windows
local function cycleAppWindows(appName)
  local app = hs.application.get(appName)
  if not app then
    hs.alert.show("'" .. appName .. "' is not running.")
    return
  end

  local frontmostApp = hs.application.frontmostApplication()
  local allAppWindows = app:allWindows()
  
  -- Filter out windows that aren't standard, to avoid things like tool palettes
  local appWindows = hs.fnutils.filter(allAppWindows, function(w)
    return w:isStandard() and not w:isMinimized()
  end)

  if #appWindows == 0 then
    hs.alert.show("'" .. appName .. "' has no windows.")
    return
  end

  -- If the app is not in front, or only has one window, just focus it.
  if frontmostApp:name() ~= appName or #appWindows <= 1 then
    app:activate()
    -- app:launchOrFocus()

    if #appWindows == 1 then
        appWindows[1]:focus()
    end
  else
    -- App is already in front and has multiple windows, so we cycle.
    local focusedWindow = app:focusedWindow()
    if not focusedWindow then -- Should not happen if app is frontmost
        appWindows[1]:focus()
        return
    end

    -- Find the current window's position in our list
    local currentIndex = hs.fnutils.indexOf(appWindows, focusedWindow)

    -- Calculate the next window's index, wrapping around if needed
    local nextIndex = (currentIndex % #appWindows) + 1
    
    -- Focus the next window
    appWindows[nextIndex]:focus()
  end
end


-- =============================================================================
-- Define Your Hotkeys
-- =============================================================================

-- Clear previous bindings to avoid duplicates on reload

hs.hotkey.deleteAll({"ctrl"}, "e")
hs.hotkey.bind({"ctrl"}, "e", function() cycleAppWindows("Finder") end)
hs.hotkey.bind({"ctrl", "shift"}, "e", function() hs.application.open("Finder") end)
hs.hotkey.deleteAll({"ctrl"}, "g")
hs.hotkey.bind({"ctrl"}, "g", function() cycleAppWindows("Google Chrome") end)
hs.hotkey.deleteAll({"ctrl"}, "h")
hs.hotkey.bind({"ctrl"}, "h", function() cycleAppWindows("Safari") end)
hs.hotkey.deleteAll({"ctrl"}, "f")
hs.hotkey.bind({"ctrl"}, "f", function() cycleAppWindows("Firefox") end)
hs.hotkey.deleteAll({"ctrl"}, "c")
hs.hotkey.bind({"ctrl"}, "c", function() cycleAppWindows("Microsoft Teams") end)
hs.hotkey.deleteAll({"ctrl"}, "m")
hs.hotkey.bind({"ctrl"}, "m", function() cycleAppWindows("Microsoft Outlook") end)
hs.hotkey.deleteAll({"ctrl"}, "z")
hs.hotkey.bind({"ctrl"}, "z", function() cycleAppWindows("Terminal") end)
hs.hotkey.deleteAll({"ctrl"}, "s")
hs.hotkey.bind({"ctrl"}, "s", function() cycleAppWindows("System Settings") end)
hs.hotkey.deleteAll({"ctrl"}, "a")
hs.hotkey.bind({"ctrl"}, "a", function() cycleAppWindows("Anytype") end)
hs.hotkey.deleteAll({"ctrl"}, "v")
hs.hotkey.bind({"ctrl"}, "v", function() cycleAppWindows("Visual Studio Code") end)
hs.hotkey.deleteAll({"ctrl"}, "w")
hs.hotkey.bind({"ctrl"}, "w", function() cycleAppWindows("Windsurf") end)

-- Show a confirmation that the config has been loaded
hs.alert.show("Hammerspoon config reloaded")
